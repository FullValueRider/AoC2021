VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "AutoKeyByIndex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@PredeclaredId
'@Exposed
'@Folder("AutoKeys")
Option Explicit

Implements IAutoKey

Const DefaultFirstUseIndex                  As Long = 1
Const AutoKeyByIndexName                    As string = "AutoKeyByIndex"


Private Type Properties

    FirstUseIndex                           As Long
    CurrentIndex                            As Variant
    KeysList                                As Lyst
    FirstUseKeyType                         As String
        
End Type

Private p                                   As Properties


Private Sub Class_Initialise()
End Sub

'@Description("Takes an iterable of the keys that are valid for this Kvp and the index of the first Key to use.  The Index is specified in 1 based indexing irrespective of the ipKeys iterable firsat/last index. A negative index is allowed.")
Public Function Deb(Optional ByRef ipKeys As Lyst, Optional ByVal ipFirstUseIndex As Variant) As AutoKeyByIndex
    
    If BailOut.When(VBA.IsMissing(ipKeys), Msg.UnexpectedEmpty) Then Exit Function
        
    With New AutoKeyByIndex
        
        Set Deb = .ReadyToUseInstance(ipKeys, ipFirstUseIndex)
            
    End With
        
End Function


Public Function ReadyToUseInstance(ByVal ipKeys As Variant, ByVal ipFirstuseIndex As Variant) As AutoKeyByIndex
  
    Globals.Res.SetNotOkay
    Set ReadyToUseInstance = Me
    
    SetKeysList ipKeys
    If Globals.Res.IsNotOkay Then Exit Function
        
    If VBA.IsMissing(ipFirstuseIndex) Then
        
        SetFirstUseIndex p.KeysList.FirstIndex
        
        
    Else
        
        SetFirstUseIndex ipFirstuseIndex
        
        
    End If
    
    If Globals.Res.IsNotOkay Then Exit Function
        
    Globals.Res.SetOkay
    Set ReadyToUseInstance = Me
    
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Interface
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Private Property Get IAutoKey_GetFirstUseKey() As Variant
    IAutoKey_GetFirstUseKey = GetFirstUseKey
End Property

Private Function IAutoKey_SetFirstUseKey(ByVal ipValue As Variant) As IAutoKey
  SetFirstUseKey ipValue
End Function

Private Property Get IAutoKey_CurrentKey() As Variant
    IAutoKey_CurrentKey = CurrentKey
End Property

Friend Property Let IAutoKey_CurrentKey(ByVal ipValue As Variant)
    CurrentKey = ipValue
End Property

Private Function IAutoKey_Clone() As IAutoKey
    Set IAutoKey_Clone = Clone
End Function

Private Function IAutoKey_NextKey() As Variant
    IAutoKey_NextKey = NextKey
End Function

Private Function IAutoKey_Name() As String
    IAutoKey_Name = Name
End Function

Private Property Get IAutoKey_FirstUseKeyType() As String
    IAutoKey_FirstUseKeyType = p.FirstUseKeyType
End Property

Private Function IAutoKey_NextKeys(ByVal ipCount As Long) As Lyst
    Set IAutoKey_NextKeys = NextKeys(ipCount)
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class public members
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@Description("Returns the first key used")
Public Function GetFirstUseKey() As Variant
Attribute GetFirstUseKey.VB_Description = "For AutoKeyByIndex, returns the Index of the first used key"

    GetFirstUseKey = Empty
    If p.KeysList Is Nothing Then Exit Function
   
    If VBA.IsObject(p.KeysList.Item(p.FirstUseIndex)) Then
        
        Set GetFirstUseKey = p.KeysList.Item(p.FirstUseIndex)
        
    Else
        
        GetFirstUseKey = p.KeysList.Item(p.FirstUseIndex)
        
    End If
     
End Function


'@Description("Set the key to be used first if no specific key if provided")
Friend Function SetFirstUseKey(ByVal ipKey As Variant) As AutoKeyByIndex
Attribute FirstUseKey.VB_Description = "For AutoKeyByIndex, takes the Index of the first used key"

    Set SetFirstUseKey = Me
    If BailOut.When(p.KeysList Is Nothing, Msg.HasNoInstance) Then Exit Function
    If BailOut.When(p.KeysList.LacksItem(ipKey), Msg.KeyNotFound) Then Exit Function
    
    SetFirstUseIndex p.KeysList.IndexOf(ipKey)
    If Globals.Res.IsNotOkay Then Exit Function
    
    Globals.Res.SetOkay
    Set SetFirstUseKey = Me
        
End Function
        
        
Friend Function SetFirstUseIndex(ByVal ipIndex As Long) As AutoKeyByIndex
    
    Set SetFirstUseIndex = Me
    If BailOut.When(p.KeysList Is Nothing, Msg.HasNoInstance) Then Exit Function
    
    ' Index is 1 based irrespective of the actual first/last index of the ipKeys iterable
    If Ranges.TryStartRunFromAnyStartRunEnd(p.KeysList, ipIndex).IsNotOkay Then Exit Function
    
    p.FirstUseIndex = Globals.Res.Item(ResultItemsEnums.StartRun(srStartindex))
    p.FirstUseKeyType = TypeName(p.KeysList.Item(p.FirstUseIndex))
    p.CurrentIndex = Empty
        
    Set SetFirstUseIndex = Me
    
End Function


Public Property Get CurrentKey() As Variant
    
    If VBA.IsEmpty(p.CurrentIndex) Then
        
        CurrentKey = Empty
        
        
    ElseIf VBA.IsObject(p.KeysList.Item(p.CurrentIndex)) Then
        
        Set CurrentKey = p.KeysList.Item(p.CurrentIndex)
        
        
    Else
        
        CurrentKey = p.KeysList.Item(p.CurrentIndex)
        
        
    End If
    
End Property

Friend Property Let CurrentKey(ByVal ipValue As Variant)
    p.CurrentIndex = p.KeysList.IndexOf(ipValue)
End Property

Public Function Clone() As IAutoKey

    Dim myAutoKey As AutoKeyByIndex
    Set myAutoKey = Me.Deb(p.KeysList, p.FirstUseIndex)
        
    myAutoKey.CurrentKey = p.KeysList.Item(p.CurrentIndex)
    
    Set Clone = myAutoKey
        
End Function

Public Property Get NextKey() As Variant

    If VBA.IsEmpty(p.CurrentIndex) Then
        
        p.CurrentIndex = p.FirstUseIndex
        
            
    Else
        
        p.CurrentIndex = Inc(p.CurrentIndex)
        
            
    End If
        
    NextKey = p.KeysList.Item(p.CurrentIndex)
        
End Property


Public Function Name() As String
    Name = "AutoKeyByIndex"
End Function


Public Property Get FirstUseKeyType() As String
    FirstUseKeyType = p.FirstUseKeyType
End Property

'@Description("Sets the Keys list independently of object initialisation")
Public Function SetKeysList(ByVal ipKeysList As Lyst) As AutoKeyByIndex
        
    Set p.KeysList = Types.Iterable.ToLyst(ipKeysList)
    If BailOut.When(p.KeysList.HasNoItems, Msg.HasNoItems) Then Exit Function

    p.CurrentIndex = Empty
    p.FirstUseIndex = 0
    
    Globals.Res.SetOkay
    Set SetKeysList = Me
        
End Function


Public Function NextKeys(ByVal ipCount As Long) As Lyst
        
    Dim myList As Lyst
    Set myList = Lyst.Deb
    Set NextKeys = myList
        
    If BailOut.When(ipCount <= 0, Msg.CountCannotBeLessThanOne) Then Exit Function
            
    Dim myCounter As Long
    For myCounter = 1 To ipCount
            
        myList.Add NextKey
            
    Next
        
    Set NextKeys = myList
        
End Function


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class private members
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Private Function Inc(ByVal ipKeyIndex As Long) As Long

    If BailOut.When(VBA.IsEmpty(p.CurrentIndex), Msg.AutoKeyIsNotValid) Then Exit Function
        
    If ipKeyIndex = p.KeysList.LastIndex Then
        
        p.CurrentIndex = p.KeysList.FirstIndex
        
        
    Else
        
        p.CurrentIndex = p.CurrentIndex + 1
        
            
    End If
    
    Inc = p.CurrentIndex

End Function

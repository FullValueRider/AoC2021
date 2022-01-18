VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "AutoKeyByNumber"
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

Const DefaultFirstKey                           As Long = 1
Const AutokeyByNumberName                       As String = "AutoKeyByNumber"

' Private Type ReadOnly
  
'   DefaultKey                                  As Long
  
' End Type

Private Type Properties

    FirstUseKey                               As Variant
    CurrentKey                                As Variant
    FirstUseKeyType                           As String
    
    
End Type

Private p                                     As Properties

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class admin
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Private Sub Class_Initialize()
End Sub

Public Function Deb(Optional ByVal ipFirstUseKey As Variant = Defaultfirstkey) As AutoKeyByNumber
    ' Variant is used to allow any number type to be used as a Key
    With New AutoKeyByNumber
            
        Set Deb = .ReadyToUseInstance(ipFirstUseKey)

    End With
        
End Function

Public Function ReadyToUseInstance(ByVal ipFirstUseKey As Variant) As AutoKeyByNumber
  
    Globals.Res.SetNotOkay
    Set ReadyToUseInstance = Me
    
    SetFirstUseKey ipFirstUseKey
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

Friend Function IAutoKey_SetFirstUseKey(ByVal ipValue As Variant) As IAutoKey
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

Public Property Get IAutoKey_FirstUseKeyType() As String
    IAutoKey_FirstUseKeyType = p.FirstUseKeyType
End Property

Private Function IAutoKey_NextKeys(ByVal ipCount As Long) As Lyst
    Set IAutoKey_NextKeys = NextKeys(ipCount)
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class body
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Public Function GetFirstUseKey() As Variant
    GetFirstUseKey = p.FirstUseKey
End Function

Friend Function SetFirstUseKey(ByVal ipValue As Variant) As IAutoKey
    
    Set SetFirstUseKey = Me
    If BailOut.When(VBA.IsEmpty(ipValue), Msg.UnexpectedEmpty) Then Exit Function
        
    p.FirstUseKey = ipValue
    p.FirstUseKeyType = TypeName(ipValue)
    p.CurrentKey = Empty
    
    Globals.Res.SetOkay
    Set SetFirstUseKey = Me
    
End Function

Public Property Get CurrentKey() As Variant
    CurrentKey = p.CurrentKey
End Property

Friend Property Let CurrentKey(ByVal ipValue As Variant)
    p.CurrentKey = ipValue
End Property


Public Function Clone() As IAutoKey

    Dim myAutoKey As AutoKeyByNumber
    Set myAutoKey = Me.Deb(p.FirstUseKey)
        
    myAutoKey.CurrentKey = p.CurrentKey
        
    Set Clone = myAutoKey
        
End Function


Public Property Get NextKey() As Variant

    If VBA.IsEmpty(p.CurrentKey) Then
        
        p.CurrentKey = p.FirstUseKey
            
    Else
        
        p.CurrentKey = Inc(p.CurrentKey)
            
    End If
        
    NextKey = p.CurrentKey
        
End Property

Public Function Name() As String
    Name = AutokeyByNumberName
End Function

Public Property Get FirstUseKeyType() As String
    FirstUseKeyType = p.FirstUseKeyType
End Property

Public Function NextKeys(ByVal ipCount As Long) As Lyst
        
    Dim myList As Lyst
    Set myList = Lyst.Deb
    Set NextKeys = myList
        
    If ipCount <= 0 Then Exit Function
            
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
Private Function Inc(ByVal ipKey As Variant) As Variant
    Inc = ipKey + 1
End Function
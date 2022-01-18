VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "AutoKeyByString"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Preamble
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' DefaultKeyCharSequence is used for incrementing string keys.
' e.g 0009->000A->000z->0010.
' Incrementing is done by the Index position and not by character value
' hence for a char sequence of "a0b2c3d4etc" we get 0002->000c->0003->000d
' Characters not in the sequence are ignored for the purposes of
' incrementing BUT characters are inserted after the ignored character
' if required by a rollover e.g. #z ->#10 not 1#0
'

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@PredeclaredId
'@Exposed
'@Folder("AutoKeys")

Option Explicit

Implements IAutoKey

Const DefaultFirstUseKey                    As String = "0000"
Const AutoKeyByStringName                   As String = "AutoKeyByString"

Private Type Properties

    FirstUseKey                             As Variant
    CurrentKey                              As Variant
    KeyAllowedChars                         As ROL
  '  KeyAsChars                              As Lyst
    FirstUseKeyType                         As String
  '  Result                                  As Result
End Type

Private p                                   As Properties

Private Sub Class_Initialise()

'    r.DefaultFirstUseKey = "0000"
'    Set r.DefaultAllowedCharListForKey = Strs.AlphaNumList

End Sub

Public Function Deb(Optional ByVal ipFirstUseKey As String, Optional ByVal ipallowedkeychars As String) As AutoKeyByString

    If VBA.Len(ipFirstUseKey) = 0 Then
        
        ipFirstUseKey = DefaultFirstUseKey
        
    End If
    
    If VBA.Len(ipallowedkeychars) = 0 Then
        ipallowedkeychars = Strs.AlphanumChars
    End If
        
    With New AutoKeyByString
        
        Set Deb = .ReadyToUseInstance(ipFirstUseKey, ipallowedkeychars) ' Why is ipKeyCharsequence a null string
            
    End With
        
End Function


Public Function ReadyToUseInstance(ByVal ipFirstUseKey As String, ByVal ipKeyCharList As String) As AutoKeyByString
   
    Globals.Res.SetNotOkay
    Set ReadyToUseInstance = Nothing
    
    SetFirstUseKey ipFirstUseKey
    If Globals.Res.IsNotOkay Then Exit Function
   
    SetKeyAllowedChars ROL.Deb(ipKeyCharList)
    If Globals.Res.IsNotOkay Then Exit Function
    
    Globals.Res.SetOkay
    Set ReadyToUseInstance = Me
        
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Interface
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Private Function IAutoKey_GetFirstUseKey() As Variant
    IAutoKey_GetFirstUseKey = GetFirstUseKey
End Function

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

Public Property Get IAutoKey_FirstUseKeyType() As String
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

Public Function GetFirstUseKey() As Variant
    GetFirstUseKey = p.FirstUseKey
End Function

Friend Function SetFirstUseKey(ByVal ipValue As Variant) As AutoKeyByString
    
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

Public Function GetKeyAllowedChars() As ROL
    Set GetKeyAllowedChars = p.KeyAllowedChars
End Function

Friend Function SetKeyAllowedChars(ByVal ipValue As ROL) As AutoKeyByString
    Globals.Res.SetNotOkay
    Set SetKeyAllowedChars = Nothing
    
    If BailOut.When(ipValue Is Nothing, Msg.HasNoInstance) Then Exit Function
    If BailOut.When(ipValue.HasNoItems, Msg.HasNoItems) Then Exit Function
    
    Set p.KeyAllowedChars = ipValue
    
    Globals.Res.SetOkay
    Set SetKeyAllowedChars = Me
    
End Function


Public Property Get FirstUseKeyType() As String
    FirstUseKeyType = p.FirstUseKeyType
End Property


Public Function Clone() As AutoKeyByString
    
    Dim myAutoKey As AutoKeyByString
    Set myAutoKey = Me.Deb(p.FirstUseKey)
    myAutoKey.SetKeyAllowedChars p.KeyAllowedChars
    myAutoKey.CurrentKey = p.CurrentKey

    Set Clone = myAutoKey
        
End Function


Public Property Get NextKey() As Variant

    If VBA.IsEmpty(p.CurrentKey) Then
        
        p.CurrentKey = p.FirstUseKey
            
    Else
        
        p.CurrentKey = Strs.Inc(p.CurrentKey, p.KeyAllowedChars)
            
    End If
        
    NextKey = p.CurrentKey
        
End Property

Public Function Name() As String
    Name = AutoKeyByStringName
End Function

Public Function NextKeys(ByVal ipCount As Long) As Lyst
        
    Dim myList As Lyst
    Set myList = Lyst.Deb
    Set NextKeys = myList
        
    If ipCount <= 0 Then Exit Function
            
    Dim myCounter As Long
    For myCounter = 1 To ipCount
            
        myList.Add NextKey
            
    Next
        
End Function



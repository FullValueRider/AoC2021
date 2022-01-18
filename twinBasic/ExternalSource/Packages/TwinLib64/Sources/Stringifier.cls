VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Stringifier"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Static class: Repository for non standard conversions methods"
'@IgnoreModule FunctionReturnValueAlwaysDiscarded
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("Helpers")
'@ModuleDescription "Static class: Repository for non standard conversions methods"
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C

Private Const mcMethods                 As String = "ToString,ToJSon,ToJson,JSon,Json,Value,value"
'Private Const mcLocation                As String = "VBALib.Stringifier"

Public Enum MarkupEnum

    ARRAY_SEPARATOR = 0
    ARRAY_LEFT = 1
    ARRAY_RIGHT = 2

End Enum

Private Type State

    ItemSeparator           As String
    ArrayOpen               As String
    ArrayClose              As String
    ArrayItemSeperator      As String
    ObjectOpen              As String
    ObjectClose             As String
    ObjectItemSeperator     As String
        
End Type

Private s                   As State

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Class admin
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Public Sub Class_Initialize()

    If Me Is Stringifier Then

        ResetMarkup
            
    End If

End Sub

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Implementation
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Friend Sub ResetMarkup()
        
    ResetArrayMarkup
    ResetObjectMarkup
    ResetItemSeparator
        
            
        
End Sub

Public Function ResetArrayMarkup _
       ( _
       Optional ByVal ipOpen_twLBracket As Variant, _
       Optional ByVal ipClose_twRBracket As Variant, _
       Optional ByVal ipSeparator_twComma As Variant _
       ) As Stringifier
    With s
        
        .ArrayOpen = IIf(VBA.IsMissing(ipOpen_twLBracket), Char.twLBracket, ipOpen_twLBracket)
        .ArrayClose = IIf(VBA.IsMissing(ipClose_twRBracket), Char.twRBracket, ipClose_twRBracket)
        .ArrayItemSeperator = IIf(VBA.IsMissing(ipSeparator_twComma), Char.twComma, ipSeparator_twComma)
            
    End With
        
    Set ResetArrayMarkup = Me
        
End Function

Public Function ResetObjectMarkup _
       ( _
       Optional ByVal ipOpen_twLCurly As Variant, _
       Optional ByVal ipClose_twRCurly As Variant, _
       Optional ByVal ipSeparator_twComma As Variant _
       ) As Stringifier
    With s
        
        .ObjectOpen = IIf(VBA.IsMissing(ipOpen_twLCurly), Char.twLCurly, ipOpen_twLCurly)
        .ObjectClose = IIf(VBA.IsMissing(ipClose_twRCurly), Char.twRCurly, ipClose_twRCurly)
        .ObjectItemSeperator = IIf(VBA.IsMissing(ipSeparator_twComma), Char.twComma, ipSeparator_twComma)
            
    End With
        
    Set ResetObjectMarkup = Me
        
End Function

Public Function ResetItemSeparator(Optional ByVal ipSeparator_twComma As Variant) As Stringifier

    s.ItemSeparator = IIf(VBA.IsMissing(ipSeparator_twComma), Char.twComma, ipSeparator_twComma)
        
    Set ResetItemSeparator = Me
        
End Function

'@Description("Converts the parameters a single string.")
Public Function ToString(ParamArray ipArgs() As Variant) As String
Attribute ToString.VB_Description = "Converts the parameters a single string."
    
    ToString = ToStringByIterable(ipArgs)
    
End Function

Public Function ToStringByIterable(ByVal ipIterable As Variant) As String
' The difference to ToString is that the single iterable doesn't get treated as an object
        
    ToStringByIterable = vbNullString
    Dim myItems As Lyst
    Set myItems = Lyst.Deb
    myItems.AddKnownIterableAsItems ipIterable
    'If Globals.Res.IsNotOkay Then Exit Function
        
    If myItems.HasNoItems Then Exit Function
  
    ' Convert each item in ipParamArray to a string representation
    Dim myitem As Variant
    Dim myIterableAsString As Lyst
    Set myIterableAsString = Lyst.Deb
        
    For Each myitem In ipIterable
                
        Select Case True
          
          Case Types.Group.IsIterable(myitem)
                  
            myIterableAsString.AddKnownItemsAsItems StringifyIterable(myitem)
              
          
          Case VBA.IsObject(myitem)
                
            myIterableAsString.AddKnownItemsAsItems StringifyNonIterableObject(myitem)
              
            
          Case Types.Group.IsAdmin(myitem)
                  
            myIterableAsString.AddKnownItemsAsItems StringifyAdmin(myitem)
            
            
          Case Types.Group.IsPrimitive(myitem)
              
              myIterableAsString.AddKnownItemsAsItems StringifyPrimitive(myitem)
              
 
          Case Else
                  
              'todo: Add error message for unknown type
              Debug.Print "Missing error message in ToString"
              Stop
                      
        End Select
            
    Next
        
    ToStringByIterable = VBA.Join(myIterableAsString.ToArray, s.ItemSeparator)
        
    ResetMarkup
        
End Function

Friend Function StringifyPrimitive(ByVal ipPrimitive As Variant) As String
        
    StringifyPrimitive = CStr(ipPrimitive)
        
End Function


Friend Function StringifyAdmin(ByVal ipAdmin As Variant) As String

    Select Case True
                
        Case VBA.Information.IsEmpty(ipAdmin)
                
            StringifyAdmin = Types.Name.OfEmpty
                
                    
        Case Types.IsNothing(ipAdmin)
                
            StringifyAdmin = s.ObjectOpen & "Nothing" & s.ObjectClose

                    
        Case Types.IsNull(ipAdmin)
            
            StringifyAdmin = Types.Name.OfNull
                
                    
        Case Types.IsUnknown(ipAdmin)
                
            StringifyAdmin = Types.Name.OfUnknown
                    
                    
        Case VBA.Information.IsError(ipAdmin)
                    
            StringifyAdmin = _
                s.ObjectOpen _
                & VBA.Join _
                ( _
                    Array _
                    ( _
                        Char.twPlainDQuote & Types.Name.OfError & Char.twPlainDQuote, _
                        Err.Source, _
                        CStr(Err.Number), _
                        Err.Description _
                    ), _
                    s.ItemSeparator _
                ) _
                & s.ObjectClose

    End Select
        
End Function

Friend Function StringifyIterable(ByRef ipIterable As Variant) As String

    'ResetArrayMarkup
    StringifyIterable = vbNullString
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
        
    Dim myOpen As String
    Dim myClose As String
    Dim mySeparator As String
    If VBA.IsArray(ipIterable) Then
        
        myOpen = s.ArrayOpen
        myClose = s.ArrayClose
        mySeparator = s.ArrayItemSeperator
    Else
        
        myOpen = s.ObjectOpen
        myClose = s.ObjectClose
        mySeparator = s.ObjectItemSeperator
            
    End If

    Select Case True
        
        Case Types.Group.IsIterableItemsByEnum(ipIterable)
            
            Set myLyst = GetIterableItemsByEnumAsLystOfStrings(ipIterable)
                
                    
        Case Types.Group.IsIterableKeysByEnum(ipIterable)
                
            Set myLyst = GetIterableKeysByEnumAsLystOfStrings(ipIterable)
                
                    
        Case Else
                
           Stop 'ToDo add unknown type
                
                    
    End Select
        
    StringifyIterable = myOpen & myLyst.ToString(mySeparator) & myClose
    'StringifyIterable = myOpen & VBA.Join(myLyst.ToArray, mySeparator) & myClose
        
End Function

Friend Function GetIterableItemsByEnumAsLystOfStrings(ByVal ipIterable As Variant) As Lyst

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
        
    Dim myitem As Variant
    For Each myitem In ipIterable
        
        myLyst.AddKnownItemsAsItems ToString(myitem)
            
    Next
        
    Set GetIterableItemsByEnumAsLystOfStrings = myLyst
            
End Function

Friend Function GetIterableKeysByEnumAsLystOfStrings(ByVal ipIterable As Variant) As Lyst

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
        
    Dim myKey As Variant
    For Each myKey In ipIterable.Keys
        
        Dim myKeyStr As String
        myKeyStr = ToString(myKey)
            
        Dim myItemStr As String
        myItemStr = ToString(ipIterable.Item(myKey))
            
        myLyst.AddKnownItemsAsItems Char.twPlainDQuote & myKeyStr & Char.twPlainDQuote & Char.twColon & Char.twSpace & myItemStr
            
    Next

    Set GetIterableKeysByEnumAsLystOfStrings = myLyst

End Function

' Friend Function GetLystOfIterableItemsByIndexStrings(ByVal ipIterable As Variant) As Lyst

'     Dim myLyst As Lyst
'     Set myLyst = Lyst.Deb
        
'     Dim myIndex As Long
'     Dim myResult As Result
'     If Types.Iterable.TryExtent(ipIterable, myResult).Failed Then Exit Function
            
        
'     For myIndex = myResult.Item(Types.Iterable.GetConst(TryFirstIndexResult)) To myResult.Item(ExtentResult.IsFirstIndex) 'item 0 is startindex
        
'         myLyst.AddValidatedItem ToString(ipIterable(myIndex))
            
'     Next
        
'     Set GetLystOfIterableItemsByIndexStrings = myLyst
        
' End Function


'@Description("Trys to get string description of a non iterable object. Defaullt result is '{Object "Name"}'"
Friend Function StringifyNonIterableObject(ByVal ipObject As Object) As String

    Dim myMethods As Variant
    myMethods = VBA.Split(mcMethods, Char.twComma)
        
    Dim myString As String
        
    Dim myMethod As Variant
    For Each myMethod In myMethods
        
        On Error Resume Next
        myString = CallByName(ipObject, myMethod, vbGet)
        If Err.Number = 0 Then
            
            StringifyNonIterableObject = s.ObjectOpen & myString & s.ObjectClose
            On Error GoTo 0
            Exit Function
                
        End If
            
        On Error GoTo 0
        On Error Resume Next
        myString = CallByName(ipObject, myMethod, vbMethod)
        If Err.Number = 0 Then
            
            StringifyNonIterableObject = s.ObjectOpen & myString & s.ObjectClose
            On Error GoTo 0
            Exit Function
                
        End If
        
        On Error GoTo 0
            
    Next
        
    ' MyStringAssignment is for the err.number side effect
    On Error Resume Next
        
    'try default method
    '@Ignore ImplicitUnboundDefaultMemberAccess, AssignmentNotUsed
    myString = ipObject
    If Err.Number = 0 Then
        
        On Error GoTo 0
        StringifyNonIterableObject = s.ObjectOpen & myString & s.ObjectClose
        Exit Function
            
    End If
        
    On Error GoTo 0
    StringifyNonIterableObject = s.ObjectOpen & Types.Name.OfObject & Char.twSpace & Char.twPlainDQuote & TypeName(ipObject) & Char.twPlainDQuote & s.ObjectClose
            
End Function

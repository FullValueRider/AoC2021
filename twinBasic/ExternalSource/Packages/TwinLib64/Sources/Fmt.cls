VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Fmt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Enables limited sttring interpolation"
Option Explicit
'@Folder("StringyStuff")
'@PredeclaredId
'@Exposed
'@ModuleDescription("Enables limited sttring interpolation")

'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' This module enables fields within strings which represent variables or
' formatting instructions
'
' Variables are indicated by {x} where x is a positive integer.
' e.g.
'       Fmt("this string {0} {1}", "Hello", 9)
'
' gives 'this string Hello 9'
'
' Layout fields are of the form {zzx}
' where zz can be
'       nl = new line
'       nt = newline followed by a tab
'       tb = tab
'       sq = single ordinary quote
'       dq = double ordinary quote
'       so = single smart quote - open
'       sc = single smart quote - close
'       do = double smart quote - open
'       dc = double smart quote - close
'       x  = the number of times a formatting character is repeated.
'
' If no 'x' is provided then a single layout character is used
' For 'nt' the 'x' refers to the number of newlines.  Only a single tab is inserted
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'ToDo: This class is too complicated.  Ir would be simplet to split ipTemplate
'into an array using '{' as the split at character
' as the split character.  This will then allow each field to be processed in a much more straighforward manner.
' messy characters - definitions
' Private Const DOUBLE_QUOTE                      As String = """"
' Private Const SINGLE_QUOTE                      As String = "'"
' Private Const SMART_SINGLE_QUOTE_OPEN           As String = "?" ' Alt+0145
' Private Const SMART_SINGLE_QUOTE_CLOSE          As String = "?" ' Alt+0146
' Private Const SMART_DOUBLE_QUOTE_OPEN           As String = "?" ' Alt+0147
' Private Const SMART_DOUBLE_QUOTE_CLOSE          As String = "?" ' Alt+0148

' required because, depending on usage,  an empty variant can be converted to
' nothing rather than an empty string
'Private Const NoString                          As String = ""
Private Const NoFailMessage                     As String = "No error message was provided"

Private Type State

    FormatFields                                As Object 'scripting.dictionary

End Type

Private s                                       As State


'Private Type Using
'
'    Cvt                                         As Stringifier
'
'End Type
'
'Private u                                       As Using



'Field openers - definitions
Private Const NEWLINES                           As String = "{nl"
Private Const TABS                               As String = "{tb"
Private Const NEWLINES_TAB                       As String = "{nt" ' 1 or more newlines followed by one Tab
Private Const DQUOTE                             As String = "{dq"
Private Const SQUOTE                             As String = "{sq"
Private Const SMART_SQUOTE_OPEN                  As String = "{so"
Private Const SMART_SQUOTE_CLOSE                 As String = "{sc"
Private Const SMART_DQUOTE_OPEN                  As String = "{do"
Private Const SMART_DQUOTE_CLOSE                 As String = "{dc"

' Field closures - definitions
Private Const FIELD_COUNT_IS_NONE                   As String = "}"
Private Const FIELD_COUNT_IS_ZERO               As String = "0}"
Private Const FIELD_COUNT_IS_ONE                      As String = "1}"

'Private Const DEFAULT_SEPARATOR                          As String = ","
'Private Const DEFAULT_ARRAY_MARKUP                       As String = ",[]"
Public Sub Class_Initialize()

    '    If u.Cvt Is Nothing Then
    '
    '        Set u.Cvt = Stringifier
    '
    '    End If
        
    If s.FormatFields Is Nothing Then
        
        Set s.FormatFields = New Scripting.Dictionary
        
    Else
        
        Exit Sub
            
    End If
        
    With s.FormatFields
        
        .Add NEWLINES, vbCrLf                    ' {nl
        .Add TABS, vbTab                         ' {tb
        .Add NEWLINES_TAB, vbCrLf                ' {nt
        .Add DQUOTE, Char.twPlainDQuote                ' {dq
        .Add SQUOTE, Char.twPlainSQuote                ' {sq
        .Add SMART_SQUOTE_OPEN, Char.twLSmartSQuote ' {so
        .Add SMART_SQUOTE_CLOSE, Char.twRSmartSQuote ' {sc
        .Add SMART_DQUOTE_OPEN, Char.twLSMartDQuote ' {do
        .Add SMART_DQUOTE_CLOSE, Char.twRSmartDQuote ' {dc
            
    End With
        
End Sub

'@Description("Converts string with variable and layout fields send to Debug.Print"}
'@Ignore ProcedureNotUsed
Public Sub Dbg _
       ( _
       ByVal ipFormatTemplate As String, _
       ParamArray ipParamarray() As Variant _
       )
        
    If Len(ipFormatTemplate) = 0 Then
        
        Debug.Print Stringifier.ToString(Lyst.Deb.AddRange(ipParamarray))
            
    Else
        
        Debug.Print pvGetFormattedParameters(ipFormatTemplate, CVar(ipParamarray))
            
    End If

End Sub

Public Function TxtArr _
       ( _
       ByVal ipFormatTemplate As String, _
       ByVal ipArray As Variant _
       ) As String

    If VBA.Len(ipFormatTemplate) = 0 Then
        
        TxtArr = NoFailMessage
            
    Else
        
        TxtArr = pvGetFormattedParameters(ipFormatTemplate, ipArray)
            
    End If
        
End Function

'@Description("Converts string with variable and layout fields to text"}
'@Ignore ProcedureNotUsed
Public Function Txt _
       ( _
       ByVal ipFormatTemplate As String, _
       ParamArray ipParamarray() As Variant _
       ) As String
        
    If VBA.Len(ipFormatTemplate) = 0 Then
        
        Txt = Stringifier.ToString(Lyst.Deb.AddRange(ipParamarray))
            
    Else
        
        Txt = pvGetFormattedParameters(ipFormatTemplate, CVar(ipParamarray))
            
    End If

End Function

Friend Function pvGetFormattedParameters(ByVal ipFormatTemplate As String, ByVal ipParameters As Variant) As String

    '@Ignore AssignmentNotUsed
    Dim myReturn  As String
    myReturn = ConvertFormatFieldXX0ToNoString(ipFormatTemplate)
    myReturn = pvConvertFormatFieldWithNoCountToCountOfOne(myReturn)
    myReturn = ConvertFormatFieldWithCountToFormatCharacters(myReturn)
    myReturn = pvConvertVariableFieldsToStringRepresentations(myReturn, ipParameters)
    ' Debug.Print myReturn
        
    pvGetFormattedParameters = myReturn
        
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Methods below need to be made public for the test module to run correctly
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@Description("Replace formatting fields of the form '{XX0}' with NoString")
Friend Function ConvertFormatFieldXX0ToNoString(ByVal ipLayoutTemplate As String) As String
Attribute ConvertFormatFieldXX0ToNoString.VB_Description = "Replace formatting fields of the form '{XX0}' with NoString"

    Dim myLayoutTemplate                        As String
    Dim myitem                                  As Variant

    myLayoutTemplate = ipLayoutTemplate
        
    For Each myitem In s.FormatFields.Keys
        
        myLayoutTemplate = VBA.Replace(myLayoutTemplate, myitem & FIELD_COUNT_IS_ZERO, Char.twNoString)
            
    Next

    ConvertFormatFieldXX0ToNoString = myLayoutTemplate
        
End Function

'@Description("Convert non numbered LayoutObj.Format fields {XX} to {XX1}")
'@Ignore AssignedByValParameter
Friend Function pvConvertFormatFieldWithNoCountToCountOfOne(ByVal ipFormatTemplate As String) As String
Attribute pvConvertFormatFieldWithNoCountToCountOfOne.VB_Description = "Convert non numbered LayoutObj.Format fields {XX} to {XX1}"

    Dim myitem                              As Variant

    For Each myitem In s.FormatFields.Keys
        
        ipFormatTemplate = VBA.Replace(ipFormatTemplate, myitem & FIELD_COUNT_IS_NONE, myitem & FIELD_COUNT_IS_ONE)
            
    Next
        
    pvConvertFormatFieldWithNoCountToCountOfOne = ipFormatTemplate
        
End Function

'@Description("return the number in a format field")
Friend Function GetRepeatCountForFormatField(ByRef ipFormatTemplate As String, ByVal ipFormatField As String) As Long
Attribute GetRepeatCountForFormatField.VB_Description = "return the number in a format field"

    Dim myFormatFieldRepeatLocation         As Long
    Dim myRepeatCount                       As String

    myFormatFieldRepeatLocation = InStr(ipFormatTemplate, ipFormatField) + Len(ipFormatField)
        
    Do While VBA.Mid$(ipFormatTemplate, myFormatFieldRepeatLocation, 1) Like "#"
            
        myRepeatCount = myRepeatCount & VBA.Mid$(ipFormatTemplate, myFormatFieldRepeatLocation, 1)
        myFormatFieldRepeatLocation = myFormatFieldRepeatLocation + 1
            
    Loop
        
    GetRepeatCountForFormatField = CLng(myRepeatCount)
        
End Function

'@Description("Convert {XXn} layout field to fomatting characters 'XX' repeated 'n' times")
Friend Function ConvertFormatFieldWithCountToFormatCharacters(ByRef ipFormatTemplate As String) As String
Attribute ConvertFormatFieldWithCountToFormatCharacters.VB_Description = "Convert {XXn} layout field to fomatting characters 'XX' repeated 'n' times"

    Dim myitem                              As Variant
    Dim myReplace                           As String
    Dim myField                             As String
    Dim myCount                             As Long

    For Each myitem In s.FormatFields.Keys
                
        If InStr(ipFormatTemplate, myitem) > 0 Then
            
            myCount = GetRepeatCountForFormatField(ipFormatTemplate, myitem)
            myField = myitem & CStr(myCount) & "}"
            myReplace = pvGetFormattingReplaceString(myitem, myCount)
            ipFormatTemplate = VBA.Replace(ipFormatTemplate, myField, myReplace)
                
        End If
        
    Next
                
    ConvertFormatFieldWithCountToFormatCharacters = ipFormatTemplate
        
End Function

'@Description("Returns a string of formatting characters in line with the formatting tag")
Friend Function pvGetFormattingReplaceString(ByVal ipFormatString As String, ByVal ipRepeatCount As Long) As String
Attribute pvGetFormattingReplaceString.VB_Description = "Returns a string of formatting characters in line with the formatting tag"
        
    Dim myReturn                        As String

    myReturn = VBA.String$(ipRepeatCount, s.FormatFields.Item(ipFormatString))
    If ipFormatString = NEWLINES_TAB Then
        
        myReturn = myReturn & vbTab
        
    End If
        
    pvGetFormattingReplaceString = myReturn
        
End Function

'@Description("Replace each ocurrence of '{<number>}' with the corresponding stringified item from the parameters list")
Friend Function pvConvertVariableFieldsToStringRepresentations _
       ( _
       ByVal ipFormatTemplate As String, _
       ByVal ipArgs As Variant _
       ) As String
Attribute pvConvertVariableFieldsToStringRepresentations.VB_Description = "Replace each ocurrence of '{<number>}' with the corresponding stringified item from the parameters list"

    Dim myIndex                         As Variant
    Dim myargs                          As Variant
    Dim myReturn                        As String

    myargs = ipArgs
    myReturn = ipFormatTemplate
        
    For myIndex = 0 To UBound(myargs)
                
        Dim myFind As String
        myFind = "{" & CStr(myIndex) & "}"
            
        Dim myReplace As String
        myReplace = Stringifier.ToString(myargs(myIndex))
            
        myReturn = VBA.Replace(myReturn, myFind, myReplace)

    Next
        
    pvConvertVariableFieldsToStringRepresentations = myReturn
        
End Function

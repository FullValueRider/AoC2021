VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "eChar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit

''@IgnoreModule
'@PredeclaredId
'@Exposed
'@Folder("Enums")

Public Enum AscIICode
    'This enumeration defines character descriptions in terms of thier AscII value
    'twNoString
    twNUL = &H00
    twSOH
    twSTX
    twETX
    twEOT
    twENQ
    twACK
    twBEL
    twBS
    twHT
    twLF
    twVT
    twFF
    twCR
    twSS
    twSI
    twDLE
    twDC1
    twDC2
    twDC3
    twDC4
    twNAK
    twSYN
    twETB
    twCAN
    twEM
    twSUB
    twESC
    twFS
    twGS
    twRS
    twUS
    twSP
    
    twExcl = &H21             ' !
    twQuot                  ' "
    twHash                  ' #    
    twDollar                ' $
    twPercent               ' %
    twAmp                   ' &
    twApos                  ' '
    twLParen                ' (
        
    twRParen                ' )
    twAsterix               ' *
    twPlus                  ' +
    twComma                 ' ,
    twMinus                 ' -
    twPeriod                ' .
    twSlash                 ' /
    
    twColon = &H3A          ' :
    twSemiColon             ' ;
    twLT                    ' <
    twEQ                    ' =
    twGT                    ' >
    twQuery                 ' ?
    twAt                    ' @
    
    twSpace
    twHyphen
    
    twLBracket = &H5B        ' [
    twBackslash             ' \    
    twRBracket              ' ]
    twCircumflex            ' ^
    twLowLine
    twGrave
    
    twLCurly = &H7B           ' {
    twVBar                  ' |  ' check this
    twRCurly = &H7D           ' }
    twTilde                 ' ~
    
    ' characters after the ' may not appear correctly following a round trip to VBA
    twNBSpace = &HA0        '  
    twInvertedExcl          ' ¡
    twCent                  ' ¢
    twPound                 ' £
    twCurrency              ' ¤
    twYen                   ' ¥
    twBrokenBar             ' ¦
    twSection               ' §
    twUmlaut                ' ¨
    twCopyright             ' ©
    twFemaleOrd             ' ª
    twLDoubleArrow          ' «
    twNot                   ' ¬
    twSoftHyphen            ' ­
    twRegistered            ' ®
    twMacron                ' ¯
    twDegree                ' °
    twPlusMinus             ' ±
    twssTwo                 ' ²
    twssThree               ' ³
    twAcute                 ' ´
    twMicro                 ' µ
    twPilcrow               ' ¶
    twMiddleDot             ' ·
    twCedil                 ' ¸
    twssOne                 ' ¹
    twMasculineOrd          ' º
    twRDoubleArrow          ' »
    
    twLSmartSQuote = 145
    twRSmartSQuote = 146
    twLSMartDQuote = 147
    twRSmartDQuote = 148
    
        
End Enum

Private Type State
        
    'Actions                 As Scripting.Dictionary
    Strings                 As Scripting.Dictionary
        
End Type

Private s                   As State


Private Sub Class_Initialise()
        
    'r.Location = "VBALib.Enums."
    'If BailOut.When(Me Is eChar) Then Exit Sub
    SetupDictionaries
        
End Sub

Private Sub SetupDictionaries()
        
    Set s.Strings = CreateObject("Scripting.Dictionary")
    With s.Strings
        
    .Add twNUL, ChrW$(twNUL)
    .Add twSOH, ChrW$(twSOH)
    .Add twSTX, ChrW$(twSTX)
    .Add twETX, ChrW$(twETX)
    .Add twEOT, ChrW$(twEOT)
    .Add twENQ, ChrW$(twENQ)
    .Add twACK, ChrW$(twACK)
    .Add twBEL, ChrW$(twBEL)
    .Add twBS, ChrW$(twBS)
    .Add twHT, ChrW$(twHT)
    .Add twLF, ChrW$(twLF)
    .Add twVT, ChrW$(twVT)
    .Add twFF, ChrW$(twFF)
    .Add twCR, ChrW$(twCR)
    .Add twSS, ChrW$(twSS)
    .Add twSI, ChrW$(twSI)
    .Add twDLE, ChrW$(twDLE)
    .Add twDC1, ChrW$(twDC1)
    .Add twDC2, ChrW$(twDC2)
    .Add twDC3, ChrW$(twDC3)
    .Add twDC4, ChrW$(twDC4)
    .Add twNAK, ChrW$(twNAK)
    .Add twSYN, ChrW$(twSYN)
    .Add twETB, ChrW$(twETB)
    .Add twCAN, ChrW$(twCAN)
    .Add twEM, ChrW$(twEM)
    .Add twSUB, ChrW$(twSUB)
    .Add twESC, ChrW$(twESC)
    .Add twFS, ChrW$(twFS)
    .Add twGS, ChrW$(twGS)
    .Add twRS, ChrW$(twRS)
    .Add twUS, ChrW$(twUS)
    .Add twSP, ChrW$(twSP)
            
    .Add twExcl, ChrW$(twExcl)
    .Add twQuot, ChrW$(twQuot)
    .Add twHash, ChrW$(twHash)
    .Add twDollar, ChrW$(twDollar)
    .Add twPercent, ChrW$(twPercent)
    .Add twAmp, ChrW$(twAmp)
    .Add twApos, ChrW$(twApos)
    .Add twLParen, ChrW$(twLParen)
                        
    .Add twRParen, ChrW$(twRParen)
    .Add twAsterix, ChrW$(twAsterix)
    .Add twPlus, ChrW$(twPlus)
    .Add twComma, ChrW$(twComma)
    .Add twMinus, ChrW$(twMinus)
    .Add twPeriod, ChrW$(twPeriod)
    .Add twSlash, ChrW$(twSlash)
        
            
    .Add twColon, ChrW$(twColon)
    .Add twSemiColon, ChrW$(twSemiColon)
    .Add twLT, ChrW$(twLT)
    .Add twEQ, ChrW$(twLT)
    .Add twGT, ChrW$(twGT)
    .Add twQuery, ChrW$(twQuery)
    .Add twAt, ChrW$(twAt)
    
    
    .Add twLBracket, ChrW$(twLBracket)
    .Add twBackslash, ChrW$(twBackslash)
    .Add twRBracket, ChrW$(twRBracket)
    .Add twCircumflex, ChrW$(twCircumflex)
    .Add twLowLine, ChrW$(twLowLine)
    .Add twGrave, ChrW$(twGrave)
    
    .Add twLCurly, ChrW$(twLCurly)
    .Add twVBar, ChrW$(twVBar)
    .Add twRCurly, ChrW$(twRCurly)
    .Add twTilde, ChrW$(twTilde)
    
    ' characters after the ' may not appear correctly following a round trip to VBA
    .Add twNBSpace, ChrW$(twNBSpace)
    .Add twInvertedExcl, ChrW$(twInvertedExcl)
    .Add twCent, ChrW$(twCent)
    .Add twPound, ChrW$(twPound)
    .Add twCurrency, ChrW$(twCurrency)
    .Add twYen, ChrW$(twYen)
    .Add twBrokenBar, ChrW$(twBrokenBar)
    .Add twSection, ChrW$(twSection)
    .Add twUmlaut, ChrW$(twUmlaut)
    .Add twCopyright, ChrW$(twCopyright)
    .Add twFemaleOrd, ChrW$(twFemaleOrd)
    .Add twLDoubleArrow, ChrW$(twLDoubleArrow)
    .Add twNot, ChrW$(twNot)
    .Add twSoftHyphen, ChrW$(twSoftHyphen)
    .Add twRegistered, ChrW$(twRegistered)
    .Add twMacron, ChrW$(twMacron)
    .Add twDegree, ChrW$(twDegree)
    .Add twPlusMinus, ChrW$(twPlusMinus)
    .Add twssTwo, ChrW$(twssTwo)
    .Add twssThree, ChrW$(twssThree)
    .Add twAcute, ChrW$(twAcute)
    .Add twMicro, ChrW$(twMicro)
    .Add twPilcrow, ChrW$(twPilcrow)
    .Add twMiddleDot, ChrW$(twMiddleDot)
    .Add twCedil, ChrW$(twCedil)
    .Add twssOne, ChrW$(twssOne)
    .Add twMasculineOrd, ChrW$(twMasculineOrd)
    .Add twRDoubleArrow, ChrW$(twRDoubleArrow)
            
        
    .Add twLSmartSQuote, ChrW$(twLSmartSQuote)
    .Add twRSmartSQuote, ChrW$(twRSmartSQuote)
    .Add twLSMartDQuote, ChrW$(twLSMartDQuote)
    .Add twRSmartDQuote, ChrW$(twRSmartDQuote)
        
    End With
        
End Sub

Public Function Chars() As Variant
    Chars = s.Strings.Items
End Function

Public Function Members() As Variant
    Members = s.Strings.Keys
End Function

' Public Function Actions() As Variant
'     Actions = s.Actions.Items
' End Function

Public Function Ord(ByVal ipEnum As AscIICode) As Long
        
    Dim myitem As Variant
    Dim myOrd As Long
    myOrd = 1
    For Each myitem In s.Strings.Keys
            
        If myitem = ipEnum Then
                
            Ord = myOrd
            Exit Function
                
        Else
            
            myOrd = myOrd + 1
                
        End If
            
    Next
        
End Function

Public Property Get AsEnum(ByVal ipEnum As AscIICode) As AscIICode
    AsEnum = ipEnum
End Property

Public Property Get Char(ByVal ipEnum As AscIICode) As String
    If enums.Message.HoldsMember(ipEnum) Then
        Char = s.Strings.Item(ipEnum)
    Else
        Char = vbNullString
    End If
End Property


Public Function HoldsMember(ByVal ipEnum As AscIICode) As Boolean
    If s.Strings Is Nothing Then SetupDictionaries
    HoldsMember = s.Strings.Exists(ipEnum)
End Function

Public Function LacksMember(ByVal ipEnum As AscIICode) As Boolean
    LacksMember = Not HoldsMember(ipEnum)
End Function


Public Property Get Name() As String
    Name = TypeName(Me)
End Property

Public Property Get Count() As Long
    If s.Strings Is Nothing Then SetupDictionaries
    Count = s.Strings.Count
End Property' add your member fields and procedures here


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ArrayMarkup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("Lib.Fmt")
Private Type Properties

    Separator                   As String
    LeftParen                   As String
    RightParen                  As String
    
End Type

Private p                       As Properties

Public Function Deb _
       ( _
       Optional ByVal ipSeparator_twComma As Variant, _
       Optional ByVal ipLParen_twLBracket As Variant, _
       Optional ByVal ipRParen_twRBracket As Variant _
       ) As ArrayMarkup

    ipSeparator_twComma = IIf(VBA.IsMissing(ipSeparator_twComma), Char.twComma, ipSeparator_twComma)
    ipLParen_twLBracket = IIf(VBA.IsMissing(ipLParen_twLBracket), Char.twComma, ipLParen_twLBracket)
    ipRParen_twRBracket = IIf(VBA.IsMissing(ipRParen_twRBracket), Char.twComma, ipRParen_twRBracket)

    With New ArrayMarkup
    
        Set Deb = .ReadyToUseInstance(ipSeparator_twComma, ipLParen_twLBracket, ipRParen_twRBracket)
        
    End With
    
End Function

Public Function ReadyToUseInstance _
       ( _
       ByVal ipSeperator As String, _
       ByVal ipLParen As String, _
       ByVal ipRParen As String _
       ) As ArrayMarkup
    
    p.Separator = ipSeperator
    p.LeftParen = ipLParen
    p.RightParen = ipRParen
    
    Set ReadyToUseInstance = Me
    
End Function

Public Property Get Separator() As String
    Separator = p.Separator
End Property

Public Property Get LParen() As String
    LParen = p.LeftParen
End Property

Public Property Get RParen() As String
    RParen = p.RightParen
End Property

Public Function Clone() As ArrayMarkup

    Dim myAM As ArrayMarkup
    Set myAM = Me.Deb(p.Separator, p.LeftParen, p.RightParen)

    Set Clone = myAM
    
End Function

Public Function ToString() As String
    ToString = Fmt.Txt("{ {0} , {1} , {2} }", p.Separator, p.LeftParen, p.RightParen)
End Function



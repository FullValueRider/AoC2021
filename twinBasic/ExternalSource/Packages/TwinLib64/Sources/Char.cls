VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Char"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib")
'Readonly values - Pseudo constants
Public Function twNoString() As String: twNoString = "": End Function
Public Function twBar() As String: twBar = "|": End Function
Public Function twComma() As String: twComma = ",": End Function
Public Function twPeriod() As String: twPeriod = ".": End Function
Public Function twSpace() As String: twSpace = " ": End Function
Public Function twHyphen() As String: twHyphen = "-": End Function
Public Function twColon() As String: twColon = ":": End Function
Public Function twSemiColon() As String: twSemiColon = ";": End Function
Public Function twHash() As String: twHash = "#": End Function
Public Function twPlus() As String: twPlus = "+": End Function
Public Function twAsterix() As String: twAsterix = "*": End Function
Public Function twLParen() As String: twLParen = "(": End Function
Public Function twRParen() As String: twRParen = ")": End Function
Public Function twLBracket() As String: twLBracket = "[": End Function
Public Function twRBracket() As String: twRBracket = "]": End Function
Public Function twLCurly() As String: twLCurly = "{": End Function
Public Function twRCurly() As String: twRCurly = "}": End Function
Public Function twPlainDQuote() As String: twPlainDQuote = """": End Function
Public Function twPlainSQuote() As String: twPlainSQuote = "'": End Function
Public Function twLSmartSQuote() As String: twLSmartSQuote = ChrW$(145): End Function ' Alt+0145
Public Function twRSmartSQuote() As String: twRSmartSQuote = ChrW$(146): End Function ' Alt+0146
Public Function twLSMartDQuote() As String: twLSMartDQuote = ChrW$(147): End Function ' Alt+0147
Public Function twRSmartDQuote() As String: twRSmartDQuote = ChrW$(148): End Function ' Alt+0148

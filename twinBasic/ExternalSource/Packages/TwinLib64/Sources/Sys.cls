VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sys"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "A place for useful VBA things not explicitly provided by VBA"
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib")
   
'@ModuleDescription("A place for useful VBA things not explicitly provided by VBA")

'@Ignore ConstantNotUsed
' Public Function MaxLong() As Long:MaxLong = &H7FFFFFFF:End Function
' Public Function MinLong() As Long:MinLong = &HFFFFFFFF:End Function

' Public Function NotOkay() As Boolean: NotOkay = False: End Function
' Public Function Okay() As Boolean:Okay = True:End Function

' Public Function NotANumber() As String:NotANumber = "NaN":End Function

Public Function AsOneItem(ByVal ipIterable As Variant) As Variant
    AsOneItem = Array(ipIterable)
End Function

Public Function IsTrue(ByVal ipExpression As Boolean) As Boolean
    IsTrue = ipExpression
End Function

Public Function IsNotTrue(ByVal ipexpression As Boolean) As Boolean
    IsNotTrue = Not IsTrue(ipexpression)
End Function
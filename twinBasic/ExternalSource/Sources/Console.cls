VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Console"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@IgnoreModule

Public Sub Log(ByVal ipTemplate As String, ParamArray ipArgs() As Variant)
    
    Debug.Print Fmt.TxtArr(ipTemplate, ipArgs)
    
End Sub
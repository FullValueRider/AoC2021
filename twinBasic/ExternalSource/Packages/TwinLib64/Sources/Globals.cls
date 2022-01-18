VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Globals"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "A friend class for Items that need to be available globally within TwinLib64"
'@Exposed
'@ModuleDescription "A friend class for Items that need to be available globally within TwinLib64"
'@PredeclaredId
' @Folder("Result")
Option Explicit

' GRes is Result object available library wise.
Private Type Properties
    
    Result As Result
    
End Type

Private p                                        As Properties

Private Sub Class_Initialize()
    
    If p.Result Is Nothing Then Set p.Result = Result.Deb
        
End Sub

Friend Property Get Res() As Result
    If p.Result Is Nothing Then
         Set p.Result = Result.Deb
    End If
    Set Res = p.Result
End Property

' Friend Property Set Res(ByRef ipResult As Result)
'     Set p.Result = ipResult
' End Property

Public Function Extent() As ResultExtent
    Set Extent = ResultExtent.Deb(p.Result.Items.Clone)
End Function

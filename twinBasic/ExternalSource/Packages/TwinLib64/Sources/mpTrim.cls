VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpTrim"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
''@IgnoreModule
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Mappers")

Private Type State

    TrimChars                   As Variant
        
End Type

Private s                       As State

Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Private Sub Class_Initialize()
    s.TrimChars = Array(" ")
End Sub

Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant

    If VBA.VarType(ipHostItem) <> vbString Then
        ExecMapper = ipHostItem
        Exit Function
        
    End If
    
    ExecMapper = Strs.Trimmer(ipHostItem, s.TrimChars)
        
End Function

Public Function Deb(ParamArray ipArgs() As Variant) As mpTrim

    With New mpTrim
            
        Set Deb = .ReadyToUseInstance(CVar(ipArgs))
            
    End With
            
End Function

Friend Function ReadyToUseInstance(ByRef ipArgs As Variant) As mpTrim
        
    s.TrimChars = ipArgs
    Set ReadyToUseInstance = Me
        
End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpToUpper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Mappers")
    
Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMap(ipHostItem)
End Function

Public Function ExecMap(ByVal ipHostItem As Variant) As Variant
        
    If VBA.VarType(ipHostItem) <> vbString Then
            
        ExecMap = ipHostItem
         
    Else
            
        '@Ignore UntypedFunctionUsage
        ExecMap = VBA.UCase(ipHostItem)
            
    End If
        
End Function

Public Function Deb() As mpToUpper
    
    With New mpToUpper
            
        Set Deb = .ReadyToUseInstance
            
    End With
            
    
End Function

Friend Function ReadyToUseInstance() As mpToUpper
        
    Set ReadyToUseInstance = Me
        
End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpToLower"
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
        ExecMap = LCase(ipHostItem)
            
    End If
        
End Function

Public Function Deb() As mpToLower
    
    With New mpToLower
            
        Set Deb = .ReadyToUseInstance
            
    End With
            
    
End Function

Friend Function ReadyToUseInstance() As mpToLower
        
    Set ReadyToUseInstance = Me
        
End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpToLystOfChar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Mappers")
    
'Private Type State
'
'    Separator                       As String
'    Count                           As Long
'    Compare                         As VbCompareMethod
'
'End Type
'
'Private s                           As State
    
Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    Set IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
        
    If VBA.VarType(ipHostItem) <> vbString Then
            
        ExecMapper = ipHostItem
        Exit Function
            
            
    End If
        
    Set ExecMapper = Strs.ToCharLyst(ipHostItem)
        
End Function

Public Function Deb() As mpToLystOfChar
    
    With New mpToLystOfChar
            
        Set Deb = .ReadyToUseInstance()
            
    End With
            
    
End Function

Friend Function ReadyToUseInstance() As mpToLystOfChar
        
    Set ReadyToUseInstance = Me
        
        
End Function

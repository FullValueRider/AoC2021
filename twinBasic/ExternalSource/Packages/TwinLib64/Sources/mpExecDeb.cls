VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpExecDeb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib.Mappers")
Implements IMapper
    
Private Type State
        
    PredeclaredId                       As Object
        
        
End Type

Private s                               As State


Public Function Deb(ByRef ipPredeclaredId As Object) As mpExecDeb
        
    With New mpExecDeb
        
        Set Deb = .ReadyToUseInstance(ipPredeclaredId)
            
    End With
        
End Function


Friend Function ReadyToUseInstance(ByRef ipPredeclaredId As Object) As mpExecDeb
        
    Set s.PredeclaredId = ipPredeclaredId
    Set ReadyToUseInstance = Me
        
End Function


Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    
    Set IMapper_ExecMapper = ExecMapper(ipHostItem)
    
End Function


Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
     
    Set ExecMapper = s.PredeclaredId.Deb(ipHostItem)
       
End Function

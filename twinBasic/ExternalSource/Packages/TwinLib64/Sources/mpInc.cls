VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpInc"
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
        
    Increment                       As Variant
        
        
End Type

Private s                           As State

Public Function Deb(Optional ByVal ipIncrement As Variant = 1) As mpInc
        
    With New mpInc
        
        Set Deb = .ReadyToUseInstance(ipIncrement)
            
    End With
        
End Function

Friend Function ReadyToUseInstance(ByVal ipIncrement As Variant) As mpInc
        
    s.Increment = ipIncrement
    Set ReadyToUseInstance = Me
        
End Function

'@Description("Adds the value in ipArgsArray(0) to each item in the Lyst.  If the host item is not a number the string NAN is returned")
Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
Attribute IMapper_ExecMapper.VB_Description = "Adds the value in ipArgsArray(0) to each item in the Lyst.  If the host item is not a number the string NAN is returned"
    Set IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
        
    If Types.Group.IsNotNumber(ipHostItem) Then
            
        ExecMapper = ipHostItem
            
            
    Else
            
        ExecMapper = ipHostItem + s.Increment
            
            
    End If
       
        
End Function

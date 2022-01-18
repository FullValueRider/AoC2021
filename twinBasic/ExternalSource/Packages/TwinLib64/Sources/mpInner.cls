VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpInner"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Mappers")

Private Type State

    Mapper                  As IMapper
        
End Type

Private s                   As State

Implements IMapper

'@Description("if the lyst item is a Kvp or Lyst calls the map method with ipmapper")
Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
Attribute IMapper_ExecMapper.VB_Description = "if the lyst item is a Kvp or Lyst calls the map method with ipmapper"
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant

    Dim myTypeName As String
    myTypeName = TypeName(ipHostItem)
    Select Case myTypeName
        
        Case "Kvp", "Lyst"
                
            ExecMapper = ipHostItem.MapIt(mpInner.Deb(s.Mapper))
                    
                
        Case Else
            
            ExecMapper = s.Mapper.ExecMapper(ipHostItem)
        
            
    End Select
        
End Function

'@DefaultMember
Public Function Deb(ByVal ipMapper As IMapper) As IMapper
Attribute Deb.VB_UserMemId = 0
    
    With New mpInner
        
        Set Deb = .ReadyToUseInstance(ipMapper)
            
    End With

End Function

Friend Function ReadyToUseInstance(ByRef ipMapper As IMapper) As mpInner
        
    Set s.Mapper = ipMapper
    Set ReadyToUseInstance = Me
            
End Function

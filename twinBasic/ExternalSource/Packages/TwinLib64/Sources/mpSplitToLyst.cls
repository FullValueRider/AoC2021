VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpSplitToLyst"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@ModuleDescription"Splits a string to a lyst of substrings)
'@Exposed
'@PredeclaredId
''@IgnoreModule
'@Folder("VBALib.Mappers")


Private Type State

    Separator                   As String
        
End Type

Private s                       As State

    
Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    Set IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Public Function ExecMapper(ByVal ipHostItem As String) As Variant

    If Types.IsString(ipHostItem) Then
        
        Set ExecMapper = Lyst.Deb.AddRange(VBA.Split(ipHostItem, s.Separator))
            
    Else
            
        ExecMapper = ipHostItem
        
    End If
        
End Function

'@DefaultMember
Public Function Deb(Optional ByVal ipSeparator As String = ",") As mpSplitToLyst
Attribute Deb.VB_UserMemId = 0
    
    With New mpSplitToLyst

        Set Deb = .ReadyToUseInstance(ipSeparator)
            
    End With
    
End Function

Friend Function ReadyToUseInstance(ByVal ipSeparator As String) As mpSplitToLyst
        
    s.Separator = ipSeparator
    Set ReadyToUseInstance = Me
        
End Function

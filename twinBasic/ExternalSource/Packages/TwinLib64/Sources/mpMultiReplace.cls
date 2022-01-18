VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpMultiReplace"
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

    FindReplaceItems                 As Variant
        
End Type

Private s                       As State

Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMap(ipHostItem)
End Function

Public Function ExecMap(ByVal ipHostItem As Variant) As Variant

    ExecMap = ipHostItem
    If VBA.VarType(ipHostItem) <> vbString Then Exit Function
        
    ExecMap = Strs.MultiReplacer(ipHostItem, s.FindReplaceItems)
        
End Function

'@Description("Takes a jagged array of find/replacepairs")
Public Function Deb(ParamArray ipFindReplaceItems() As Variant) As mpMultiReplace
Attribute Deb.VB_Description = "Takes a jagged array of find/replacepairs"

    With New mpMultiReplace
            
        Set Deb = .ReadyToUseInstance(ipFindReplaceItems)
            
    End With
            
End Function

Friend Function ReadyToUseInstance(ByRef ipFindReplaceItems As Variant) As mpMultiReplace
        
    s.FindReplaceItems = ipFindReplaceItems
    Set ReadyToUseInstance = Me
        
End Function

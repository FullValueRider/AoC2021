VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpDedup"
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

    DedupItems                 As Lyst
        
End Type

Private s                       As State

Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMap(ipHostItem)
End Function

Private Sub Class_Initialize()
    Set s.DedupItems = Lyst.Deb.AddKnownItemsAsItems(" ")
End Sub

Public Function ExecMap(ByVal ipHostItem As Variant) As Variant

    If VBA.VarType(ipHostItem) <> vbString Then
    
        ExecMap = ipHostItem
        Exit Function
        
    End If
    
    ExecMap = Strs.Dedup(ipHostItem, s.DedupItems)
        
End Function

Public Function Deb(ParamArray ipDedupItems() As Variant) As mpDedup

    With New mpDedup
            
        Set Deb = .ReadyToUseInstance(CVar(ipDedupItems))
            
    End With
            
End Function

Friend Function ReadyToUseInstance(Optional ByRef ipDedupItems As Lyst) As mpDedup
        
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipDedupItems) Then Set ipDedupItems = Lyst.Deb.AddKnownItemsAsItems(Char.twSpace)
    If ipDedupItems.HasNoItems Then Set ipDedupItems = Lyst.Deb.AddKnownItemsAsItems(Char.twSpace)
    Set s.DedupItems = ipDedupItems
    Set ReadyToUseInstance = Me
        
End Function

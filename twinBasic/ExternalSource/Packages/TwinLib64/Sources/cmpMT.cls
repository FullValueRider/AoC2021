VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cmpMT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("Comparers")
    
Implements IComparer

Private Type State

    Item                        As Variant
    Index                       As Variant
    
    
End Type

Private s                       As State

Private Function IComparer_ExecCmp(ByRef ipHostItem As Variant) As Boolean
    IComparer_ExecCmp = ExecCmp(ipHostItem)
End Function

Public Function ExecCmp(ByRef ipHostItem As Variant) As Boolean
        
    '@Ignore IsMissingWithNonArgumentParameter
    If VBA.IsMissing(s.Index) Then
        
        ExecCmp = ipHostItem > s.Item
        
    Else
  
        If Types.IsString(ipHostItem) Then
            
            '@Ignore UntypedFunctionUsage
            ExecCmp = VBA.Mid(ipHostItem, s.Index, 1) > s.Item
            
        ElseIf Types.Group.IsIterableByIndex(ipHostItem) Then
            
            ExecCmp = ipHostItem(s.Index) > s.Item
            
        Else
            
            ExecCmp = ipHostItem > s.Item
        
        End If
        
    End If
    
End Function


Public Function Deb(ByVal ipItem As Variant, Optional ByVal ipIndex As Variant) As cmpMT

    With New cmpMT
    
        Set Deb = .ReadyToUseInstance(ipItem, ipIndex)
        
    End With
    
End Function


Friend Function ReadyToUseInstance(ByVal ipItem As Variant, ByVal ipIndex As Variant) As cmpMT

    s.Item = ipItem
    s.Index = ipIndex
    Set ReadyToUseInstance = Me
    
End Function
    
Public Property Get Name() As String
  Name = TypeName(Me)
End Property

Private Function IComparer_Item() As Variant
  IComparer_Item = Item
End Function

Public Function Item() As Variant
  Item = s.Item
End Function

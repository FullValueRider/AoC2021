VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpSplit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Mappers")
    
Private Type State
    
    Separator                       As String
    Count                           As Long
    Compare                         As VbCompareMethod
        
End Type

Private s                           As State
    
Implements IMapper

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

Private Sub Class_Initialize()
    ' Allows mpSPlit to be used without calling .Deb
    s.Separator = " "
    s.Count = -1
    s.Compare = vbBinaryCompare
End Sub

Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
        
    If VBA.VarType(ipHostItem) <> vbString Then
            
        ExecMapper = ipHostItem
        Exit Function
            
            
    End If
        
    ExecMapper = VBA.Split(ipHostItem, s.Separator, s.Count, s.Compare)
        
End Function

Public Function Deb(Optional ByVal ipSeparator As String = " ", Optional ByVal ipCount As Long = -1, Optional ByVal ipCompare As VbCompareMethod = vbBinaryCompare) As mpSplit
    
    With New mpSplit
            
        Set Deb = .ReadyToUseInstance(ipSeparator, ipCount, ipCompare)
            
    End With
            
    
End Function

Friend Function ReadyToUseInstance(ByVal ipSeparator As String, ByVal ipCount As Long, ByVal ipCompare As VbCompareMethod) As mpSplit
        
    s.Separator = ipSeparator
    s.Count = ipCount
    s.Compare = ipCompare
    Set ReadyToUseInstance = Me
        
End Function

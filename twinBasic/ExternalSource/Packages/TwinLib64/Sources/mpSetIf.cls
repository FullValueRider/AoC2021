VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpSetIf"
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
  
  Comparer                        As IComparer
  Item                            As Variant
  
End Type


Private s                         As State


'TwinBasic requirement
Private Sub Class_Initialize()
  
  If s.Comparer Is Nothing Then
    
    Set s.Comparer = cmpEQ.Deb(0)
    
  End If
  
End Sub

Public Function Deb(Optional ByRef ipComparer As IComparer, Optional ByVal ipReset As Variant = 0) As mpSetIf
        
    With New mpSetIf
        
        Set Deb = .ReadyToUseInstance(ipComparer, ipReset)
            
    End With
        
End Function

Friend Function ReadyToUseInstance(ByRef ipComparer As IComparer, ByVal ipReset As Variant) As mpSetIf
    
    If s.Comparer Is Nothing Then
      
      Set s.Comparer = cmpEQ.Deb(0)
      
    Else
      
      Set s.Comparer = ipComparer
      
    End If
    
    s.Item = ipReset
    
    Set ReadyToUseInstance = Me
        
End Function

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

'@Description("Converts tthe items in the Lyst to Long Integers.  If the input item cannot be converted the string "NaN" is returned")
Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
        
    
        
    ExecMapper = IIf(s.Comparer.ExecCmp(ipHostItem), s.Item, ipHostItem)
        
End Function

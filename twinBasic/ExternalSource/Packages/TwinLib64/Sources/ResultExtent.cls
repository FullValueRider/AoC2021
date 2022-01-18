VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ResultExtent"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
''@IgnoreModule
'@Exposed
'@PredeclaredId
'@Folder("VBALib.Result")

Private Enum ItemsIndex
    
    iiFirstIndex = 0
    iiLastIndex
    iiCount
    
End Enum

Private Type Properties
    
    Items As ArrayList
    
    
End Type

Private p                           As Properties

Public Function Deb(ByVal ipitems As ArrayList) As ResultExtent
    
    With New ResultExtent
    
        Set Deb = .ReadyToUseInstance(ipitems)
    
    End With
    
End Function

Public Function ReadyToUseInstance(ByVal ipitems As ArrayList) As ResultExtent
    
    Set p.Items = ipitems
    Set ReadyToUseInstance = Me
    
End Function

Public Property Get FirstIndex() As Long
    FirstIndex = p.Items.Item(ItemsIndex.iiFirstIndex)
End Property


Public Property Get LastIndex() As Long
    LastIndex = p.Items.Item(ItemsIndex.iiLastIndex)
End Property


Public Property Get Count() As Long
    Count = p.Items.Item(ItemsIndex.iiCount)
End Property

Public Function Items() As ArrayList
    Set Items = p.Items.Clone
End Function
    

    
    
    
    
    
    
    
    
    
    
    
    
    

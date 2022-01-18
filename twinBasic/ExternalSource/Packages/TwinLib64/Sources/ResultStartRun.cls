VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ResultStartRun"
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
    
    iiStartIndex = 0
    iiRunLength
    
End Enum

Private Type Properties
    
    Items As ArrayList
    
    
End Type

Private p                           As Properties

Private Sub Class_Initialize()
    Set p.Items = New ArrayList
End Sub

Public Function Deb(ByVal ipitems As ArrayList) As ResultStartRun
    
    With New ResultStartRun
    
        Set Deb = .ReadyToUseInstance(ipitems)
    
    End With
    
End Function

Public Function ReadyToUseInstance(ByVal ipitems As ArrayList) As ResultStartRun
    
    Set p.Items = ipitems
    Set ReadyToUseInstance = Me
    
End Function

Public Property Get StartIndex() As Long
    StartIndex = p.Items.Item(iiStartIndex)
End Property


Public Property Get Run() As Long
    Run = p.Items.Item(iiRunLength)
End Property


Public Function Items() As ArrayList
    Set Items = p.Items.Clone
End Function

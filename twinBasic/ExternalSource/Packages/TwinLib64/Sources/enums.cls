VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "enums"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Provides a central location for providing complex enumerations"
Option Explicit
'@ModuleDescription("Provides a central location for providing complex enumerations")
'@Folder("Enums")
'@PredeclaredId
'@exposed
Private Sub Class_Initialize()
End Sub

' Complex enumerations are enumerations embedded in a class
Public Property Get Message() As eMessage
    Set Message = eMessage
End Property

Public Property Get TableToLystActions() As eTableToLystActions
    Set TableToLystActions = eTableToLystActions
End Property

' Public Property Get LookupConst() As eLookupConst
'     Set LookupConst = eLookupConst
' End Property

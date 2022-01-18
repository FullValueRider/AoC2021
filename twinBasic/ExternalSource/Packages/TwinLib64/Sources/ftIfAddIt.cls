VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ftIfAddIt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
 Option Explicit
 '@PredeclaredId
 '@Exposed
 '@Folder("VBALib.Filters")
' Implements IFilter
'
' Private Type State
'
'     CollectorLyst                   As Lyst
'
'
' End Type
' Private s                           As State
' Public Function Deb(ByRef ipCollectorLyst As Lyst) As ftIfAddIt
'
'     With New ftIfAddIt
'
'         Set Deb = .ReadyToUseInstance(ipCollectorLyst)
'
'     End With
'
' End Function
'
' Friend Function ReadyToUseInstance(ByRef ipComparer As IComparer) As ftIfAddIt
'
'     Set sCollector = ipComparer
'     Set ReadyToUseInstance = Me
'
' End Function
'
''@Description("Adds the value in ipArgsArray(0) to each item in the Lyst.  If the host item is not a number the string NAN is returned")
' Private Function IFilter_ExecFilter(ByRef ipHostItems As Lyst) As Lyst
'
'     Set IFilter_ExecFilter = ExecRed(ipHostItems)
' End Function
'
' Public Function ExecRed(ByVal ipHostItems As Lyst) As Lyst
'
'     Dim myLyst As Lyst
'     Set myLyst = Lyst.Deb
'
'    Dim myItem As Variant
'    For Each myItem In ipHostItems
'
'         If s.CollectorLyst.LacksItem(myItem) Then s.CollectorLyst.Add myItem
'
'    Next
'
'    Set ExecRed = myLyst
'
' End Function

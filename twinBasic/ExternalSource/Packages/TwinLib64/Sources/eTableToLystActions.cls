VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "eTableToLystActions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Folder("VBALib.Enums")
'@PredeclaredId
'@Exposed


'OK, so they are not constants but you know the intent.
Private Type InternalConstants
        
    Location                As String
        
End Type

'@Ignore MoveFieldCloserToUsage
Private ic                  As InternalConstants


Private Type State
        
    Action                  As Scripting.Dictionary
    Strings                 As Scripting.Dictionary
        
End Type

Private s                   As State

Private Sub Class_Initialize()
        
    ic.Location = "VBALib.EnumTableToLystActions."
    If BailOut.When(Not (Me Is enums.TableToLystActions), Msg.InvalidNew) Then Exit Sub
    SetupDictionaries
        
End Sub

Private Sub SetupDictionaries()
    ' Note: The predecalredId classes need to be assigned before they will register
    ' for extraction from the collection/dictionary
    ' hence the deb method (which just returns the predeclaredId instance
    ' but is sufficient to trigger initialisation without needing an assignment.
        
        
    Set s.Action = New Scripting.Dictionary
    With s.Action
        
        .Add RankIsColumnFirstItemActionIsNoAction, TableArrayToColumnLysts.Deb
        .Add RankIsRowFirstItemActionIsNoAction, TableArrayToRowLysts.Deb
        .Add RankIsColumnFirstItemActionIsCopy, TableArrayToColLystsCopyFirst.Deb
        .Add RankIsRowFirstItemActionIsCopy, TableArrayToRowLystsCopyFirst.Deb
        .Add RankIsColumnFirstItemActionIsSplit, TableArrayToColLystsSplitFirst.Deb
        .Add RankIsRowFirstItemActionIsSplit, TableArrayToRowLystsSplitFirst.Deb
        
    End With
        
    'Dim myItems As Variant
    'myItems = s.Action.Items
    'myItems = s.Action.Keys
        
        
    Set s.Strings = New Scripting.Dictionary
    With s.Strings
        
        .Add RankIsColumnFirstItemActionIsNoAction, "RankIsColumnNoFirstItemAction"
        .Add RankIsRowFirstItemActionIsNoAction, "RankIsRowNoFirstItemAction"
        .Add RankIsColumnFirstItemActionIsCopy, "RankIsColumnCopyFirstItem"
        .Add RankIsRowFirstItemActionIsCopy, "RankIsRowCopyFirstItem"
        .Add RankIsColumnFirstItemActionIsSplit, "RankIsColumnSplitFirstItem"
        .Add RankIsRowFirstItemActionIsSplit, "RankIsRowSplitFirstItem"
        
    End With
        
End Sub

Public Function Strings() As Variant
    Strings = s.Strings.Items
End Function

Public Function Members() As Variant
    Members = s.Strings.Keys
End Function

Public Function Actions() As Variant
    Actions = s.Action.Items
End Function

Public Function Ord(ByVal ipEnum As TableToLystAction) As Long
        
    Dim myitem As Variant
    Dim myOrd As Long
    myOrd = 1
    Ord = -1
    For Each myitem In s.Strings.Keys
            
        If myitem = ipEnum Then
                
            Ord = myOrd
            Exit Function
                
                
        Else
            
            myOrd = myOrd + 1
                
                
        End If
            
    Next
        
End Function

Public Property Get AsEnum(ByVal ipEnum As TableToLystAction) As TableToLystAction
    AsEnum = ipEnum
End Property

' Public Function CanExec(ByVal ipEnum As TableToLystAction) As Boolean
'     CanExec = VBA.IsObject(s.Action.Item(ipEnum))
' End Function


Public Property Get ToString(ByVal ipEnum As TableToLystAction) As String
    ToString = s.Strings.Item(ipEnum)
End Property

Public Property Get Action(ByVal ipEnum As TableToLystAction) As ITableToLystAction
    ' Dim myItems As Variant
    ' myItems = s.Action.Items
'    Dim myAction As Object
'    Set myAction = s.Action.Item(ipEnum)
    Set Action = s.Action.Item(ipEnum)
End Property

Public Property Get HoldsMember(ByVal ipValue As Long) As Boolean
    HoldsMember = s.Strings.Exists(ipValue)
End Property

Public Property Get LacksMember(ByVal ipValue As Long) As Boolean
    LacksMember = Not s.Strings.Exists(ipValue)
End Property

Public Property Get Name() As String
    Name = "TableToLystActions"
End Property

Public Property Get Count() As Long
    Count = s.Strings.Count
End Property

' Public Function Exec(ByVal ipEnum As TableToLystAction, ByVal ipTablearray As Variant) As Lyst
        
'     Guard ActionNotExecutable, Not CanExec(ipEnum), ic.Location & "Exec"
'     ' Debug.Print TypeName(s.Action.Item(ipEnum))
'     ' Dim myItems As Variant
'     ' myItems = s.Action.Items
'     ' Dim myObject As Object
'     ' Set myObject = s.Action.Item(ipEnum)
'     Set Exec = s.Action.Item(ipEnum).ExecAction(ipTablearray)
        
' End Function

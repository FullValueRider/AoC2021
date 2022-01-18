VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TableArrayToRowLystsCopyFirst"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'@PredeclaredId
'@Exposed
'@Folder("VBALib")
Option Explicit
Implements ITableToLystAction

Private Function ITableToLystAction_execAction(ByVal ipTablearray As Variant) As Lyst
    Set ITableToLystAction_execAction = ExecAction(ipTablearray)
End Function

Public Function Deb() As TableArrayToRowLystsCopyFirst
    Set Deb = Me
End Function

Public Function ExecAction(ByVal ipTablearray As Variant) As Lyst
      
    If BailOut.When(Arrays.IsNotTableArray(ipTablearray), Msg.IsNotTableArray) Then Exit Function
    Dim myLystOfRankLysts As Lyst
    Set myLystOfRankLysts = TableArrayToRowLysts.ExecAction(ipTablearray)
        
    Dim myRankFirstItemsLyst As Lyst
    Set myRankFirstItemsLyst = Lyst.Deb
        
    Dim myRankLysts As Lyst
    Set myRankLysts = Lyst.Deb
        
    Dim myitem As Variant
    For Each myitem In myLystOfRankLysts
            
        Dim myInnerLyst As Lyst
        Set myInnerLyst = myitem
        myRankFirstItemsLyst.AddKnownItemsAsItems myInnerLyst.First
        myRankLysts.AddKnownItemsAsItems myInnerLyst
            
    Next
        
    Set ExecAction = Lyst.Deb.AddKnownItemsAsItems(myRankFirstItemsLyst, myRankLysts)
        
End Function


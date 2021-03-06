VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TableArrayToColumnLysts"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@exposed
'@Folder("VBALib")
Implements ITableToLystAction

Private Function ITableToLystAction_execAction(ByVal ipTablearray As Variant) As Lyst
    Set ITableToLystAction_execAction = ExecAction(ipTablearray)
End Function

Public Function Deb() As TableArrayToColumnLysts
    Set Deb = Me
End Function

Public Function ExecAction(ByVal ipTablearray As Variant) As Lyst
        
    If BailOut.When(Arrays.IsNotTableArray(ipTablearray), Msg.IsNotTableArray) Then Exit Function
        
    Dim myFirstRow As Long
    myFirstRow = LBound(ipTablearray, 1)
        
    Dim myLastRow As Long
    myLastRow = UBound(ipTablearray, 1)
        
    Dim myFirstCol As Long
    myFirstCol = LBound(ipTablearray, 2)
        
    Dim myLastCol As Long
    myLastCol = UBound(ipTablearray, 2)
        
    Dim myLystOfLyst As Lyst
    Set myLystOfLyst = Lyst.Deb
    Dim myRow As Long
    Dim myCol As Long
    For myCol = myFirstCol To myLastCol
                
        Dim myInnerLyst As Lyst
        Set myInnerLyst = Lyst.Deb
        'myLystOfLyst.Add Lyst.Deb
            
        For myRow = myFirstRow To myLastRow
            
            myInnerLyst.AddKnownItemsAsItems ipTablearray(myRow, myCol)
            'myLystOfLyst.Item(myCol - myFirstCol).Add ipTableArray(myRow, myCol)
                
                
        Next
        
        myLystOfLyst.AddKnownItemsAsItems myInnerLyst.Clone
            
            
    Next
        
    Set ExecAction = myLystOfLyst
        
End Function


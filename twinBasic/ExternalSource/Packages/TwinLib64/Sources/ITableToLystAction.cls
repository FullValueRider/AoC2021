VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ITableToLystAction"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'@PredeclaredId

Option Explicit
'@Folder("Lyst")
'@Interface
'@Exposed

Public Enum TableToLystAction
                
    RankIsColumnFirstItemActionIsNoAction = 1
    RankIsRowFirstItemActionIsNoAction
    RankIsColumnFirstItemActionIsCopy
    RankIsRowFirstItemActionIsCopy
    RankIsColumnFirstItemActionIsSplit
    RankIsRowFirstItemActionIsSplit

End Enum

Public Enum AfterTableAction
    
    ActionIsNoActionRows = 1
    ActionIsSplitRows = 1
    ActionIsCopyRows = 1
    ActionIsSplitKeys = 2
    ActionIsCopyFirstKeys = 2
    
End Enum

Public Function ExecAction(ByVal ipTablearray As Variant) As Lyst
End Function


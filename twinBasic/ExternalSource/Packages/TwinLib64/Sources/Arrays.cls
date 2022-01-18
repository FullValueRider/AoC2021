VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Arrays"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@Folder("VBALib")
'@PredeclaredId
'@Exposed

'Public Const IsFirstRank As long = 1
'12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
    
' Public Enum ArrayAdmin
    
'     FirstRank = 1
        
' End Enum

' Private Type ReadOnly
        
'     Location As String

' End Type

' Private r                                     As ReadOnly


Public Enum ArrayDirections

    FourWay
    Eightway
        
End Enum

Public Enum RankOrientation

    ByRow
    ByColumn
        
End Enum

Private Sub Class_Initialize()
        
    ' If VBA.Len(r.Location) = 0 Then
            
    '     r.Location = "VBALib.Arrays."
            
            
    ' End If
        
   ' if BailOut.When( enums.Message.AsEnum(Msg.InvalidNew), Not (Me Is Arrays), r.Location & "Class_Initialise"
        
End Sub




    'ToDo: Move perimiter and associated functions to its own Area class
    ' ToDO use Lbound and Ubound to get min and max values
    '@Description("Returns an array of valid coordinates based on the provided x,y coordinate and the available area.")
Public Function GetPerimeterCoordinates _
       ( _
       ByVal ipCurRow As Long, _
       ByVal ipRowMin As Long, _
       ByVal ipRowMax As Long, _
       ByVal ipCurCol As Long, _
       ByVal ipColMin As Long, _
       ByVal ipColMax As Long, _
       ByVal ipType As ArrayDirections _
       ) As Variant
Attribute GetPerimeterCoordinates.VB_Description = "Returns an array of valid coordinates based on the provided x,y coordinate and the available area."

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
        
    If ipCurRow - 1 >= ipRowMin Then myLyst.Add Array(ipCurRow - 1, ipCurCol)
    If ipCurRow + 1 <= ipRowMax Then myLyst.Add Array(ipCurRow + 1, ipCurCol)
        
    If ipCurCol - 1 >= ipColMin Then myLyst.Add Array(ipCurRow, ipCurCol - 1)
    If ipCurCol + 1 <= ipColMax Then myLyst.Add Array(ipCurRow, ipCurCol + 1)

    If ipType = ArrayDirections.Eightway Then
        
        If ipCurRow - 1 >= ipRowMin And ipCurCol - 1 >= ipColMin Then myLyst.Add Array(ipCurRow - 1, ipCurCol - 1)
        If ipCurRow - 1 >= ipRowMin And ipCurCol + 1 <= ipColMax Then myLyst.Add Array(ipCurRow - 1, ipCurCol + 1)
            
        If ipCurRow + 1 <= ipRowMax And ipCurCol - 1 >= ipColMin Then myLyst.Add Array(ipCurRow + 1, ipCurCol - 1)
        If ipCurRow + 1 <= ipRowMax And ipCurCol + 1 <= ipColMax Then myLyst.Add Array(ipCurRow + 1, ipCurCol + 1)
            
                
    End If
        
    GetPerimeterCoordinates = myLyst.ToArrayList.ToArray
        
End Function

Public Function GetMoveCoordinates(ByVal ipType As ArrayDirections) As Scripting.Dictionary

    Dim myDirections As Scripting.Dictionary
    Set myDirections = New Scripting.Dictionary
        
    With myDirections
                
        .Add "N", Array(1, 0)
        .Add "E", Array(0, 1)
        .Add "S", Array(-1, 0)
        .Add "W", Array(0, -1)
                
        If ipType = ArrayDirections.Eightway Then
                
            .Add "NE", Array(1, 1)
            .Add "NW", Array(1, -1)
            .Add "SW", Array(-1, -1)
            .Add "SE", Array(-1, 1)
                    
                
        End If
            
    End With
        
    Set GetMoveCoordinates = myDirections

End Function

Public Function HasNoBounds(ByRef ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Boolean
    
    HasNoBounds = True
    If ipRank < 0 Then Exit Function
     
    On Error Resume Next
    Dim myTest As Boolean
    myTest = UBound(ipArray, ipRank) < LBound(ipArray, ipRank)
    If Err.Number <> 0 Then
        
        On Error GoTo 0
        Exit Function
        
    End If
    
    On Error GoTo 0
    
    HasNoBounds = myTest
    
End Function

Public Function RankHasNoItems(ByVal ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Boolean
    RankHasNoItems = Count(ipArray, ipRank) < 1
End Function

Public Function RankHasItems(ByVal ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Boolean
    RankHasItems = Not RankHasNoItems(ipArray, ipRank)
End Function

Public Function IsRankSameSize _
( _
    ByVal ipTestArray As Variant, _
    ByVal ipRefArray As Variant, _
    Optional ByVal ipTestRank As Long = 1, _
    Optional ByVal ipRefRank As Long = 1 _
) As Result
        
    Globals.Res.Init (Msg.Okay)
    If BailOut.When(ipTestRank < 1, Msg.RankLessThanArrayFirstRank) Then Exit Function
    If BailOut.When(ipRefRank < 1, Msg.RankLessThanArrayFirstRank) Then Exit Function
    
    If BailOut.When(Arrays.HasNoRanks(ipTestArray, ipTestRank), Msg.HasNoRanks) Then Exit Function
    If BailOut.When(Arrays.HasNoRanks(ipRefArray, ipRefRank), Msg.HasNoRanks) Then Exit Function
        
    Globals.Res.Item(ResultItemsEnums.SameSize(ssTestItem)) = Count(ipTestArray, ipTestRank)
    Globals.Res.Item(ResultItemsEnums.SameSize(ssRefItem)) = Count(ipRefArray, ipRefRank)
    
    If Globals.Res.Item(ResultItemsEnums.SameSize(ssTestItem)) = Globals.Res.Item(ResultItemsEnums.SameSize(ssRefItem)) Then
        
        Set IsRankSameSize = Globals.Res.Init(Msg.Okay)
        
    Else
        
        Set IsRankSameSize = Globals.Res.SetNotOkay(enums.Message.AsEnum(Msg.NotSameSize))
        
    End If
        
End Function

Public Function IsSameSize _
( _
ByVal ipTestArray As Variant, _
ByVal ipRefArray As Variant _
) As Result
        
    If BailOut.When(HasNoRanks(ipTestArray, ipRefArray), Msg.HasNoRanks) Then Exit Function
    If BailOut.When(Ranks(ipTestArray) <> Ranks(ipRefArray), Msg.notequal) Then Exit Function
    
    Dim myRefCount As Long
    myRefCount = CountAll(ipRefArray)
    
    Dim myTestCount As Long
    myTestCount = CountAll(ipTestArray)
    
    If BailOut.When(myRefCount <> myTestCount, Msg.notequal) Then Exit Function
    
    Globals.Res.SetOkay.SetItems myTestCount, myRefCount
        
    Set IsSameSize = Globals.Res
        
End Function

'@Description("Returns the number of dimensions of an array. Return values >1:No of Ranks, 0: no Ranks. -1: Not an array")
Public Function Ranks(ByVal ipArray As Variant) As Long
Attribute Ranks.VB_Description = "Returns the number of dimensions of an array. Return values >1:No of Ranks, 0: no Ranks. -1: Not an array"
        
    Ranks = -1
    ' Can't use is not array here due to cicular references
    ' Can't call HasNoItems as this will introlduce circular dependencies.
    If BailOut.When(Not VBA.IsArray(ipArray), Msg.ItemDoesNotSupportRanks) Then Exit Function
    
    'Visual Basic for Applications arrays can have up to 60000 dimensions; this allows for that
    Dim myRank As Long
    For myRank = 1 To 60000
        
        '@Ignore VariableNotUsed
        Dim myUBound As Long
        On Error Resume Next
        myUBound = UBound(ipArray, myRank)
        If Err.Number <> 0 Then
                
            On Error GoTo 0
            Ranks = myRank - 1
            Exit Function
                
                
        End If
            
    Next
    
    Globals.Res.Init(Msg.NotOkay).SetItems (myRank)
    On Error GoTo 0
        
End Function


Public Function HasRank(ByRef ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Boolean

    HasRank = Globals.Res.SetNotOkay.Status
    If BailOut.When(Arrays.IsNotValid(ipArray), Msg.ArrayLacksRank) Then Exit Function
    If BailOut.When(ipRank < 1, Msg.RankLessThanArrayFirstRank) Then Exit Function
    If BailOut.When(ipRank > Ranks(ipArray), Msg.ArrayLacksRank) Then Exit Function
    
    Globals.Res.SetOkay
    Globals.Res.SetItems (True)
    HasRank = Globals.Res.Status
    
End Function

Public Function LacksRank(ByRef ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Boolean
    LacksRank = Not HasRank(ipArray, ipRank)
End Function


Public Function HasRanks(ParamArray ipArgArray() As Variant) As Boolean
    HasRanks = HasRanksByIterable(ipArgArray)
End Function

Friend Function HasNoRanks(ParamArray ipArgArray() As Variant) As Boolean
    HasNoRanks = Not HasRanksByIterable(ipArgArray)
End Function

Friend Function HasRanksByIterable(ByVal ipArgArray As Variant) As Boolean
    
    HasRanksByIterable = False

    Dim myArg As Variant
    For Each myArg In ipArgArray

       If Ranks(myArg) < 1 Then Exit Function
        
    Next

    HasRanksByIterable = True

End Function

'@Description("Returns the number of items in an Array Rank or -1 the rank didn't exist/item not an array. Global result enabled")
Public Function Count(ByRef ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Long
Attribute Count.VB_Description = "Returns the number of items in an Array Rank or -1 the rank didn't exist/item not an array. Global result enabled"
        
    Count = -1
    If BailOut.When(Types.IsNotArray(ipArray), Msg.IsNotArray) Then Exit Function
    If BailOut.When(Arrays.IsNotValid(ipArray), Msg.ArrayHasNoItems) Then Exit Function
    If BailOut.When(Ranks(ipArray) < 1, Msg.RankLessThanArrayFirstRank) Then Exit Function
    If BailOut.When(Arrays.LacksRank(ipArray, ipRank), Msg.ArrayLacksRank) Then Exit Function
        
    Dim myCount As Long
    myCount = UBound(ipArray, ipRank) - LBound(ipArray, ipRank) + 1
    Globals.Res.SetOkay.SetItems (myCount)
    Count = myCount
            
End Function

'@Description("Returns -1 for an unitialised array/not array otherwise the total number of items in the array")
Public Function CountAll(ByRef ipArray As Variant) As Long
Attribute CountAll.VB_Description = "Returns -1 for an unitialised array/not array otherwise the total number of items in the array"
        
    Globals.Res.SetNotOkay
    CountAll = -1
    
    Dim myRanks As Long
    myRanks = Ranks(ipArray)
    
    Dim mySum As Long
    mySum = 0
    
    Dim myRank As Long
    For myRank = 1 To myRanks
            
        If Count(ipArray, myRank) < 0 Then
            Exit Function
        End If
            
            
    Next
    
    Globals.Res.SetOkay.SetItems (mySum)
    CountAll = mySum
            
End Function



Public Function HasOneItem(ByVal ipArray As Variant) As Boolean
    HasOneItem = (UBound(ipArray) - LBound(ipArray) + 1) = 1
End Function

'Public Function HasOneItem(ByVal ipArray As Variant, Optional ByVal ipRank As Long = preset.ArrayFirstRank) As Boolean
        
    '      HasOneItem = Count(ipArray, ipRank) = 1
        
    '  End Function

Public Function IsNotSingleItem(ByVal ipArray As Variant) As Boolean
    IsNotSingleItem = Not HasOneItem(ipArray)
End Function


Public Function IsListArray(ParamArray ipArgArray() As Variant) As Boolean
    IsListArray = IsListArrayByIterable(ipArgArray)
End Function

Public Function IsNotListArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotListArray = Not IsListArrayByIterable(ipArgArray)
End Function

Public Function IsListArrayByIterable(ByVal ipFPA As Variant) As Boolean
    
    IsListArrayByIterable = Globals.Res.SetNotOkay.Status
    
    If Arrays.IsNotValid(ipFPA) Then Exit Function
    Dim myitem As Variant
    For Each myitem In ipFPA
        
        If BailOut.When(Types.IsNotArray(myitem), Msg.IsNotArray) Then Exit Function
        If BailOut.When(Arrays.Ranks(myitem) <> 1, Msg.IsNotListArray) Then Exit Function
        
    Next
    
    IsListArrayByIterable = Globals.Res.SetOkay.Status
    
End Function


Public Function IsTableArray(ParamArray ipArgArray() As Variant) As Boolean
    IsTableArray = IsTableArrayByIterable(ipArgArray)
End Function

Public Function IsNotTableArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotTableArray = Not IsTableArrayByIterable(ipArgArray)
End Function

Public Function IsTableArrayByIterable(ByVal ipFPA As Variant) As Boolean
    
    IsTableArrayByIterable = Globals.Res.SetNotOkay.Status
    
    If Arrays.IsNotValid(ipFPA) Then Exit Function
    Dim myitem As Variant
    For Each myitem In ipFPA
        
        If BailOut.When(Types.IsNotArray(myitem), Msg.IsNotArray) Then Exit Function
        If BailOut.When(Arrays.Ranks(myitem) <> 2, Msg.IsNotTableArray) Then Exit Function
        
    Next
    
    IsTableArrayByIterable = Globals.Res.SetOkay.Status
    
End Function

Public Function IsMDArray(ParamArray ipArgArray() As Variant) As Boolean
    IsMDArray = IsMDArrayByIterable(ipArgArray)
End Function

Public Function IsNotMDArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotMDArray = Not IsMDArrayByIterable(ipArgArray)
End Function


Public Function IsMDArrayByIterable(ByVal ipFPA As Variant) As Boolean
    
    IsMDArrayByIterable = Globals.Res.SetNotOkay.Status
    
    If Arrays.IsNotValid(ipFPA) Then Exit Function
    Dim myitem As Variant
    For Each myitem In ipFPA
        
        If BailOut.When(Types.IsNotArray(myitem), Msg.IsNotArray) Then Exit Function
        If BailOut.When(Arrays.Ranks(myitem) < 3, Msg.IsNotTableArray) Then Exit Function
        
    Next
    
    IsMDArrayByIterable = Globals.Res.SetOkay.Status
    
End Function

'@Description("Returns true if dimension 1 of an array has Ubound>=Lbound. Allows syntax parity with IterableObjects")
Public Function HasItems(ParamArray ipArgArray() As Variant) As Boolean
Attribute HasItems.VB_Description = "Returns true if dimension 1 of an array has Ubound>=Lbound. Allows syntax parity with IterableObjects"
   HasItems = HasItemsByIterable(ipArgArray)
End Function

Public Function HasNoItems(ParamArray ipArgsArray() As Variant) As Boolean
    HasNoItems = Not HasItemsByIterable(ipArgsArray)
End Function

' ' this function exists to get out of an awkiwardness for Lyst.Add method
' Public Function HasNoItemsByIterable(ByVal ipArgsArray As Variant) As Boolean
'     HasNoItemsByIterable = Not HasItemsByIterable(ipArgsArray)
' End Function

Friend Function HasItemsByIterable(ByVal ipArgsArray As Variant) As Boolean
    
    HasItemsByIterable = Globals.Res.SetNotOkay.Status
    
    Dim myitem As Variant
    For Each myitem In ipArgsArray
        
        On Error Resume Next
        Dim myUBound As Long
        myUBound = UBound(myitem)
        If Err.Number <> 0 Then
            
            On Error GoTo 0
            Exit Function
            
        End If
        
        If myUBound < LBound(myitem) Then Exit Function
        
    Next
    
    On Error GoTo 0
    
    HasItemsByIterable = Globals.Res.SetOkay.SetItems(True).Status

End Function
    
'@description("Returns true if a single array is a valid array")
Public Function IsValid(ByRef ipArray As Variant) As Boolean
Attribute IsValid.VB_Description = "Returns true if a single array is a valid array"
    
    IsValid = False
    On Error Resume Next
    Dim myUBound As Long
    myUBound = UBound(ipArray)
    If Err.Number <> 0 Then
        
        On Error GoTo 0
        Exit Function
        
    End If
    
    If myUBound < LBound(ipArray) Then Exit Function
    
    IsValid = True
End Function

Public Function IsNotValid(ByVal ipArray As Variant) As Boolean
    IsNotValid = Not IsValid(ipArray)
End Function
'

Public Function TryExtent(ByRef ipArray As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Result
        
    Set TryExtent = Globals.Res.SetNotOkay
    If BailOut.When(Arrays.IsNotValid(ipArray), Msg.HasNoItems) Then Exit Function
    If BailOut.When(Ranks(ipArray) < Preset.ArrayFirstRank, Msg.RankLessThanArrayFirstRank) Then Exit Function
    If BailOut.When(Arrays.LacksRank(ipArray, ipRank), Msg.ArrayLacksRank) Then Exit Function
    'If BailOut.When(Arrays.HasNoItems(ipArray), Msg.ArrayHasNoItems) Then Exit Function ' also detects empty variant
   
    'An uninitialised variant array has Ubound of -1 and Lbound of 0
    Dim myUBound As Long
    myUBound = UBound(ipArray, ipRank)
    
    Dim myLbound As Long
    myLbound = LBound(ipArray, ipRank)
    
    If myUBound < myLbound Then
            
        Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.ArrayHasNoItems)
        Exit Function
            
            
    End If
       
    Set TryExtent = Globals.Res.SetOkay.SetItems(myLbound, myUBound, myUBound - myLbound + 1)
    
End Function


'@Description("Returns a Lyst of Lyst where the inner lyst is a lyst the selected rank(row or column) items")
Public Function ToLystOfRanksAsLyst _
( _
    ByVal ipTablearray As Variant, _
    Optional ByVal ipAction As TableToLystAction = TableToLystAction.RankIsRowFirstItemActionIsNoAction _
) As Lyst
Attribute ToLystOfRanksAsLyst.VB_Description = "Returns a Lyst of Lyst where the inner lyst is a lyst the selected rank(row or column) items"

    If BailOut.When(IsNotTableArray(ipTablearray), Msg.IsNotTableArray) Then Exit Function
    If BailOut.When(enums.TableToLystActions.LacksMember(ipAction), Msg.msgLacksMember) Then Exit Function
    Dim myAction As ITableToLystAction
    Set myAction = enums.TableToLystActions.Action(ipAction)
    Set ToLystOfRanksAsLyst = myAction.ExecAction(ipTablearray)
        
End Function

'@Description("transposes rows and colums of a 2d array")
Public Function Transpose(ByVal ipTablearray As Variant) As Variant
Attribute Transpose.VB_Description = "transposes rows and colums of a 2d array"
    'ToDo: update to be able to cope with a jagged array.
    ' 'Check for a jaggedarray
    ' If Ranks(ipTablearray) = 1 And Ranks(ipTablearray(LBound(ipTablearray))) = 1 Then
            
    '     Return TransposeJagged(ipTablearray)
            
            
    ' End If

    If IsNotTableArray(ipTablearray) Then
    
        Transpose = Empty
        Exit Function
        
    End If
        
    Dim myFirstRow As Long
    myFirstRow = LBound(ipTablearray, 1)
        
    Dim myLastRow As Long
    myLastRow = UBound(ipTablearray, 1)

    Dim myFirstCol As Long
    myFirstCol = LBound(ipTablearray, 2)
        
    Dim myLastCol As Long
    myLastCol = UBound(ipTablearray, 2)

    '@Ignore VariableNotAssigned
    Dim myTableArray As Variant
    ReDim myTableArray(myFirstCol To myLastCol, myFirstRow To myLastRow)
        
    Dim myRow As Long
    For myRow = myFirstRow To myLastRow
        
        Dim myCol As Long
        For myCol = myFirstCol To myLastCol
            
            myTableArray(myCol, myRow) = ipTablearray(myRow, myCol)
                
        Next
        
    Next
        
    '@Ignore UnassignedVariableUsage
    Transpose = myTableArray
        
End Function

' '@Description("Transposes a JaggedArray")
' Private Function TransposeJagged(ByVal ipJagged As Variant) As Variant
    
'     'as we are working with variants we dont care if we have an array of arrays of arrays
'     Dim myFirstRow As Long
'     myFirstRow = LBound(ipJagged, 1)
        
'     Dim myLastRow As Long
'     myLastRow = UBound(ipJagged, 1)

'     Dim myFirstCol As Long
'     myFirstCol = LBound(ipJagged(0), 1)
        
'     Dim myLastCol As Long
'     myLastCol = UBound(ipJagged(0), 1)
        
'     ' make a 2d array
'     Dim myTableArray As Variant
'     ReDim myTableArray(myFirstCol To myLastCol, myFirstRow To myLastRow)
        
'     Dim myRow As Long
'     For myRow = myFirstRow To myLastRow
            
'         Dim myCol As Long
'         For myRow = myFirstCol To myLastCol
                
'             myTableArray(myCol, myRow) = ipJagged(myRow)(myCol)
                
'         Next
            
'     Next
            
'     Dim mylyst As Lyst = enums.TableToLystActions.Action(RankIsColumnFirstItemActionIsNoAction).ExecAction(myTableArray)
        
'     Dim mytransposed As Variant = mylyst.ToArray
'     Dim myItem As Variant
'     For Each myitem In
        
' End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Ranges"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib")


Public Function GetSeries(ByVal ipStart As Variant, ByVal ipCount As Long, Optional ByVal ipStep As Variant = 1) As Lyst

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set GetSeries = myLyst
        
    If Types.Group.IsNotNumber(ipStart, ipCount, ipStep) Then Exit Function
        
    Dim myitem As Variant
    For myitem = 1 To ipCount Step 1
        
        myLyst.Host.Add ipStart
        ipStart = ipStart + ipStep
            
    Next
    
    Set GetSeries = myLyst
        
End Function

Public Function GetConstSeries(ByVal ipCount As Long, ByVal ipValue As Variant) As Lyst

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set GetConstSeries = myLyst
        
    Dim myitem As Long
    For myitem = 1 To ipCount
        
        myLyst.Host.Add ipValue
            
    Next
        
End Function

'@Description("Takes any iterable or string. The startindex and endindex should be specified using a 1 based index. The result.items lyst returns the startindex based on the actual indexing used by the iterable")
Friend Function TryStartRunFromAnyStartRunEnd _
( _
    ByVal ipItem As Variant, _
    Optional ByVal ipStartIndex As Variant, _
    Optional ByVal ipRun As Variant, _
    Optional ByVal ipEndIndex As Variant, _
    Optional ByVal ipRank As Long = Preset.ArrayFirstRank _
) As Result
Attribute TryStartRunFromAnyStartRunEnd.VB_Description = "Takes any iterable or string. The startindex and endindex should be specified using a 1 based index. The result.items lyst returns the startindex based on the actual indexing used by the iterable"
' Optional ByRef iopResult As Result, _
Attribute TryStartRunFromAnyStartRunEnd.VB_Description = "Takes an iterable or string and returns a Result (see Result.fields.StartRun). The Input StartIndex and EndIndex  use a 1 based index and may be negative."
    ' Item must be an iterable or a string
    ' If ipRun is provided, any value for ipEndIndex is ignored
    ' to the start (positive numbers) or end(negativenumbers)
    ' The method attempts to return valid start and run values so may
    ' coerce input values to do so
    ' Where coercion is used a message retuned about the coercion applied
    ' Only the mfirst coercion message is returned.
    '
    ' To emulate other programming languages, values
    ' for the start, end or run can be negative to indicate counting down from a high to low index.
    ' e.g. in terms of this library an ipstartindex of -1 would correspond to the LastIndex property.
    ' This is the reason why the input startindex and end index must be relative values
    ' The start and end index values are the ordinal position starting the first or last index
    ' Thus positive indeces start at 1 and proceeed to a value of '.count' and for negative indeces indeces start at -1
    ' and proceeeds to a value of '-.count'
    ' The output startindex is givem in terms of the indexing of the input iterable
        
    ' input parameters are stated in terms of virtual item with 1 based indexing
    ' the return is the actual indexes to use.
    
 
    Set TryStartRunFromAnyStartRunEnd = Globals.Res.SetOkay
        
    ' If Types.Group.IsNotIterable(ipItem) Then
    '     ' we want to allow strings because they **do** have an extent
    '     If BailOut.When(Types.IsNotString(ipItem), Msg.IsNotIterable) Then Exit Function
    ' End If
        
    ' If Types.IsNotArray(ipItem) Then
    '     If BailOut.When(ipRank > 1, Msg.ItemDoesNotSupportRanks) Then Exit Function
    ' End If
        
    If Types.TryExtent(ipItem, ipRank).IsNotOkay Then Exit Function
        
    ' Preserve the extent for later use
    Dim myItemExtent As ResultExtent
    Set myItemExtent = Globals.Res.GetResultExtent
        
    ' Guard against invalid conditions
    ' Guard against a run of zero
        
    If Types.IsNotMissing(ipRun) Then
        If BailOut.When(ipRun = 0, Msg.RunLengthIsZero) Then Exit Function
    End If
        
    ' Ensure a legal start index
    If Types.IsNotMissing(ipStartIndex) Then
            
        If BailOut.When _
        ( _
            VBA.Abs(ipStartIndex) > myItemExtent.Count, _
            Msg.StartIndexExceedsItemCount _
        ) _
        Then Exit Function
                
            
        If ipStartIndex = 0 Then
                
            ipStartIndex = 1
            Globals.Res.SetOkay (Msg.StartIndexWasZeroResetToOne)
                
            
        End If
            
    End If
        
    ' Ensure a legal end index
    If Types.IsNotMissing(ipEndIndex) Then
            
        If VBA.Abs(ipEndIndex) > myItemExtent.Count Then
                
            ipEndIndex = myItemExtent.Count * VBA.Sgn(ipEndIndex)
            Globals.Res.MsgEnum = enums.Message.AsEnum(Msg.EndIndexExceedsItemCount)
                
                
        ElseIf ipEndIndex = 0 Then
                
            ipEndIndex = 1
            Globals.Res.MsgEnum = enums.Message.AsEnum(Msg.EndIndexWasZeroResetToOne)
            

        End If
                
    End If
    
    ' There are 8 combinations of three variables (ipStartIndex, ipRun, and ipEndIndex)
    ' however when ipRun is provided ipEndIndex can be ignored
    ' So we can simplify to 6 cases
    ' iopResult is being used to pass in the results of Tyes.Extent
    Select Case True
            
    Case Types.IsNotMissing(ipStartIndex, ipRun)
            
        DeduceStartRunFromAnyStartRun ipStartIndex, ipRun, myItemExtent
                
            
    Case Types.IsNotMissing(ipStartIndex, ipEndIndex)
            
        DeduceStartRunFromAnyStartEnd ipStartIndex, ipEndIndex, myItemExtent
                
            
    Case Types.IsNotMissing(ipStartIndex)
            
        DeduceStartRunFromAnyStartOnly ipStartIndex, myItemExtent
                
            
    Case Types.IsNotMissing(ipRun)
            
        DeduceStartRunFromAnyRunOnly ipRun, myItemExtent
                
            
    Case Types.IsNotMissing(ipEndIndex, myItemExtent)
            
        DeduceStartRunFromAnyEndOnly ipEndIndex, myItemExtent
                
            
    Case Types.IsMissing(ipStartIndex, ipRun, ipEndIndex, myItemExtent)
            
        DeduceStartRunFromNoStartRunOrEnd myItemExtent
                
                
    End Select
        
    'iopResult.Item(ResultItemsEnums.StartRun(srStartIndex)) = iopResult.Item(ResultItemsEnums.StartRun(srStartIndex)) + myFirstIndex - 1
    Set TryStartRunFromAnyStartRunEnd = Globals.Res
    
End Function

Friend Sub DeduceStartRunFromAnyStartRun _
( _
    ByVal ipStartIndex As Long, _
    ByVal ipRun As Long, _
    ByRef ipItemExtent As ResultExtent _
)
        
    Dim myStartIndex As Long
    Dim myRun As Long
    If ipStartIndex > 0 And ipRun > 0 Then
            
        If ipStartIndex + ipRun - 1 <= ipItemExtent.Count Then
                
            myRun = ipRun
            myStartIndex = ipStartIndex + ipItemExtent.FirstIndex - 1
                                
        Else
                
            myRun = ipItemExtent.Count - ipStartIndex + 1
            myStartIndex = ipStartIndex
            Globals.Res.MsgEnum = enums.Message.AsEnum(Msg.RunLengthTooLong)
                
                
        End If
            
    ElseIf ipStartIndex > 0 And ipRun < 0 Then
            
        If ipStartIndex + ipRun + 1 > 0 Then
                
            myStartIndex = ipItemExtent.FirstIndex
            myRun = VBA.Abs(ipRun)
                
        Else
                
            myStartIndex = 1
            myRun = ipStartIndex
            Globals.Res.MsgEnum = enums.Message.AsEnum(Msg.RunLengthTooLong)
                
        End If
            
            
    ElseIf ipStartIndex < 0 And ipRun > 0 Then
            
        myStartIndex = ipItemExtent.LastIndex + ipStartIndex + 1
        If myStartIndex + ipRun - 1 <= ipItemExtent.Count Then
                
            myRun = ipRun
                
        Else
                
            myRun = ipItemExtent.Count - myStartIndex + 1
            Globals.Res.MsgEnum = enums.Message.AsEnum(Msg.RunLengthTooLong)
                
                
        End If
            
    Else                                         ' ipstartindex <0 and ipRun <0 then
            
        myStartIndex = ipItemExtent.LastIndex + ipStartIndex + 1
        If myStartIndex + Abs(ipRun) + 1 > 0 Then
                
            myStartIndex = myStartIndex + ipRun + 1
            myRun = VBA.Abs(ipRun)
                
        Else
                
            myStartIndex = 1
            myRun = ipItemExtent.Count - myStartIndex + 1
                
        End If
            
            
    End If
        
    ' ' Adjust startindex to align witth the true first index
    ' myStartIndex = myStartIndex - 1 + iopResult.Item(ResultItemsEnums.ItemExtent(IsFirstIndex))
     Globals.Res.Init(Msg.Okay).SetItems myStartIndex, myRun
        
End Sub

Friend Sub DeduceStartRunFromAnyStartEnd _
( _
    ByVal ipStartIndex As Long, _
    ByVal ipEndIndex As Long, _
    ByRef ipItemExtent As ResultExtent _
)
            
    Dim myStartIndex As Long
    Dim myEndIndex As Long
    Dim myRun As Long
            
    myStartIndex = IIf(ipStartIndex > 0, ipStartIndex + ipItemExtent.FirstIndex - 1, ipItemExtent.LastIndex + ipStartIndex + 1)
    myEndIndex = IIf(ipEndIndex > 0, ipEndIndex + ipItemExtent.FirstIndex - 1, ipItemExtent.LastIndex + ipEndIndex + 1)
            
    If myStartIndex < myEndIndex Then
                
        myRun = myEndIndex - myStartIndex + 1
                
    Else
                
        myRun = myStartIndex - myEndIndex + 1
        myStartIndex = myEndIndex
                
    End If
            
    ' ' Adjust startindex to align witth the true first index
    ' myStartIndex = myStartIndex - 1 + iopResult.Item(ResultItemsEnums.ItemExtent(IsFirstIndex))
    Globals.Res.Init(Msg.Okay).SetItems myStartIndex, myRun
            
End Sub

Friend Sub DeduceStartRunFromAnyStartOnly _
( _
    ByVal ipStartIndex As Long, _
    ByRef ipItemExtent As ResultExtent _
)

    Dim myStartIndex As Long
    Dim myRun  As Long
    If ipStartIndex > 0 Then
            
        myStartIndex = ipItemExtent.FirstIndex + ipStartIndex - 1
        myRun = ipItemExtent.Count - ipStartIndex + 1
            
    Else
        
        myStartIndex = ipItemExtent.LastIndex + ipStartIndex + 1
        myRun = VBA.Abs(ipStartIndex)
            
    End If

    ' ' Adjust startindex to align witth the true first index
    ' myStartIndex = myStartIndex - 1 + iopResult.Item(ResultItemsEnums.ItemExtent(IsFirstIndex))
    Globals.Res.Init(Msg.Okay).SetItems myStartIndex, myRun

End Sub

Friend Sub DeduceStartRunFromAnyRunOnly(ByVal ipRun As Long, ByRef ipItemExtent As ResultExtent)
            
    Dim myStartIndex As Long
    Dim myRun As Long
    
    If ipRun > 0 Then
      
      myStartIndex = ipItemExtent.FirstIndex
      myRun = ipRun
      
      
    Else
            
      myStartIndex = ipItemExtent.LastIndex + ipRun + 1
      myRun = VBA.Abs(ipRun)
            
            
    End If
        
    ' ' Adjust startindex to align witth the true first index
    ' myStartIndex = myStartIndex - 1 + iopResult.Item(ResultItemsEnums.ItemExtent(IsFirstIndex))
    Globals.Res.Init(Msg.Okay).SetItems myStartIndex, myRun
        
End Sub

Friend Sub DeduceStartRunFromAnyEndOnly(ByVal ipEndIndex As Long, ByRef ipItemExtent As ResultExtent)
        
    Dim myStartIndex As Long
    Dim myRun As Long
            
    If ipEndIndex > 0 Then
        
      myStartIndex = ipItemExtent.FirstIndex
      myRun = ipEndIndex
        
            
    Else
      
      myStartIndex = ipItemExtent.FirstIndex
      myRun = ipItemExtent.Count + ipEndIndex + 1
            
            
    End If
        
    ' Adjust startindex to align witth the true first index
        
    Globals.Res.Init(Msg.Okay).SetItems myStartIndex, myRun
        
End Sub

Friend Sub DeduceStartRunFromNoStartRunOrEnd(ByRef ipItemExtent As ResultExtent)
        
    ' Dim myFirstIndex As Long
    ' myFirstIndex = ipItemExtent.FirstIndex
        
    ' Dim myRun As Long
    ' myRun = iopExtent.Item(ResultItemsEnums.ItemExtent(ieCount))
        
    ' Adjust startindex to align witth the true first index
    'myStartIndex = myStartIndex - 1 + iopResult.Item(ResultItemsEnums.ItemExtent(IsFirstIndex))
    Globals.Res.SetOkay.SetItems ipItemExtent.FirstIndex, ipItemExtent.Count

End Sub

'@Description("Returns the specified subrange in Item(0) of the result")
Public Function TryRange _
( _
    ByVal ipIterable As Variant, _
    Optional ByVal ipStartIndex As Variant, _
    Optional ByVal ipRun As Variant, _
    Optional ByVal ipEndIndex As Variant, _
    Optional ByVal ipRank As Long = Preset.ArrayFirstRank _
) As Result
Attribute TryRange.VB_Description = "Returns the specified subrange in Item(0) of the result"
       'ByRef iopResult As Result, _
Attribute TryRange.VB_Description = "Returns the specified subrange in Item(0) of the result"
        
    'If iopResult Is Nothing Then Set iopResult = Result.Deb
    Globals.Res.SetOkay
    Set TryRange = Globals.Res
    
    ' If Types.Iterable.TryExtent(ipIterable, ipRank).IsNotOkay Then Exit Function
        
        
    ' ' Preserve the original first index to use later when converting back from start run values
    ' Dim myItemExtent As ResultExtent
    ' Set myItemExtent = Globals.Res.GetResultExtent
        
    If Ranges.TryStartRunFromAnyStartRunEnd(ipIterable, ipStartIndex, ipRun, ipEndIndex, ipRank).IsNotOkay Then Exit Function
 
        
    'get startrun
    Dim myRangeStartRun As ResultStartRun
    Set myRangeStartRun = Globals.Res.GetResultStartRun
    
    ' Convert the virtual start run into actual start end
    ' Dim myStartIndex As Long
    ' myStartIndex = myStartRun.StartIndex + myItemExtent.FirstIndex
        
    ' Dim myEndIndex As Long
    ' myEndIndex = myStartIndex + myStartRun.Run + myItemExtent.FirstIndex - 1
        
        
'    Dim myList As Lyst
'    Set myList = Lyst.Deb
   Dim myAL As ArrayList
   Set myAL = New ArrayList
   
   
    Dim myIndex As Long
    For myIndex = myRangeStartRun.StartIndex To myRangeStartRun.StartIndex + myRangeStartRun.Run - 1
          
       myAL.Add ipIterable(myIndex)
            
    Next
    
    Set Globals.Res.Items = myAL
    Set TryRange = Globals.Res.SetOkay
    
End Function

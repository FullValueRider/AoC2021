VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Lyst"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "A Wrapper for the ArrayList object which provides intellisense and extends functionality"
'@IgnoreModule MemberNotOnInterface, IsMissingOnInappropriateArgument, FunctionReturnValueAlwaysDiscarded, SuspiciousPredeclaredInstanceAccess
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Lyst Class
'
' This class is a wrapper for the ArrayList class
' the principle differences being
'
' 1.    It omits parts of the arraylistt class that cannot be acheved in VBA
' 2.    Methods return the Me instance so that methods can be chained
' 3.    It allows intellisense for the class
' 4.    The indexing is set att 1 based rather than the 0 based of the underlying arraylist
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Option Explicit
'@ModuleDescription("A Wrapper for the ArrayList object which provides intellisense and extends functionality")
'@PredeclaredId
'@exposed
'@Folder("VBALib")

Private Type State
    Host                                    As ArrayList
End Type
Private s                                   As State


Public Sub Class_Initialize()
    Set s.Host = New ArrayList
End Sub

'@Description("Returns a new instance of the Lyst Class. ")
Public Function Deb() As Lyst
Attribute Deb.VB_Description = "Returns a new instance of the Lyst Class. "

    With New Lyst
        Set Deb = .ReadyToUseInstance
    End With

End Function


Friend Function ReadyToUseInstance() As Lyst
        
    
    Set ReadyToUseInstance = Me
            
End Function

'@Enumerator
Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
    Dim enumerator As IEnumVARIANT
    '@Ignore DefaultMemberRequired
    Set enumerator = s.Host.GetEnumerator(0, s.Host.Count)
    Set NewEnum = enumerator

End Property


Friend Function GetEnumerator() As Variant
    Set GetEnumerator = s.Host.GetEnumerator
End Function

Public Property Get AName() As String
    AName = "Lyst"
End Property

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Properties
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@Description("Adds a comma separated list of items to the Lyst.)"
Public Function Add(ParamArray ipArgArray() As Variant) As Lyst
Attribute Add.VB_Description = "Adds a comma separated list of items to the Lyst.  )"

    Set Add = Me
    Globals.Res.Init (Msg.Okay)
    
    If VBA.IsMissing(ipArgArray) Then
        Globals.Res.MsgEnum = Msg.MissingParameter
        Exit Function
    End If
    
    If VBA.IsEmpty(ipArgArray) Then
        Globals.Res.MsgEnum = Msg.ParamArrayIsNotValid
        Exit Function
    End If
    
    If UBound(ipArgArray) < LBound(ipArgArray) Then
        Globals.Res.MsgEnum = Msg.HasNoItems
        Exit Function
    End If
    
    Dim myArgArray As Variant
    myArgArray = CVar(ipArgArray)
    Dim myitem As Variant
    For Each myitem In myArgArray
            
        s.Host.Add myitem
            
    Next
    
    Globals.Res.SetOkay
    Set Add = Me
        
End Function


'@Description("Adds the Items of a single iterable to the Lyst.")
Public Function AddRange(ByVal ipIterable As Variant) As Lyst
Attribute AddRange.VB_Description = "Adds the Items of a single iterable to the Lyst."
   
    ' Because a variant is used for input we allow for the case
    ' when a not iterable ittem is passed to the method
    Set AddRange = Me
    
    ' the ifs below should be bailout statement
    Globals.Res.Init Msg.Okay
    'we cannot use
    If BailOut.When(VBA.IsMissing(ipIterable), Msg.MissingParameter) Then Exit Function
    If BailOut.When(VBA.IsEmpty(ipIterable), Msg.ParamArrayIsNotValid) Then Exit Function
        
    ' If VBA.IsArray(ipIterable) Then
    '     If BailOut.When(Arrays.IsNotValid(ipIterable), Msg.HasNoItems) Then Exit Function
    ' End If
    
    If Types.Group.IsIterable(ipIterable) Then
        If BailOut.When(Types.Iterable.Count(ipIterable) < 1, Msg.HasNoItems) Then Exit Function
    End If
       
    
    If Types.Group.IsNotIterable(ipIterable) Then
            ipIterable = Array(ipIterable)
    End If
    
'    Dim myLyst As Lyst
'    Set myLyst = Lyst.Deb.AddKnownIterableAsItems(ipIterable)
    'Debug.Print TypeName(ipIterable.Host)
    Dim myitem As Variant
    For Each myitem In ipIterable  '.Host
      
        s.Host.Add myitem
        
    Next
        
    Globals.Res.SetOkay
    Set AddRange = Me
        
End Function

Friend Function AddKnownItemsAsItems(ParamArray ipitems() As Variant) As Lyst
        
    Dim myitem As Variant
    For Each myitem In ipitems
        
        s.Host.Add myitem
            
                
    Next
        
    Set AddKnownItemsAsItems = Me
        
End Function

'@Description("Implements add for a single item produced by ParseParamArrayToLyst<test> thus does not retest via ParseParaArray... thereby avoiding an infinite recursion")
Friend Function AddKnownIterableAsItems(ByVal ipIterable As Variant) As Lyst
Attribute AddKnownIterableAsItems.VB_Description = "Implements add for a single item produced by ParseParamArrayToLyst<test> thus does not retest via ParseParaArray... thereby avoiding an infinite recursion"


    If Types.Group.IsNotIterable(ipIterable) Then
        
        s.Host.add ipIterable
        
    Else
        
    
        Dim myitem As Variant
        For Each myitem In ipIterable
                
            s.Host.Add myitem
                
                
        Next
        
    End If
        
    Set AddKnownIterableAsItems = Me
        
End Function

'@Description("Returns the current global result state via a result object.")
Public Function Res() As Result
Attribute Res.VB_Description = "Returns the current global result state via a result object."
    Set Res = Globals.Res
End Function

'@Description("Returns the number of Items in the Lyst instance.")
Public Function Count() As Variant
Attribute Count.VB_Description = "Returns the number of Items in the Lyst instance."
   Count = s.Host.Count
End Function

'@Description("Returns the number of Items in the Lyst instance equal to ipValue)")
Public Function CountIt(ByRef ipComparer As IComparer) As Long
Attribute CountIt.VB_Description = "Returns the number of Items in the Lyst instance equal to ipValue)"
  
    Dim myCounter As Long
    myCounter = 0
    Dim myitem As Variant
    For Each myitem In s.Host

        If ipComparer.ExecCmp(myitem) Then myCounter = myCounter + 1
        
            
    Next

    CountIt = myCounter
  
End Function

'@Description("Returns a new Lyst containing only unique items")
Public Function Deduplicate() As Lyst
Attribute Deduplicate.VB_Description = "Returns a new Lyst containing only unique items"
    
    
    Dim myUnique As Lyst
    Set myUnique = New Lyst
    
    Dim myitem As Variant
    For Each myitem In s.Host
        
        If myUnique.LacksItem(myitem) Then myUnique.AddKnownItemsAsItems myitem
            

    Next
    
    Globals.Res.Init Msg.Okay
    Set Deduplicate = Me
    
End Function
        
        
'@Description("Returns values taken sequentially from the Lyst. If count >0 items are taken from First index, If run is <0 items are taken from Latindex and the sequence is reversed compared to the host Lyst")
Public Function Dequeue(Optional ByVal ipCount As Long = 1) As Lyst
Attribute Dequeue.VB_Description = "Returns values taken sequentially from the Lyst. If count >0 items are taken from First index, If run is <0 items are taken from Latindex and the sequence is reversed compared to the host Lyst"
        
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set Dequeue = myLyst
    
    If ipCount = 0 Then Exit Function
    'If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipRun:=ipCount).IsNotOkay Then Exit Function
    
    'next 4 lines for readability
    ' Dim myStartIndex As Long
    ' myStartIndex = Globals.Res.Item(ResultItemsEnums.StartRun(srStartindex))
    
    ' Dim myCount As Long
    ' myCount = Globals.Res.Item(ResultItemsEnums.StartRun(srRunLength))
    
    If ipCount > 0 Then
    
        Set myLyst = GetRange(1, ipCount)
        s.Host.RemoveRange 1, ipCount
      
    Else
      
        Set myLyst.Host = GetRange(LastIndex - VBA.Abs(ipCount) + 1, VBA.Abs(ipCount)).Reverse
        s.Host.RemoveRange LastIndex - VBA.Abs(ipCount) + 1 - 1, VBA.Abs(ipCount)
      
    End If
    's.Host.RemoveRange myStartIndex, myCount
        
    Set Dequeue = myLyst
    
End Function

'@Description("Alternative syntax for AddRange")
Public Function Enqueue(ParamArray ipArgArray() As Variant) As Lyst
Attribute Enqueue.VB_Description = "Alternative syntax for AddRange"
    Set Enqueue = AddRange(ipArgArray)
End Function

'@Description("Alternative syntax for .Item(x))")
Public Function Peek(ByVal ipIndex As Long) As Variant
Attribute Peek.VB_Description = "Alternative syntax for .Item(x))"
    
    If VBA.IsObject(Item(ipIndex)) Then
    
        Set Peek = Item(ipIndex)
        
    Else
    
        Peek = Item(ipIndex)
        
    End If
        
End Function


'@Description("Alternative syntax for AddRange")
Public Function Push(ParamArray ipArgArray() As Variant) As Lyst
Attribute Push.VB_Description = "Alternative syntax for AddRange"
    Set Push = AddRange(ipArgArray)
End Function

'@DefaultMember
'@Description("Allows read and write of an item value.  The index may be negative")
Public Property Get Item(ByVal ipIndex As Long) As Variant
Attribute Item.VB_Description = "Allows read and write of an item value.  The index may be negative"
Attribute Item.VB_UserMemId = 0

    If BailOut.When(ipIndex < FirstIndex, Msg.IndexBeforeFirstIndex) Then Exit Property
    If BailOut.When(ipIndex > LastIndex, Msg.IndexAfterLastIndex) Then Exit Property
   ' If Ranges.TryStartRunFromAnyStartRunEnd(s.Host, ipIndex).IsNotOkay Then Exit Property
   
    ' Dim myStartRun As ResultStartRun
    ' myStartRun = Globals.Res.GetStartRun
    
    If VBA.IsObject(s.Host.Item(ipIndex - 1)) Then
            
        Set Item = s.Host.Item(ipIndex - 1)
           
        
    Else
            
        Item = s.Host.Item(ipIndex - 1)
                
        
    End If
         
End Property

Public Property Let Item(ByVal ipIndex As Long, ByVal ipValue As Variant)
    
    If Ranges.TryStartRunFromAnyStartRunEnd(s.Host, ipIndex).IsNotOkay Then Exit Property
    
    Dim mystartrun As ResultStartRun
    Set mystartrun = Globals.Res.GetResultStartRun
    
    If VBA.IsObject(ipValue) Then
        
        Set s.Host.Item(mystartrun.StartIndex) = ipValue
            
        
    Else
        
        s.Host.Item(mystartrun.StartIndex) = ipValue
            
        
    End If
        
End Property


Public Property Set Item(ByVal ipIndex As Long, ByVal ipValue As Variant)
        
    If Ranges.TryStartRunFromAnyStartRunEnd(s.Host, ipIndex).IsNotOkay Then Exit Property
   
    Dim mystartrun As ResultStartRun
    Set mystartrun = Globals.Res.GetResultStartRun
    
    Set s.Host.Item(mystartrun.StartIndex) = ipValue
        
End Property

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Methods
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Lyst cannot use Is<Group> methods of the TypesGroup class as this leads to using
' Lysts of typenames before they have been populated
' thus in the Lyst class we use the pvLacksItem and pvHoldsItem Methods
' Public Function pvHoldsItem(ByVal ipGroupString As String, ByVal ipItem As Variant) As Boolean
'     pvHoldsItem = VBA.InStr(ipGroupString, TypeName(ipItem)) > 0
' End Function



'**Error**
'Public Function BinarySearch(ByVal ipValue As Variant) As Long
'' Produces Invalid Procedure call or argument
'' Probably needs a comparer which cannot be provided by VBA
'
'    s.Host.Sort
'    BinarySearch = s.Host.BinarySearch(ipValue)
'End Function

'@Description("Removes all items from the Lyst")
Public Function Clear() As Lyst
Attribute Clear.VB_Description = "Removes all items from the Lyst"
        
    s.Host.Clear
    Set Clear = Me

End Function

'@Description("Returns a shallow copy of the Lyst")
Public Function Clone() As Lyst
Attribute Clone.VB_Description = "Returns a shallow copy of the Lyst"
    Set Clone = Lyst.Deb.AddKnownIterableAsItems(s.Host.Clone)
End Function

'@Description("Returns True if the Item is found in the Lyst. For compatibility with ArrayList syntax")
Public Function Contains(ByVal ipItem As Variant) As Boolean
Attribute Contains.VB_Description = "Returns True if the Item is found in the Lyst. For compatibility with ArrayList syntax"
    Contains = s.Host.Contains(ipItem)
End Function

Public Function HasNoItems() As Boolean
    HasNoItems = Not HasItems
End Function

Public Function HasItems() As Boolean
    HasItems = Count > 0
End Function

'@Description("Alternative syntax for Contains(Item)")
Public Function HoldsItem(ByVal ipValue As Variant) As Boolean
Attribute HoldsItem.VB_Description = "Alternative syntax for Contains(Item)"
    HoldsItem = s.Host.Contains(ipValue)         ' Does this need to be typename
End Function

'@Description("Alternative syntax for 'Not Contains(item)'")
Public Function LacksItem(ByVal ipValue As Variant) As Boolean
Attribute LacksItem.VB_Description = "Alternative syntax for 'Not Contains(item)'"
    LacksItem = Not HoldsItem(ipValue)
End Function

' ArrayList:CopyTo:Overloads
' CopyTo(Array)
' Copies the entire ArrayList to a compatible one-dimensional Array, starting at the beginning of the target array.

' CopyTo(Array, Int32)
' Copies the entire ArrayList to a compatible one-dimensional Array, starting at the specified index of the target array.

' CopyTo(Int32, Array, Int32, Int32)
' Copies a range of elements from the ArrayList to a compatible one-dimensional Array, starting at the specified index of the target array.
'
'@Description("Copies the specified range to the byref array provided as the first parameter. Default is to copy the whole Lyst. For compatibility, the ToArray method should be preferred")
Public Sub CopyTo _
( _
    ByRef ipArray As Variant, _
    Optional ByVal ipStartIndex As Variant, _
    Optional ByVal ipRun As Variant, _
    Optional ByVal ipEndIndex As Variant _
)
Attribute CopyTo.VB_Description = "Copies the specified range to the byref array provided as the first parameter. Default is to copy the whole Lyst. For compatibility, the ToArray method should be preferred"
    ' ipStartIndex, tpRun and ipEndIndex need to be variants to allow the IsMissing property
    ' p.MsgId = enums.Message.AsEnum(Id.NotOkay)
    ' p.Status = Sys.NotOkay
    
        
    Globals.Res.Init Msg.NotOkay
    Dim myArrayExtent As ResultExtent
    If Arrays.TryExtent(ipArray).IsNotOkay Then Exit Sub
    Set myArrayExtent = Globals.Res.GetResultExtent

    ' The parameters for TryStartRunFromAnyStartRunEnd are 1 based indexes
    ' so as to allow negative numbers
    ' Consequently, the real values for ipStartIndex/ipEndIndex need to be converted
    ' to a 1 based index
    ' for Lyst, the host will always be a 0 based ArrayList
    ' This we convert by adding 1 to startindex and endindex if they are provided
     
    Dim mystartrun As ResultStartRun
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex, ipRun, ipEndIndex).IsNotOkay Then Exit Sub
    Set mystartrun = Globals.Res.GetResultStartRun

    If BailOut.When(myArrayExtent.Count <> mystartrun.Run, Msg.IndexWillOverrun) Then Exit Sub
        
    Dim myRange As Variant
    myRange = s.Host.GetRange(mystartrun.StartIndex - 1, mystartrun.Run).ToArray
    
    Dim myIndex As Long
    For myIndex = LBound(myRange) To UBound(myRange)
        
        ipArray(LBound(ipArray) + myIndex) = myRange(myIndex)
        
    Next
        
    Globals.Res.SetOkay
        
End Sub

'@Description("Returns a new Lyst instance containing a shallow copy of the specified range")
Public Function GetRange(Optional ByVal ipStartIndex As Variant, Optional ByVal ipRun As Variant, Optional ByVal ipEndIndex As Variant) As Lyst
Attribute GetRange.VB_Description = "Returns a new Lyst instance containing a shallow copy of the specified range"

    Dim myList As Lyst
    Set myList = Lyst.Deb
    Set GetRange = myList
        
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex, ipRun, ipEndIndex).IsNotOkay Then Exit Function
       
    Dim mystartrun As ResultStartRun
    Set mystartrun = Globals.Res.GetResultStartRun
    
    Dim myAL As ArrayList
    Set myAL = s.Host.GetRange(mystartrun.StartIndex - 1, mystartrun.Run)
        
    myList.InjectHostArrayList myAL
    Set GetRange = myList
        
End Function


Friend Property Get Host() As ArrayList
    Set Host = s.Host
End Property

Friend Property Set Host(ByVal ipArrayList As ArrayList)
    Set s.Host = ipArrayList
End Property

'@Description("Returns the Index of the first Item found in the subsection of the Lyst starting at ipStartIndex, through ipCount.   the whole list")
Public Function IndexOf(ByVal ipItem As Variant, Optional ByVal ipStartIndex As Variant, Optional ByVal ipRun As Variant, Optional ByVal ipEndIndex As Variant) As Long
Attribute IndexOf.VB_Description = "Returns the Index of the first Item found in the subsection of the Lyst starting at ipStartIndex, through ipCount.   the whole list"
    ' VBA/Twinbasic only support the item,start overload of the arraylist indexof method
    ' so to emulate all overloads we need to extract a range and then do the indexof on the extracted range
    ' on the extracted range
        
    Globals.Res.SetNotOkay
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex, ipRun, ipEndIndex).IsNotOkay Then Exit Function
    
    Dim mystartrun As ResultStartRun
    Set mystartrun = Globals.Res.GetResultStartRun
    
    Dim myAL As ArrayList
    Set myAL = s.Host.GetRange(mystartrun.StartIndex - 1, mystartrun.Run)
    
    Dim myIndex As Long
    myIndex = myAL.IndexOf(ipItem, 0)
        
    IndexOf = myIndex + mystartrun.StartIndex
    
End Function

Friend Function IndexOfValue(ByVal ipValue As Variant, Optional ByVal ipStartIndex As Variant, Optional ByVal ipCount As Variant) As Long
    ' The following caveats apply for using ArrayList from twinbasic
    ' TB/VBA gives an error if the method call does not contain a startindex value
    ' TB/VBA gives an error if the count parameter is used
    ' The Index returned is counted from start of list not start of range
    ' if ipValue is not found  then -1 is returned
    ' ipCount is used to limit the range over which the search is conducted
        
    ' As the count parameter is not supported a subrange is extracted so we can just use Index of(value)
    Dim myRange As ArrayList
    Set myRange = s.Host.GetRange(ipStartIndex, ipCount)
        
    Dim myIndex As Long
    ' Remember that a start index is required in TB/VBA
    myIndex = myRange.IndexOf(ipValue, 0)
    If myIndex = -1 Then Exit Function
    IndexOfValue = myIndex + ipStartIndex
        
End Function

Friend Function IndexOfObject(ByVal ipItem As Variant, Optional ByVal ipStartIndex As Long = 0, Optional ByVal ipCount As Long = -1) As Long
        
    IndexOfObject = -1
    Dim myRange As ArrayList
    Set myRange = s.Host.GetRange(ipStartIndex, ipCount)
        
    Dim myIndex As Long
    ' Remember that a start index is required in TB/VBA
        
    For myIndex = 0 To myRange.Count - 1
        
        If VBA.ObjPtr(ipItem) = VBA.ObjPtr(s.Host.Item(myIndex)) Then
                
            IndexOfObject = myIndex + ipStartIndex
            Exit Function
                
                
        End If
            
    
    Next
        
End Function

'@Description("Inserts values at Index")
Public Function InsertAt(ByVal ipIndex As Long, ParamArray ipArgArray() As Variant) As Lyst
Attribute InsertAt.VB_Description = "Inserts values at Index"
   
    Set InsertAt = Me
    'Globals.Res.Init(Msg.NotOkay)
    If BailOut.When(Arrays.IsNotValid(ipArgArray), Msg.ParamArrayIsNotValid) Then Exit Function
 
    ' because we allow negative indexes, get a startrun to obtain the value of ipIndex
    If Ranges.TryStartRunFromAnyStartRunEnd(s.Host, ipIndex).IsNotOkay Then Exit Function
        
        
    Dim mystartrun As ResultStartRun
    Set mystartrun = Globals.Res.GetResultStartRun
    
    If Arrays.HasOneItem(ipArgArray) Then
      
      If Parser.ParseVariantWithOneItem(ipArgArray(0)).IsNotOkay Then Exit Function
      's.Host.insertrange
      
      Dim myParsed As ResultParsedVariant
      Set myParsed = Globals.Res.GetResultParsedVariant
     
      s.Host.InsertRange mystartrun.StartIndex, myParsed.ResultItems.ToArrayList
        
                
    Else
        
        s.Host.InsertRange mystartrun.StartIndex, Types.Iterable.ToArrayList(ipArgArray)
            
    End If
        
End Function

'@Description("Returns a modified Lyst with values from the defined subrange of ipIterable inserted at ipInsertIndex.")
Public Function InsertRange _
       ( _
       ByVal ipInsertIndex As Variant, _
       ByVal ipIterable As Variant, _
       Optional ByVal ipStartIndex As Variant, _
       Optional ByVal ipRun As Variant, _
       Optional ByVal ipEndIndex As Variant, _
       Optional ByVal ipRank As Long = Preset.ArrayFirstRank _
       ) As Lyst
Attribute InsertRange.VB_Description = "Returns a modified Lyst with values from the defined subrange of ipIterable inserted at ipInsertIndex."

    ' ipstartindex,iprun and ipEndIndex refer to to the desired range from ipiterable
    ' and are expressed as relative to the first or last item
    ' For the purposes of the ranges methods, ranges are always considered to start from one.
    ' ipInsertIndex is the index at which insertion starts
        
    Globals.Res.Init Msg.Okay
    Set InsertRange = Me
    ' If Types.Group.IsNotIterable(ipIterable) Then
            
    '     Globals.Res.SetNotOkay.MsgEnum = (enums.Message.AsEnum(Msg.IsNotIterable))
    '     Set InsertRange = Me
    '     Exit Function
            
    ' End If
        
    ' If Types.Iterable.HasNoItems(ipIterable) Then
            
    '     Globals.Res.Init(Msg.Okay).MsgEnum = enums.Message.AsEnum(Msg.IterableHasNoItems)
    '     Set InsertRange = Me
    '     Exit Function
            
    ' End If
       
    ' Get the insertion index in terms of the one based indexing used for get range
    ' the +1 is essentially .firstindex
   
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipInsertIndex).IsNotOkay Then Exit Function
    
    Dim myHostStartRun As ResultStartRun
    Set myHostStartRun = Globals.Res.GetResultStartRun
    
  '  If Ranges.TryStartRunFromAnyStartRunEnd(ipIterable, ipStartIndex, ipRun, ipEndIndex, ipRank).IsNotOkay Then Exit Function
    
    ' Dim myInsertIndex As Variant
    ' myInsertIndex = myStartRun.Item(ResultItemsEnums.StartRun(srStartIndex))
        
    ' Adjust start and end indexes from 0 based indexing to 1 based indexing
    ' If Types.IsNotMissing(ipStartIndex) Then ipStartIndex = ipStartIndex + 1
    ' If Types.IsNotMissing(ipEndIndex) Then ipEndIndex = ipEndIndex + 1
        
    'Get the range to insert from ipIterable
    ' Dim myInsertStartRun As ResultStartRun
    ' Set myInsertStartRun = Globals.Res.GetResultStartRun
    
    If Ranges.TryRange(ipIterable, ipStartIndex, ipRun, ipEndIndex, ipRank).IsNotOkay Then Exit Function
        
    Dim myInsertRange As ArrayList
    Set myInsertRange = Globals.Res.Items
    s.Host.InsertRange myHostStartRun.StartIndex - 1, myInsertRange
     
    Globals.Res.SetOkay
    Set InsertRange = Me
        
End Function

'@Description("Returns the index of the last item in the Lyst or -1 if the Lyst count is 0")
Public Property Get LastIndex() As Long
Attribute LastIndex.VB_Description = "Returns the index of the last item in the Lyst or -1 if the Lyst count is 0"
        
    Dim myCount As Long
    myCount = s.Host.Count
    LastIndex = IIf(myCount = 0, -1, myCount)
        
End Property

Public Function LastIndexOf(ByVal ipValue As Variant, Optional ByVal ipStartIndex As Long = 1, Optional ByVal ipCount As Long = 0) As Long
  
    'InitialiseResult
    LastIndexOf = -1
    
    'If BailOut.When(ipCount = 0, Msg.IndexTooLow) Then Exit Function
    
    If ipCount = 0 Then
        
   
        If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex).IsNotOkay Then Exit Function
       
    Else
        
        If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex, ipCount).IsNotOkay Then Exit Function
        
    End If
   
        
    Dim myRangeStartRun As ResultStartRun
    Set myRangeStartRun = Globals.Res.GetResultStartRun
    
    
    If Ranges.TryRange(Me, myRangeStartRun.StartIndex, myRangeStartRun.Run).IsNotOkay Then Exit Function
    Dim myRange As ArrayList
    Set myRange = Globals.Res.Items.Clone
    ' Dim myCount As Long
    ' myCount = Globals.Res.Item(ResultItemsEnums.StartRun(srRunLength))
    
    ' ArrayList.Lastindexof will only accept a value from VBA
    ' adding a starti ndex  or startindex/count gives an error
    ' so we use GetRange to first extract the range for lastindexof
    ' so we can just use .LastIndexOf(value)
    '
    
    Globals.Res.SetOkay
    LastIndexOf = myRange.LastIndexOf(ipValue) + myRangeStartRun.StartIndex ' don't need -1 due to lyst and arraylist
   
End Function

'@Description("Map applies the method defined by the function object to each item of the array and returns a new lyst")
Public Function MapIt(ByVal ipMapper As IMapper) As Lyst
Attribute MapIt.VB_Description = "Map applies the method defined by the function object to each item of the array and returns a new lyst"
        
'    Dim myLyst As Lyst
'    Set myLyst = Lyst.Deb
        
    Dim myIndex As Long
    For myIndex = 0 To LastIndex - 1
        
        s.Host.Item(myIndex) = ipMapper.ExecMapper(s.Host.Item(myIndex))
        
    Next
        
    Set MapIt = Me
        
End Function

'@Description("Add Items to the Host Lyst. Values may be duplicated")
Public Function Merge(ByRef ipLyst As Lyst) As Lyst
Attribute Merge.VB_Description = "Add Items to the Host Lyst. Values may be duplicated"
    
    
    If (ipLyst Is Nothing) Or ipLyst.HasNoItems Then
        
        Set Merge = Me
        Exit Function
        
    End If
    
    s.Host.AddRange ipLyst.ToArrayList
    
    Set Merge = Me
    
End Function

'@Description("Merges new values from the input Lystc")
Public Function MergeByValue(ByRef ipLyst As Lyst) As Lyst
Attribute MergeByValue.VB_Description = "Merges new values from the input Lystc"
    
    If (ipLyst Is Nothing) Or ipLyst.HasNoItems Then
        
        Set MergeByValue = Me
        Exit Function
        
    End If
    
    Dim myitem As Variant
    For Each myitem In ipLyst
        
        If Not s.Host.Contains(myitem) Then s.Host.Add myitem
            
    Next
    
    Set MergeByValue = Me
    
End Function

Public Function ReduceIt(ByVal ipReduce As IReduce) As Variant
    
   ReduceIt = ipReduce.ExecRed(Me)
    
End Function


Public Function RemoveValue(ByVal ipValue As Variant) As Lyst

    Set RemoveValue = Me
    s.Host.Remove ipValue
        
End Function


Public Function RemoveAt(ByVal ipIndex As Variant) As Lyst

    Set RemoveAt = Me
    If Types.Group.IsNotNumber(ipIndex) Then Exit Function
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipIndex).IsNotOkay Then Exit Function
    
    s.Host.RemoveAt ipIndex - 1
    Set RemoveAt = Me
    
End Function


Public Function RemoveRange(Optional ByVal ipStartIndex As Long = 0, Optional ByVal ipCount As Long = -1) As Lyst
        
    Set RemoveRange = Me
    If ipCount < 0 Then
            
        s.Host.Clear
        Exit Function
            
            
    End If
        
    If ipCount = 0 Then Exit Function
    If ipStartIndex < 0 Then Exit Function
    If ipStartIndex >= s.Host.Count Then Exit Function
        
    Dim myCount As Long
        
    If ipStartIndex + ipCount - 1 >= s.Host.Count Then
            
        myCount = s.Host.Count - ipStartIndex + 1
            
            
    Else
            
        myCount = ipCount
            
        
    End If
        
    s.Host.RemoveRange ipStartIndex, myCount
        
End Function

' See Sequence.GetSeries, Sequence.GetConstSeries
''@Description("Adds a repeated value to a Lyst (ArrayList equivalent is Lyst.Deb.Repeat)"
'Public Function Repeat(ByVal ipValue As Variant, ByVal ipCount As Long) As Lyst
'
'    Set Repeat = Me
'    If ipCount < 0 Then Exit Function
'
'    Dim myCount As Long
'    For myCount = 1 To ipCount
'
'        s.Host.Add ipValue
'
'    Next
'
'End Function

Public Function Reverse(Optional ByVal ipStartIndex As Long = 0, Optional ByVal ipCount As Long = 0) As Lyst
        
    Set Reverse = Me
        
    If ipStartIndex < 0 Then Exit Function
    If ipCount < 0 Then Exit Function
        
    If ipStartIndex = 0 And ipCount = 0 Then
        
        s.Host.Reverse
        Exit Function
            
            
    End If
        
    Dim myArrayList As ArrayList
    Set myArrayList = s.Host.GetRange(ipStartIndex, ipCount)
        
    '@Ignore MemberNotOnInterface
    myArrayList.Reverse
    s.Host.SetRange ipStartIndex, myArrayList
        
End Function

Public Function SetRange(ByVal ipStartIndex As Long, ByVal ipIterable As Variant) As Lyst
        
    Set SetRange = Me
    If Ranges.TryStartRunFromAnyStartRunEnd(Me, ipStartIndex).IsNotOkay Then Exit Function
    
    Dim myIterable As ArrayList
    Set myIterable = Types.Iterable.ToArrayList(ipIterable)
    If BailOut.When(myIterable Is Nothing, Msg.HasNoInstance) Then Exit Function
        
    Dim myStartindex As Long
    myStartindex = Globals.Res.Item(ResultItemsEnums.StartRun(srStartindex)) - 1 ' adjust for use with arraylist
    
    Dim myArrayList As ArrayList
    Set myArrayList = New ArrayList
    
    Dim myitem As Variant
    For Each myitem In myIterable
            
        s.Host.Item(myStartindex) = myitem
        myStartindex = myStartindex + 1
        If myStartindex = s.Host.Count Then Exit For
            
    Next
        
    Set SetRange = Me
    
End Function

'@Description("Sorts the whole list. Does not support sorting part of the list")
'ToDo: implement the missing ArrayList sort overloads
' 1 sort from index to end
' 2 sort from index through count
Public Function Sort(Optional ByVal ipStartIndex As Long = 0, Optional ByVal ipCount As Long = -1) As Lyst
Attribute Sort.VB_Description = "Sorts the whole list. Does not support sorting part of the list"
        
    Set Sort = Me
    If ipStartIndex < 0 Then Exit Function
    If ipStartIndex >= s.Host.Count Then Exit Function
    If ipCount = 0 Then Exit Function

    s.Host.Sort                                  'ipStartIndex, myCount
            
        
End Function

Public Function ToArray() As Variant
    ToArray = s.Host.ToArray 'this works fine
    'Return s.Host.toarray
   ' Return (s.Host.ToArray)
End Function

Public Function ToArrayList() As ArrayList
    Set ToArrayList = s.Host.Clone
End Function

Friend Function InjectHostArrayList(ByVal ipArrayList As ArrayList) As Lyst
    Set s.Host = ipArrayList.Clone
    Set InjectHostArrayList = Me
End Function

 Public Function ToString(Optional ByVal ipSeparator As String = vbNullString) As String

    Stringifier.ResetItemSeparator ipSeparator
    Stringifier.ResetArrayMarkup vbNullString, vbNullString, vbNullString
    Stringifier.ResetObjectMarkup vbNullString, vbNullString, vbNullString
    ToString = Stringifier.ToStringByIterable(s.Host)      ' myString
        
        
End Function

'@Description("Transposes a lyst of lysts")
Public Function Transpose() As Lyst
Attribute Transpose.VB_Description = "Transposes a lyst of lysts"
        
    Set Transpose = Nothing
    If BailOut.When(TypeName(s.Host.item(0)) <> "Lyst", Msg.InvalidType) Then Exit Function
        
    Dim myTransposed As Lyst
    Set myTransposed = Lyst.Deb
    Dim myIndex As Long
    For myIndex = s.Host.item(0).firstindex To s.Host.item(0).lastindex ' working with arraylist
        
        myTransposed.Add Lyst.Deb
            
    Next
        
    Dim myitem As Variant
    For Each myitem In s.Host
            
        For myIndex = myitem.firstindex To myitem.LastIndex
                
            myTransposed.Item(myIndex).Add myitem(myIndex)
                
        Next
            
    Next
        
    Set Transpose = myTransposed
        
End Function

Public Function First() As Variant
        
    If BailOut.When(s.Host Is Nothing) Then Exit Function
        
    If VBA.IsObject(s.Host.Item(0)) Then
            
        Set First = s.Host.Item(0)
            
            
    Else
            
        First = s.Host.Item(0)
            
            
    End If
            
End Function

Public Function FirstIndex() As Long
    FirstIndex = 1
End Function

'Public Function Filter(ByRef ipValue As Variant, ) As Lyst
'
'    Dim myLyst As Lyst = Lyst.Deb
'    Dim myItem As Variant
'    For Each myItem In s.Host
'
'        If myItem = ipValue Then myLyst.Add myItem
'
'    Next
'
'End Function
'@Description("Returns a new Lyst comprising of items where the comparer was true.  If Index has a value then the item(index) is compared")
Public Function FilterIt(ipComparer As IComparer, Optional ByVal ipIndex As Variant = 0) As Lyst
Attribute Filter.VB_Description = "Returns a new Lyst comprising of items where the comparer was true.  If Index has a value then the item(index) is compared"
        
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set FilterIt = myLyst
    
    Dim myitem As Variant
    
    If ipIndex = 0 Then
    
        For Each myitem In s.Host
            
            If ipComparer.ExecCmp(myitem) Then myLyst.Add myitem
                   
        Next
        
        Set FilterIt = myLyst
        Exit Function
        
    End If
    
    For Each myitem In s.Host
        
        If Ranges.TryStartRunFromAnyStartRunEnd(myitem, ipIndex).IsNotOkay Then Exit Function
            
        '@Ignore DefaultMemberRequired
        If ipComparer(myitem.Item(Globals.Res.Item(ResultItemsEnums.StartRun(srStartindex)))) Then myLyst.Add myitem
                
    Next
    
        
    Set FilterIt = myLyst
            
End Function

' '@Description "Map applies the method defined by the function object to each item of the array and returns a new lyst"
' Public Function FilterIt(ByVal ipFilter As IFilter) As Lyst
' Attribute FilterIt.VB_Description = "Map applies the method defined by the function object to each item of the array and returns a new lyst"
            
'     Set FilterIt = ipFilter.ExecFilter(Me)
        
            
' End Function

    
Public Function Last() As Variant
        
    If BailOut.When(s.Host Is Nothing) Then Exit Function
    Last = Null
    If s.Host.Count = 0 Then Exit Function
          
    If VBA.IsObject(s.Host.Item(s.Host.Count - 1)) Then
            
        Set Last = s.Host.Item(s.Host.Count - 1)
            
            
    Else
            
        Last = s.Host.Item(s.Host.Count - 1)
            
            
    End If
            
End Function

'@Description(Facilitates enumerating pairs from the Host Lyst and an input iterable. Returns a new lyst comprised of 2 cell arrays, with the host Lyst in (0) and the Input in (1).  If ipIterable is not suppplied, the host lyst is paired with a 1..n sequence with the sequence in (0))
Public Function Zip(Optional ipIterable As Variant = Empty) As Lyst
    
    Dim myIterable As Lyst
    Dim myHostLHS As Boolean
    
    If VBA.IsEmpty(ipIterable) Then
        
        Set myIterable = Ranges.GetSeries(FirstIndex, Count, 1)
        myHostLHS = False
    Else
        
        Set myIterable = Lyst.Deb.AddRange(ipIterable)
        myHostLHS = True
        
    End If
    
    Dim myMin As Long
    myMin = Maths.Min(myIterable.Count, Count)
    
    Dim myIndex As Long
    Dim myZipped As Lyst
    Set myZipped = Lyst.Deb
    For myIndex = 1 To myMin
        
        If myHostLHS Then
            
            myZipped.Add Array(s.Host.Item(myIndex - 1), myIterable.Item(myIndex))
        
            
        Else
            
            myZipped.Add Array(myIterable.Item(myIndex), s.Host.Item(myIndex - 1))
            
            
        End If
            
    Next
    
    Set Zip = myZipped
   
End Function

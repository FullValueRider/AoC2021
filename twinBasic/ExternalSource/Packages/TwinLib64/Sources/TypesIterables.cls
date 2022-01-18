VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TypesIterables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclarediD
'@eXPOSED
'@Folder("VBALib.Types")


Private Sub Class_Initialize()
End Sub

'@Description("Returns the firstindex,lastindex and count in Items.  If the iterable has no items status is false.")
Public Function TryExtent _
( _
    ByVal ipIterable As Variant, _
    Optional ByVal ipRank As Long = Preset.ArrayFirstRank _
) As Result
Attribute TryExtent.VB_Description = "Returns the firstindex,lastindex and count in Items.  If the iterable has no items status is false."
    
    'Items should be accessed using Item(ResultItemsEnums.ItemExtent(enum))
    Set TryExtent = Globals.Res.SetNotOkay
    If BailOut.When(Types.Group.IsNotIterable(ipIterable), Msg.IsNotIterable) Then Exit Function
        
    Select Case True
      
        Case Types.IsString(ipIterable)
        
            Strs.TryExtent ipIterable, ipRank
                

        Case VBA.IsArray(ipIterable)
            ' Does not yet deal with dimensions of more than one.  
            Arrays.TryExtent ipIterable, ipRank
            

        Case Types.Group.IsIterableObject(ipIterable)
            ' Queues and stack type iterables don't allow indexes
                    
            If BailOut.When(Types.Iterable.HasNoItems(ipIterable), Msg.IterableHasNoItems) Then Exit Function
            If BailOut.When(ipRank <> 1, Msg.ItemDoesNotSupportRanks) Then Exit Function
            
            If Types.Group.IsIterableByMethod(ipIterable) Then
                
                Globals.Res.SetOkay(Msg.DoesNotIterateByIndex).SetItems Empty, Empty, ipIterable.Count
                
            ElseIf Types.Group.IsIterableOneBased(ipIterable) Then
                    
                Globals.Res.SetOkay.SetItems 1, ipIterable.Count, ipIterable.Count
                
                
            ElseIf Types.Group.IsIterableItemsByEnum(ipIterable) Then
                            
                Globals.Res.SetOkay.SetItems 0, ipIterable.Count - 1, ipIterable.Count
                
                    
            End If
            
        Case Else
        
            Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.InvalidType)
            
            
    End Select
        
Set TryExtent = Globals.Res
    
End Function

'@Description("Returns the number of items in a valid array or iterable object. An unitialised array returns -1. A collection object returns -1 if nothing and 0 if unpoulated0")")
Public Function Count(ByVal ipIterable As Variant, Optional ByVal ipRank As Long = Preset.ArrayFirstRank) As Long

    Count = -1
    
    If TryExtent(ipIterable, ipRank).IsNotOkay Then Exit Function
        
    Count = Globals.Res.Item(ResultItemsEnums.ItemExtent(ieCount))

End Function

'@Description("Gets  items from an Iterable that does not support itembyindex (e.g. queues and stacks")
Public Function GetByForEach(ByVal ipIterable As Variant, Optional ByVal ipCount As Long = 0) As Lyst
Attribute GetByForEach.VB_Description = "Gets  items from an Iterable that does not support itembyindex (e.g. queues and stacks"
    
    
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    
    Dim myCount As Long
    Dim myitem As Variant
    For Each myitem In ipIterable
    
        myLyst.Add myitem
        myCount = myCount + 1
        If (ipCount > 0) And (myCount > ipCount) Then Exit For
        
    Next
    
    Set GetByForEach = myLyst
    
End Function

Public Function Sum(ByVal ipIterable As Variant) As Variant
        
    If Types.Group.IsNotIterable(ipIterable) Then
        
        If Types.Group.IsNotNumber(ipIterable) Then Exit Function
            
        Sum = -1
        Exit Function
            
    End If
        
    Dim myitem As Variant
    Dim mySum As Double
    For Each myitem In ipIterable
        
        mySum = mySum + myitem
            
    Next
        
    Sum = mySum
        
End Function

Public Function MinMax(ByVal ipIterable As Variant) As Variant
            
    If Types.Group.IsNotIterable(ipIterable) Then
        
        If Types.Group.IsNotNumber(ipIterable) Then Exit Function
            
        MinMax = Array(ipIterable, ipIterable)
        Exit Function
            
    End If
    
    Dim myitem As Variant
    Dim myMax As Variant
    Dim myMin As Variant
    For Each myitem In ipIterable
            
        If VBA.IsEmpty(myMin) Then
            
            myMax = myitem
            myMin = myitem
                
        End If
            
        If myitem < myMin Then myMin = myitem
        If myitem > myMax Then myMax = myitem
            
    Next

    MinMax = Array(myMin, myMax)
        
End Function


'Public Function OfNoUse(ByVal ipForwardedIterable As Variant) As Boolean
'
'    If BailOut.When(Arays.IsNotValid(ipForwardedIterable), Msg.IterableHasNoItems) Then Exit Function
'    If BailOut.When(VBA.IsEmpty(ipForwardedIterable), Msg.IterableIsEmpty) Then Exit Function
'    If BailOut.When(VBA.IsArray(ipForwardedIterable) And (UBound(ipForwardedIterable) < LBound(ipForwardedIterable)), Msg.ArrayHasNoItems) Then Exit Function
'    If BailOut.When(Types.IsNotArray(ipForwardedIterable) And (ipForwardedIterable.Count <= 1), Msg.IterableHasNoItems) Then Exit Function
'    OfNoUse = Not Globals.Res.Init(Msg.Okay).Status
'
'End Function


'@Description("True if the count of items for each iterable is the same, the iterables do not have to be of the same type")
Public Function IsSameSize _
( _
    ByRef ipTestIterable As Variant, _
    ByRef ipRefIterable As Variant, _
    Optional ByVal ipRefRank As Long = 1, _
    Optional ByVal ipTestRank As Long = 1 _
) As Boolean
Attribute IsSameSize.VB_Description = "True if the count of items for each iterable is the same, the iterables do not have to be of the same type"
    IsSameSize = False
    
    If TryExtent(ipTestIterable, ipTestRank).IsNotOkay Then Exit Function
        
    Dim myTestCount As Long
    myTestCount = Globals.Res.Item(ResultItemsEnums.ItemExtent(ieCount))
    
    If TryExtent(ipRefIterable, ipRefRank).IsNotOkay Then Exit Function
    
    Dim myRefCount As Long
    myRefCount = Globals.Res.Item(ResultItemsEnums.ItemExtent(ieCount))
    
    If myTestCount = myRefCount Then
        
        Globals.Res.Init(Msg.Okay).SetItems (Array(myTestCount, myRefCount))
    
        
    Else
        
        Globals.Res.SetNotOkay (Msg.notequal)
        
        
    End If
    
    IsSameSize = Globals.Res.Status
End Function


Public Function IsNotSameSize _
       ( _
       ipTestIterable As Variant, _
       ipRefIterable As Variant, _
       Optional ipTestRank As Long = 1, _
       Optional ipRefRank As Long = 1 _
       ) As Boolean
    'ipTestRank = IIf(VBA.IsMissing(ipTestRank), 1, ipTestRank)
    'ipRefRank = IIf(VBA.IsMissing(ipRefRank), 1, ipRefRank)
    IsNotSameSize = Not IsSameSize(ipTestIterable, ipRefIterable, ipTestRank, ipRefRank)
End Function

'@Description("Returns true if each item in the iterable is the same type")
Public Function IsHomogeneous(ByVal ipIterable As Variant) As Boolean
Attribute IsHomogeneous.VB_Description = "Returns true if each item in the iterable is the same type"

    IsHomogeneous = False
        
    If Not Types.Group.IsIterable(ipIterable) Then
        
        Err.Raise _
        17, _
        "VBALib.Types.IsIterableUniform", _
        "Expected an Iterable by value type"
                
        Exit Function
            
    End If
        
    ' Typename is used to avoid issues of vartype getting the type of the default
    ' member if ipIterable(x) is an object with a default member
    Dim myType  As String
    myType = TypeName(ipIterable(0))
        
    Dim myitem As Variant
    For Each myitem In ipIterable
        
        If TypeName(myitem) <> myType Then Exit Function
        
    Next
        
    IsHomogeneous = True

End Function

Public Function IsNotHomogeneous(ByVal ipArray As Variant) As Boolean
    IsNotHomogeneous = Not IsHomogeneous(ipArray)
End Function

Public Function HasNoItems(ByVal ipArg As Variant, Optional ByVal ipRank As Long = 1) As Boolean
    HasNoItems = Not HasItems(ipArg, ipRank)
End Function

'@Description("Returns true if arg is an array and has ubound of 0 or more, or is an object with a count greater than 0")
Public Function HasItems(ByVal ipArg As Variant, Optional ByVal ipRank As Long = 1) As Boolean
Attribute HasItems.VB_Description = "Returns true if arg is an array and has ubound of 0 or more, or is an object with a count greater than 0"
    
    ' Uninitialised variables will be objects or arrays
    ' not initialised means
    ' an object that is nothing
    ' an array that gives a ubound error
    ' and array that gives a ubound of -1
        
    HasItems = False
        
    If Types.Group.IsNotIterable(ipArg) Then Exit Function

    If VBA.IsArray(ipArg) Then
        
        If Arrays.HasNoItems(ipArg) Then Exit Function
            
    Else
        
            
        'Guard IsNotArray, ipRank <> 1, mcLocation & "HasItems", Array(TypeName(ipArg))
            
        If ipArg.Count <= 0 Then Exit Function

    End If
        
    HasItems = True
        
End Function

Public Function ToArray(ParamArray ipArgArray() As Variant) As Variant

    ToArray = Empty
        
    If BailOut.When(Arrays.HasNoItems(ipArgArray), Msg.ArrayHasNoItems) Then Exit Function
            
    Dim myArrayList As ArrayList
    Set myArrayList = New ArrayList
    Dim myitem As Variant
        
    If UBound(ipArgArray) > 0 Then
            
        For Each myitem In ipArgArray
            
            myArrayList.Add myitem
                
        Next
            
            
    ElseIf VBA.IsArray(ipArgArray(0)) Then
            
        ToArray = ipArgArray(0)
        Exit Function
            
            
    ElseIf Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
        
        Dim myargs As Variant
        myargs = CVar(ipArgArray(0))
        For Each myitem In myargs
                
            myArrayList.Add myitem
                
        Next
            
            
    Else
        
        myArrayList.Add ipArgArray(0)
            
            
    End If
        
    '@Ignore MemberNotOnInterface
    ToArray = myArrayList.ToArray
        
End Function

Public Function ToQueue(ParamArray ipArgArray() As Variant) As Queue
        
    Dim myQueue As Queue
    Set myQueue = New Queue
    Set ToQueue = myQueue

    If Arrays.HasNoItems(ipArgArray) Then Exit Function
        
    Dim myitem As Variant
    If UBound(ipArgArray) > 0 Then
                
        For Each myitem In ipArgArray
                
            '@Ignore MemberNotOnInterface
            myQueue.Enqueue myitem
                    
        Next
                
        Exit Function
                
    End If
            
    ' There is only one argument in ipArgArray
    If Types.IsTypeByName(Types.Name.OfQueue, ipArgArray(0)) Then
                
        Set ToQueue = ipArgArray(0).Clone
        Exit Function
                
    End If
            
    If Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
            
        Dim myargs As Variant
        myargs = CVar(ipArgArray(0))
        For Each myitem In myargs
                    
            '@Ignore MemberNotOnInterface
            myQueue.Enqueue myitem
                    
        Next
                
        Exit Function
                
    End If
            
    '@Ignore MemberNotOnInterface
    myQueue.Enqueue ipArgArray(0)
                
End Function

Public Function ToStack(ParamArray ipArgArray() As Variant) As Stack
        
    Dim myStack As Stack
    Set myStack = New Stack
    Set ToStack = myStack

    If Arrays.HasNoItems(ipArgArray) Then Exit Function
        
    Dim myitem As Variant
    If UBound(ipArgArray) > 0 Then
                
        For Each myitem In ipArgArray
                
            '@Ignore MemberNotOnInterface
            myStack.Push myitem
                    
        Next
                
        Exit Function
                
    End If
            
    ' There is only one argument in ipArgArray
    If Types.IsTypeByName(Types.Name.OfStack, ipArgArray(0)) Then
                
        Set ToStack = ipArgArray(0).Clone
        Exit Function
                
    End If
            
    If Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
            
        Dim myargs As Variant
        myargs = CVar(ipArgArray(0))
        For Each myitem In myargs
                    
            '@Ignore MemberNotOnInterface
            myStack.Push myitem
                    
        Next
                
        Exit Function
                
    End If
            
    '@Ignore MemberNotOnInterface
    myStack.Push ipArgArray(0)
                
End Function

''@Description("For the rare case where we wish to have a single iterable as a single iterable)
'Public Function SingleItemList(ByVal ipValue As Variant) As VBALib.Lyst
'
'    Dim myList As VBALib.Lyst
'    Set myList = New VBALib.Lyst
'    myList.Add ipValue
'    Set SingleItemList = myList
'End Function

Public Function ToArrayList(ParamArray ipArgArray() As Variant) As ArrayList

    Dim myAL As ArrayList
    Set myAL = New ArrayList
    Set ToArrayList = Nothing
        
    If Arrays.IsNotValid(ipArgArray) Then Exit Function
        
    'Dim myResult As Result
    Dim myItem As Variant
    If Arrays.HasOneItem(ipArgArray) Then
            
        If Types.Name.OfArrayList = TypeName(ipArgArray(0)) Then
            
            ' quick win if ipargsarray(0) is already an ArrayList
            Set myAL = ipArgArray(0)
            

        ElseIf Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
            
            Dim myVar As Variant
            If VBA.IsObject(ipArgArray(0)) Then
                Set myVar = ipArgArray(0)
                
            Else
                
                myVar = ipArgArray(0)
                
            End If
            
            For Each myItem In myVar
                
                myAL.add myItem
                
            Next
            
        ElseIf Types.Group.IsIterableKeysByEnum(ipArgArray(0)) Then
            
            For Each myItem In ipArgArray(0).items
                
                myAL.add myItem
                
            Next
            
        Else
            
            myAL.add ipArgArray(0)
            
        End If
        
    Else

        For Each myItem In ipArgArray
                
            myAL.Add myItem
                
        Next
        
    End If
              
    Set ToArrayList = myAL
    
End Function

'@Description("Converts input to Lyst. If ipArgArray is one iterable then the individual items of the iterable are added. Thus to add one iterable as an iterable, encapsulate it in an array")
Public Function ToLyst(ParamArray ipArgArray() As Variant) As Lyst
Attribute ToLyst.VB_Description = "Converts input to Lyst. If ipArgArray is one iterable then the individual items of the iterable are added. Thus to add one iterable as an iterable, encapsulate it in an array"
        
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set ToLyst = myLyst
        
    If Arrays.IsNotValid(ipArgArray) Then Exit Function
        
    'Dim myResult As Result
    If Arrays.HasOneItem(ipArgArray) Then
            
        If Types.IsTypeByName(Types.Name.OfLyst, ipArgArray(0)) Then
                
            Set ToLyst = ipArgArray(0)
            Exit Function
            

        End If
            
        If Parser.ParseVariantWithOneItem(ipArgArray(0)).IsNotOkay Then Exit Function
            
        Dim myParsed As ResultParsedVariant
        Set myParsed = Globals.Res.GetResultParsedVariant
                
        Set ToLyst = myLyst.AddKnownIterableAsItems(myParsed.GetItems)
        
        
    Else
            
        Set ToLyst = Lyst.Deb.AddKnownIterableAsItems(ipArgArray)
       
            
    End If
        
End Function

Public Function ToCollection(ParamArray ipArgArray() As Variant) As Collection
        
    Dim myCollection As Collection
    Set myCollection = New Collection
    Set ToCollection = myCollection

    If Arrays.HasNoItems(ipArgArray) Then Exit Function
        
    Dim myitem As Variant
    If UBound(ipArgArray) > 0 Then
                
        For Each myitem In ipArgArray
                
            myCollection.Add myitem
                    
        Next
                
        Exit Function
                
    End If
            
    ' There is only one argument in ipArgArray
    ' collection doesn't offer the clone method so no quick copy here
    If Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
            
        Dim myargs As Variant
        myargs = CVar(ipArgArray(0))
        For Each myitem In myargs
                    
            myCollection.Add myitem
                    
        Next
                
        Exit Function
                
    End If
            
    myCollection.Add ipArgArray(0)
        
End Function

' Public Function pvGetToThingArray(ByVal ipArgArray As Variant) As Variant
        
'     ' ipArgArray has already been triaged for empty
'     ' ipArgArray is a parameter list from a 'ToThing' method where thing is an iterable array/object
'     ' the intent of this function is to process ipArgArray to an array
'     ' in item 1 of the list.
'     ' In the case of a single item being provided to ipArgArray, and the single item is an
'     ' iterable type, the contents of the iterable type are added item by item
'     '
'     ' In the odd case where a single item is an iterable, which we want to add as
'     ' as single item, then that item should be encapsulated into an array
'     ' when provided as a parameter
        
'     Dim myList As ArrayList
'     Set myList = New ArrayList
        
'     ' if ipArgArray is a single item
'     If UBound(ipArgArray) = 0 Then
        
'         If Types.Group.IsPrimitive(ipArgArray(0)) Then
            
'             myList.Add Array(ipArgArray(0))
                
'         ElseIf Types.Group.IsIterableByMethod(ipArgArray(0)) Then
'             ' captures object like stack and queue
'             Dim myarray As Variant
'             myarray = ipArgArray(0).ToArray
'             myList.Add myarray
                
'         ElseIf Types.Group.IsIterableKeysByEnum(ipArgArray(0)) Then
'             ' captures objects like Scripting.Dictionary and Kvp
'             myList.Add ipArgArray(0).Items
                
'         ElseIf Types.Group.IsIterableItemsByEnum(ipArgArray(0)) Then
'             ' Captures arrays and other object that can be enumerated
'             myList.Add ipArgArray(0)
                
'         End If
            
'     Else
        
'         myList.Add ipArgArray
            
'     End If
        
'     pvGetToThingArray = myList.ToArray

' End Function

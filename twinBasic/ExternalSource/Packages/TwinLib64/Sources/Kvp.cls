VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Kvp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Kvp is a flexible Key/Value pair dictionary targeted at VB/VBA. It facilitates data input, direct content manipulation of items and keys, and indirect manipulation of data via Map and Comparer objects"
Option Explicit
''@IgnoreModule
'@PredeclaredId
'@Exposed
'@Folder("Kvp")
'@ModuleDescription("Kvp is a flexible Key/Value pair dictionary targeted at VB/VBA. It facilitates data input, direct content manipulation of items and keys, and indirect manipulation of data via Map and Comparer objects")
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Keys and Indexing:
' Items in a Kvp may be accessed by Key or by Indexing.  Keys may have any legal value for the type of key in use.
' Indexing for Kvp's is 1 based.  Negative idexes and runs are allowed. Specifying an index of 0 for an insert related
' operation will result in an add operation.
' AutoKeys:
' Three types of autokey are supported
' 1. Number based
' 2. String based: A listt of characters allowed in a key can be specified in a string.
'    The index position in the string is used to determine precedence and not the ascii value.
'    If no character string is provided the string "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
'    is used and the initial key is set to "0000"
' 3. List based: Allowed values are provided to the Autokey as a Lyst of values.  The first key index may be specified
'    so that it does not need to be the index in the first item position of the key list.
' 4. A user defined autokey may be provided and injected into the kvp.  The autokey must implement IAutokey.
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
 
Public Enum KvpAdmin
    
    noindex = 0          '
    SelectByIndex       ' Where a Kvp is being returned as multiple Kvp, set the keys of the sub kvp to be the index from the host Kvp
    SelectByKey         ' Where a Kvp is being returned as multiple Kvp, set the keys of the sub kvp to be the key from the host Kvp
    
End Enum

Public Enum KvpInput
    
    IsAdd          ' Used as a flag to the InputItems private method rather than overloading any Index for insert requests
    IsInsert       ' Used as a flag to the InputItems private method rather than overloading any Index for insert requests
    
End Enum


Const DefaultSeparator                  As string = "," ' can't use asciicode.twcomma
Const Defaultadjustamount               As Long = 1
Const DefaultFirstNumberKey             As Long = 1
Const DefaultFirstStringKey             As String = "0000"

Private Type Properties
  
  Keys                                  As Lyst
  Items                                 As Lyst
  AutoKey                               As IAutoKey
  Separator                             As String
  
End Type

Private p                               As Properties


Private Type State
  
    FirstUse                            As Boolean
    
End Type

Private s                               As State


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class admin
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Private Sub Class_Initialize()
    Set p.Keys = Lyst.Deb
    Set p.Items = Lyst.Deb
End Sub

'@Description("Returns a new instnce of a Kvp Class")
Public Function Deb(Optional ByVal ipKvp As Kvp = Nothing) As Kvp
Attribute Deb.VB_Description = "Returns a new instnce of a Kvp Class"

    'Guard UsePredeclaredIdInstance, Types.IsNotSameInstance(Me, Kvp), i.Location & "Debe"
    
    With New Kvp
    
        If ipKvp Is Nothing Then
            
            Set Deb = .ReadyToUseInstance
            
            
        Else
            
            Set Deb = .ReadyToUseClone(ipKvp)
            
            
        End If
        
    End With
    
End Function


Public Function ReadyToUseInstance() As Kvp

    Set p.AutoKey = Nothing
    s.FirstUse = True

    Set ReadyToUseInstance = Me
        
End Function


Public Function ReadyToUseClone(ByVal ipKvp As Kvp) As Kvp
    
    Set p.Keys = ipKvp.KeysRef.Clone
    Set p.Items = ipKvp.ItemsRef.Clone
    If Types.IsNotNothing(p.AutoKey) Then
        Set p.AutoKey = ipKvp.AutoKey.Clone
    Else
        Set p.AutoKey = Nothing
    End If
    p.Separator = ipKvp.Separator
    s.FirstUse = ipKvp.FirstUse
    Set ReadyToUseClone = Me

End Function


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class friend members
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C

' Used internally when inputting.
Friend Property Get FirstUse() As Boolean
    FirstUse = s.FirstUse
End Property

' Used when cloning the kvp.
Friend Property Let FirstUse(ByVal ipBoolean As Boolean)
    s.FirstUse = ipBoolean
End Property


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class public members
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'#Region "Adding stuff"
''@Description("Adds items in the ParamArray and then returns itself. If ParamArray holds only 1 or 2 items the items are interpreted differently to  when more than two items are added")
'
' Case of 1 Item
'
'   NonIterable         autokey vs item
'   ListArray           autokeysequence vs ListArray
'   TableArray          autokeysequence vs table rows
'   MSArray             Invalid
'   Collection,ArrayList,Lyst,Queue,Stack  autokeysequence vs iterable
'   Scripting.Dictionary, Kvp               autokeysequence vs items
'
'Case of 2 Items
'
'   Item 1: Non Iterable                        Key:Item1, Item:Item2
'   Item 1: ListArray :Item 2: NonIterable      Invalid
'   Item 1: Tablearray :Item2: NonIterable TableToLystAction
'  ListArray or IsIterableItemsByEnum:   Lyst of Autokeys , ListArray(sic) or IsIterableItemsByEnum Items
' IsIterableKeysByEnum:                 iparg.Keys, iparg.Items
' TableArray:                           LystOfAutoKeys, rows as Kvps
' KvPair:                               array(iparg.Key),arrray(iparg.Item)
' To add an iterable as 1 item, encapsulate the iterable in an array e.g. .add array(Iteable)
' 2 items
'
' IsPrimitive, Anything:                array(ipParamOne), array(ipParamTwo)
' Is
'
'
' More than 2 items                     Lyst(AutoKeys), ParamArray
'
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Add and Insert methods have a lot of commonality in the preprocessing of the input param array.
' To simplify coding such preprocessing is consolidated into the InputItems method 

'@Description("Adds items in the ParamArray, returns the updated kvp. If ParamArray is 1 or 2 items the items are parsed as potential key/value pairs.")
Public Function Add(ParamArray ipArgArray() As Variant) As Kvp
Attribute Add.VB_Description = "Adds items in the ParamArray, returns the updated kvp. If ParamArray is 1 or 2 items the items are parsed as potential key/value pairs."
    InputItems KvpInput.IsAdd, ipArgArray
    Set Add = Me
End Function


'@Description("Sugar for Add")
Public Function Enqueue(ParamArray ipArgArray() As Variant) As Kvp
Attribute Enqueue.VB_Description = "Sugar for Add"
    InputItems KvpInput.IsAdd, ipArgArray
    Set Enqueue = Me
End Function



'@Description("Returns the updated Kvp. All Items are inserted Before the specified Index. Order of the ParamArray is preserved.)
Public Function InsertAt(ByVal ipInsertIndex As Long, ParamArray ipArgArray() As Variant) As Kvp
    InputItems KvpInput.IsInsert, ipArgArray, ipInsertIndex
    Set InsertAt = Me
End Function


'@Description("Returns the updated Kvp.  All Items are inserted After the specified key. The order of the ParamArray is preserved.")
Public Function InsertAfterKey(ByVal ipKey As Variant, ParamArray ipArgArray() As Variant) As Kvp
Attribute InsertAfterKey.VB_Description = "Returns the updated Kvp.  All Items are inserted After the specified key. The order of the ParamArray is preserved."
    
    If BailOut.When(p.Keys.LacksItem(ipKey), Msg.KeyNotFound) Then Exit Function
        
    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey)
    
    If myIndex = p.Keys.LastIndex Then
        
        InputItems KvpInput.IsAdd, ipArgArray
        
    Else
    
        InputItems KvpInput.IsInsert, ipArgArray, myIndex
        
    End If
    
    Set InsertAfterKey = Me
End Function

'@Description("Returns the Modified Kvp.  All Items are inserted Before the specified Key.  The Order of the Paramarray is preserved")
Public Function InsertBeforeKey(ByVal ipKey As Variant, ParamArray ipArgArray() As Variant) As Kvp
Attribute InsertBeforeKey.VB_Description = "Returns the Modified Kvp.  All Items are inserted Before the specified Key.  The Order of the Paramarray is preserved"
    
    If BailOut.When(p.Keys.LacksItem(ipKey), Msg.KeyNotFound) Then Exit Function
        
    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey)
    
    InputItems KvpInput.IsInsert, ipArgArray, myIndex
        
    Set InsertBeforeKey = Me
End Function


Private Function InsertByKey(ByVal ipArgArray As Variant, ByRef ipKey As Variant, Optional ByVal ipOffset As Long) As Kvp
    
    Set InsertByKey = Me
    Globals.Res.SetNotOkay
    
    If BailOut.When(Arrays.IsNotValid(ipArgArray), Msg.ParamArrayIsNotValid) Then Exit Function
        
        
    If VBA.IsEmpty(ipKey) Then Exit Function
    If Types.Group.IsIterable(ipArgArray) Then
      If Types.Iterable.HasNoItems(ipArgArray) Then
        
        Globals.Res.SetNotOkay Msg.InvalidKey
        
      End If
    End If
    If p.Keys.LacksItem(ipKey) Then Exit Function
    If Types.Group.IsIterable(ipKey) Then Exit Function
        
    InputItems ipArgArray, p.Keys.IndexOf(ipKey) + ipOffset
    
    Set InsertByKey = Me
End Function

    
'@Description("Returns the the modified Kvp. Items are added at LastIndex. The order in ParamArray is preserved")
Public Function Push(ParamArray ipArgArray() As Variant) As Kvp
Attribute Push.VB_Description = "Returns the the modified Kvp. Items are added at LastIndex. The order in ParamArray is preserved"
    InputItems KvpInput.IsAdd, ipArgArray
    Set Push = Me
End Function
'#End Region


'@Description("Keys/Value pairs from the input Kvp are added if missing from the host kvp")
Public Function MergeByKey(ByRef ipKvp As Kvp) As Kvp
Attribute MergeByKey.VB_Description = "Keys/Value pairs from the input Kvp are added if missing from the host kvp"
    
    If (ipKvp Is Nothing) Or ipKvp.HasNoItems Then
        
        Set MergeByKey = Me
        Exit Function
        
    End If
    
    Dim myKey As Variant
    For Each myKey In ipKvp.Keys
        
        If p.Keys.LacksItem(myKey) Then
            
            p.Keys.Add myKey
            p.Items.Add ipKvp.Item(myKey)
            
        End If
        
    Next
    
    Set MergeByKey = Me
    
End Function

'@Description("Keys/Value pairs from the input Kvp are added to the host kvp based on the Key. If the key exits the value is overwritten, if the key does not exist the pair is added")
Public Function MergeByValue(ByRef ipKvp As Kvp) As Kvp
Attribute MergeByValue.VB_Description = "Keys/Value pairs from the input Kvp are added to the host kvp based on the Key. If the key exits the value is overwritten, if the key does not exist the pair is added"
    
    If (ipKvp Is Nothing) Or ipKvp.HasNoItems Then
        
        Set MergeByValue = Me
        Exit Function
        
    End If
    
    Dim myKey As Variant
    For Each myKey In ipKvp.Keys
        
        If p.Keys.HoldsItem(myKey) Then
            
            p.Items.Item(p.Keys.IndexOf(myKey)) = ipKvp.Item(myKey)
            
        End If
        
    Next
    
    Set MergeByValue = Me
    
End Function

'#Region "Removing Stuff"

'@Description("Items are popped from Last index of the host.  Returns a Kvp of two Kvp.  Item(0) popped items. Item(1) is the modified host kvp.")
Public Function Pop(Optional ByVal ipCount As Long = 1) As Kvp
Attribute Pop.VB_Description = "Items are popped from Last index of the host.  Returns a Kvp of two Kvp.  Item(0) popped items. Item(1) is the modified host kvp."
    ' ToDo: Broken - needs refactoring
    Dim myResult As Kvp
    Set myResult = Kvp.Deb
'
'
'    If ipCount = 0 Then
'
'        myResult.Add Kvp.Deb
'        myResult.Add Me
'        Set Pop = myResult
'        Exit Function
'
'
'    End If
'
    If ipCount > p.Keys.Count Then
''
''        Reverse
''        myResult.Add Me.Clone
''
''        Remove
''        myResult.Add Me
''        Set Pop = myResult
''        Exit Function
''
'
   End If
'
'    Dim mystartrun As Result
'    If Ranges.TryStartRunFromAnyStartRunEnd(p.Keys, ipRun:=-ipCount).IsNotOkay Then
'
'
'        myResult.Add Kvp.Deb
'        myResult.Add Me
'        Set Pop = myResult
'        Exit Function
'
'    End If
'
'    Set mystartrun = Globals.Res.GetResultStartRun
'
'
'    Dim myStartIndex As Long
'    myStartIndex = mystartrun.
'    Dim myRun As Long
'    myRun = mystartrun.Run
'
'    myResult.Add Kvp.Deb.Add(p.Keys.GetRange(myStartIndex, myRun).Reverse, p.Items.GetRange(myStartIndex, myRun).Reverse)
'
'    p.Keys.RemoveRange myStartIndex, myRun
'    p.Items.RemoveRange myStartIndex, myRun
'
'    myResult.Add Me
   Set Pop = myResult
            
End Function


'@Description("Returns the modified Kvp. Removes the Key/Item pairs specified. If no argument is provided the whole Kvp is cleared")
Public Function RemoveKeys(ParamArray ipKeys() As Variant) As Kvp
Attribute RemoveKeys.VB_Description = "Returns the modified Kvp. Removes the Key/Item pairs specified. If no argument is provided the whole Kvp is cleared"
    
    If Arrays.HasNoItems(ipKeys) Then
        
        p.Keys.Clear
        p.Items.Clear
        Set RemoveKeys = Me
        Exit Function
        
        
    End If
    
    'Dim myResult As Result
    Dim myKeys As Variant
    If Arrays.HasOneItem(ipKeys) Then
        
        If Parser.ParseVariantWithOneItem(ipKeys).IsNotOkay Then
            
            Set RemoveKeys = Me
            Exit Function
            
        Else
            
            Set myKeys = Globals.Res.Item(ResultItemsEnums.ParsedVariant(pvItems))
            
        End If
        
    Else
        
        myKeys = ipKeys
        
    End If
    
    Dim myKey As Variant
    For Each myKey In myKeys
        
        Dim myIndex As Long
        If p.Keys.HoldsItem(myKey) Then
            
            myIndex = p.Keys.IndexOf(myKey)
            p.Keys.RemoveAt myIndex
            p.Items.RemoveAt myIndex
            
        End If
        
    Next
    
    Set RemoveKeys = Me
   
End Function


'@Description("Returns a Kvp removed items.  Items are removed from FirstIndex.")
Public Function Dequeue(Optional ByVal ipCount As Long = 1) As Kvp
Attribute Dequeue.VB_Description = "Returns a Kvp removed items.  Items are removed from FirstIndex."
    
    Dim myKvp As Kvp
    Set myKvp = Kvp.Deb
    Set Dequeue = myKvp
    If ipCount < 1 Then Exit Function
        
    If ipCount > Count Then
        
        Set myKvp.Keys = Keys.Clone
        Set myKvp.Items = Items.Clone
        Set Dequeue = myKvp
       
    End If
    
    Dim myIndex As Long
    For myIndex = 1 To ipCount
        
        Dim myKey As Variant
        Set myKey = p.Keys.Dequeue
        Dim myItem As Variant
        Set myItem = p.Items.Dequeue
        myKvp.Add p.Keys.Dequeue.First, p.Items.Dequeue.First
        
    Next
    Set Dequeue = myKvp
End Function


'@Description("Returns a KVPair of the Key and Item from the specified Key. If Key is not specified uses LastIndex.Deletes the Key and Item from the host Kvp")
Public Function Pull(Optional ByVal ipKey As Variant) As KVPair
Attribute Pull.VB_Description = "Returns a KVPair of the Key and Item from the specified Key. If Key is not specified uses LastIndex.Deletes the Key and Item from the host Kvp"

    Dim myIndex As Long
    If (VBA.IsMissing(ipKey) Or VBA.IsEmpty(ipKey)) Then
        
        myIndex = LastIndex
        
        
    ElseIf Types.Group.IsIterable(ipKey) Then
        
        If Types.Group.IsIterableByIndex Then
            
            myIndex = ipKey(0)
            
        Else
            
            
            myIndex = Types.Iterable.GetByForEach(ipKey, 1).Item(0)
            
        End If
        
    End If
        
    If (VBA.IsMissing(ipKey) Or VBA.IsEmpty(ipKey)) Then
        
        myIndex = LastIndex
        
    Else
        
        myIndex = p.Keys.IndexOf(ipKey)
        
    End If

    Set Pull = KVPair.Deb(ipKey, p.Items.Item(myIndex))
    p.Keys.RemoveAt myIndex
    p.Items.RemoveAt myIndex

End Function


'@Description("Returns a KVPair of the Key and Item from the specified index. Deletes the Key and Item from the host Kvp")
Public Function PullAt(ByVal ipIndex As Long) As KVPair
Attribute PullAt.VB_Description = "Returns a KVPair of the Key and Item from the specified index. Deletes the Key and Item from the host Kvp"

    If ipIndex < 1 Or ipIndex > Count Then
        
        Set PullAt = KVPair.Deb
        Exit Function
        
        
    End If
    
    Set PullAt = KVPair.Deb(p.Keys.Item(ipIndex), p.Items.Item(ipIndex))
    p.Keys.RemoveAt ipIndex
    p.Items.RemoveAt ipIndex

End Function


'@Description("Returns a KVPair of the Key and Item at Index 0. Deletes the Key and Item from the host Kvp")
Public Function PullFirst() As KVPair
Attribute PullFirst.VB_Description = "Returns a KVPair of the Key and Item at Index 0. Deletes the Key and Item from the host Kvp"
    
    Set PullFirst = PullAt(FirstIndex)
    
End Function


'@Description("Returns a KVPair of the Key and Item at Last Index. Deletes the Key and Item from the host Kvp")
Public Function PullLast() As KVPair
Attribute PullLast.VB_Description = "Returns a KVPair of the Key and Item at Last Index. Deletes the Key and Item from the host Kvp"
    
    Set PullLast = PullAt(LastIndex)
    
End Function

Public Function ReduceIt(ByVal ipReduce As IReduce) As Variant
    
    Dim myV As Variant
    myV = Array(ipReduce.ExecRed(Me.Items))
    
    If VBA.IsObject(myV(0)) Then
    
        Set ReduceIt = myV(0)
        
        
    Else
        
        ReduceIt = myV(0)
        
        
    End If
     
 End Function

'@Description("Returns the Result object which indicates the status of the last method call")
Public Function Res() As Result
Attribute Res.VB_Description = "Returns the Result object which indicates the status of the last method call"
  Set Res = Globals.Res
End Function


'@Ignore FunctionReturnValueAlwaysDiscarded
Public Function Remove(Optional ByVal ipKey As Variant) As Kvp
    
    Dim myIndex As Long
    Dim myKeys As Variant
    If VBA.IsMissing(ipKey) Then
    
        p.Keys.Clear
        p.Items.Clear
        Set Remove = Me
        Exit Function
        
    ElseIf Types.Group.IsNotIterable(ipKey) Then
        
        myIndex = p.Keys.IndexOf(ipKey)
        p.Keys.RemoveAt (myIndex)
        p.Items.RemoveAt (myIndex)
        Set Remove = Me
        Exit Function
        
    ElseIf Types.Group.IsNotIterableByIndex Then
        
        Set myKeys = Types.Iterable.GetByForEach(ipKey)
        
        
    Else
        
        Set myKeys = ipKey
        
        
    End If
    
    Dim myKey As Variant
    For Each myKey In myKeys
    
        myIndex = p.Keys.IndexOf(myKey)
        p.Keys.RemoveAt myIndex
        p.Items.RemoveAt myIndex
        
    Next
    
    Set Remove = Me
    
End Function


Public Function RemoveAt(ByVal ipIndex As Long) As Kvp
    
    p.Items.RemoveAt ipIndex
    p.Keys.RemoveAt ipIndex
    
    Set RemoveAt = Me
    
End Function


'@Description("Returns the modified host Kvp after removing the Key and Item at Index 0")
Public Function RemoveFirst() As Kvp
Attribute RemoveFirst.VB_Description = "Returns the modified host Kvp after removing the Key and Item at Index 0"
    Set RemoveFirst = RemoveAt(FirstIndex)
End Function


'@Description("Returns the modified host Kvp after removing the Key and Item at LastIndex")
Public Function RemoveLast() As Kvp
Attribute RemoveLast.VB_Description = "Returns the modified host Kvp after removing the Key and Item at LastIndex"
    Set RemoveLast = RemoveAt(LastIndex)
End Function

'#End Region


Public Function Clear() As Kvp
    p.Keys.Clear
    p.Items.Clear
    p.AutoKey.CurrentKey = Empty
    Set Clear = Me
    
End Function


' The Kvp (and Lyst) classes use 1 based indexing
' To differentiate between a count of items and an object having no items
' Count returns a variant and uses Boolean False to indicate that the object cannot be counted
' as it has no Items.
' A bettter test for a count of 0 is Types.Iterable.HasNoItems
' as this will succeed with any iterable type
'@Description("Returns the number of key/item pairs in the Kvp. If there are no items the value returned is -1")
Public Function Count() As Variant
Attribute Count.VB_Description = "Returns the number of key/item pairs in the Kvp. If there are no items the value returned is -1"
    Count = p.Keys.Count
End Function


    
'@Description("Returns the number of Items in the Lyst for which the comparer is true)")
Public Function CountIt(ByRef ipComparer As IComparer) As Long
Attribute CountIt.VB_Description = "Returns the number of Items in the Lyst instance equal to ipValue)"
  
    Dim myCounter As Long
    myCounter = 0
    Dim myitem As Variant
    For Each myitem In p.Items

        If ipComparer.ExecCmp(myitem) Then myCounter = myCounter + 1
        
            
    Next

    CountIt = myCounter
  
End Function


'@Description("Returns a copy of the Kvp. If Items are objects then a shallow copy is made unless the object supports a clone Method.")
Public Function Clone() As Kvp
Attribute Clone.VB_Description = "Returns a copy of the Kvp. If Items are objects then a shallow copy is made unless the object supports a clone Method."
    
    Set Clone = Kvp.Deb(Me)
    
End Function


'@Description("Decrements the Items  at the given Keys by the specified amount if the Items are Numbers")
Public Function Dec(Optional ByVal ipKeys As Variant = Empty, Optional ByVal ipDecrement As Variant = Preset.DefaultDec) As Kvp
Attribute Dec.VB_Description = "Decrements the Items  at the given Keys by the specified amount if the Items are Numbers"

    Globals.Res.Init (Msg.Okay)
    
    If BailOut.When(Types.Group.IsNotNumber(ipDecrement), Msg.IsNotNumber, ipAltMessage:="The increment variable is not a number") Then Exit Function
    If BailOut.When(ipDecrement = 0, Msg.ZeroIsInvalidParameter) Then Exit Function
        
    AdjustbyKey ipKeys, -ipDecrement
    Set Dec = Me
    
End Function


'@Description("Decrements the Items at the given indexes by the specified amount if the Items are Numbers")
Public Function DecAt(ByVal ipIndexes As Variant, Optional ByVal ipDecrement As Single) As Kvp
Attribute DecAt.VB_Description = "Decrements the Items at the given indexes by the specified amount if the Items are Numbers"
    If ipDecrement = 0 Then ipDecrement = Defaultadjustamount
    AdjustByIndex ipIndexes, -ipDecrement
    Set DecAt = Me
End Function


Public Function FirstIndex() As Long
    FirstIndex = 1
End Function


'@Description("Returns a Kvp comprised of Key/Item pairs where the Key appears in both the Host Kvp and the input parameter")
Public Function FilterByKeys(ByVal ipKeysIterable As Variant) As Kvp
Attribute FilterByKeys.VB_Description = "Returns a Kvp comprised of Key/Item pairs where the Key appears in both the Host Kvp and the input parameter"
    ' Preference should be given to using the specific KeysIn<xxx> method
    Dim myResult As Kvp
    Set myResult = Me.Deb
    Set FilterByKeys = myResult

    If VBA.IsEmpty(ipKeysIterable) Then Exit Function

    Dim myKeys As Lyst
    If Types.IsTypeByName(Types.Name.OfLyst, ipKeysIterable) Then

        Set myKeys = ipKeysIterable


    ElseIf Types.Group.IsIterableKeysByEnum(ipKeysIterable) Then

        Set myKeys = Types.Iterable.ToLyst(ipKeysIterable.Keys)


    Else

        Set myKeys = Types.Iterable.ToLyst(ipKeysIterable)


    End If

    myResult.Add 0&, Me.KeysInAandB(myKeys)
    myResult.Add 1&, Me.KeysInAOnly(myKeys)
    myResult.Add 2&, Me.KeysInBOnly(myKeys)

    Set FilterByKeys = myResult
    
End Function


'@Description("Returns a KVPair of the Key and Item at FirstIndex")
Public Function GetFirst() As KVPair
Attribute GetFirst.VB_Description = "Returns a KVPair of the Key and Item at FirstIndex"
    
    If p.Keys.Count = 0 Then
        
        Set GetFirst = KVPair.Deb
        
    Else
        
        Set GetFirst = KVPair.Deb(p.Keys.Item(1), p.Items.Item(1))
        
    End If
    
End Function


'@Description("Returns a Kvp of Key vs Index at which the key is found")
Public Function GetKeysWithValue(ByVal ipValue As Variant, Optional ByVal ipIndexer As KvpAdmin = KvpAdmin.SelectByIndex) As Kvp
Attribute GetKeysWithValue.VB_Description = "Returns a Kvp of Key vs Index at which the key is found"
    
    If Not p.Items.HoldsItem(ipValue) Then
    
        Set GetKeysWithValue = Nothing
        Exit Function
        
    End If
    
    Dim myResult As Kvp
    Set myResult = Me.Deb

    Dim myIndex As Long
    For myIndex = 0 To Me.LastIndex

        If p.Items.Item(myIndex) = ipValue Then
        
            If ipIndexer - KvpAdmin.SelectByIndex Then
            
                myResult.Add p.Keys.Item(myIndex), myIndex
                
            Else
                
                myResult.Add myIndex, p.Keys.Item(myIndex)
                
            End If
            
        End If
        
    Next

    Set GetKeysWithValue = myResult
    
End Function

'@Description("Returns the 1 based index of the Key")
Public Function GetIndexOfKey(ByVal ipKey As Variant) As Long
Attribute GetIndexOfKey.VB_Description = "Returns the 1 based index of the Key"

    If Types.IsEmpty(ipKey) Then
    
        GetIndexOfKey = -1
        
    Else
        
        GetIndexOfKey = p.Keys.IndexOf(ipKey)
        
    End If
    
End Function


'@Description("Returns a kvp of Index vs Key")
Public Function GetIndexOfValue(ByVal ipValue As Variant, Optional ByVal ipOrganiseby As KvpAdmin = KvpAdmin.SelectByIndex) As Kvp
Attribute GetIndexOfValue.VB_Description = "Returns a kvp of Index vs Key"
    's.values may hold more than one item with the same value so we return a Kvp
    Set GetIndexOfValue = Me.MirrorByValue(ipOrganiseby).Item(ipValue)
End Function

' '@Description("Returns a shallow copy of the Keys")
' Public Function GetKeys() As Lyst
' Attribute GetKeys.VB_Description = "Returns a shallow copy of the Keys"
    
'     If p.Keys Is Nothing Then
    
'         Set GetKeys = Lyst.Deb
        
'     Else
    
'         Set GetKeys = p.Keys
        
'     End If
    
' End Function

'@Description("Returns a KVPair of the Key and Item at LastIndex")
Public Function GetLast() As KVPair
Attribute GetLast.VB_Description = "Returns a KVPair of the Key and Item at LastIndex"
    Set GetLast = KVPair.Deb(p.Keys.Item(Me.LastIndex), p.Items.Item(Me.LastIndex))
End Function



' <summary> NextPair/PrevPair get the indicated KVPair from the Host
' Dictionary. These methods are not intended to be used as iterators
' but as ad hoc requests for the next/prev KVPair in the Kvp. If the
' supplied key is the last/first key in the Dictionary then ipLoop
' will determine if the KVPair returned will be null:null (ipLoop =
' false) or the first/last KVPair in the Dictionary (ipLoop=True)
' </summary> <paramname="ipKey">The Key for which the next/prev
' KVPair should be returned. <paramname="ipLoop">Wraps around the
' Dictionary if True </param> <returns>The Indicated KVPair</returns></param>
Public Function NextPair(ByVal ipKey As Variant, Optional ByVal ipTreatKeysArrayAsLoop As Boolean = True) As KVPair
Attribute NextPair.VB_Description = "Returns a Lyst of the specified Items. An empty Paramarray will return all Iems. If the item is an object the Clone methos will be used if available. "

    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey) + 1

    If myIndex > p.Keys.LastIndex Then
    
        If ipTreatKeysArrayAsLoop Then
        
            Set NextPair = GetFirst
            
            
        Else
        
            Set NextPair = Nothing
            
            
        End If
        
    Else
    
        Set NextPair = KVPair.Deb(p.Keys.Item(myIndex), p.Items.Item(myIndex))
        
        
    End If
    
End Function


Public Function PrevPair(ByVal ipKey As Variant, Optional ByVal ipTreatKeysArrayAsLoop As Boolean = True) As KVPair

    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey) - 1

    If myIndex < 0 Then
    
        If ipTreatKeysArrayAsLoop Then
        
            Set PrevPair = KVPair.Deb(p.Keys.Item(Me.LastIndex), p.Items.Item(Me.LastIndex))
            
        Else
        
            Set PrevPair = Nothing
            
        End If
        
    Else
    
        Set PrevPair = KVPair.Deb(p.Keys.Item(myIndex), p.Items.Item(myIndex))
        
    End If
    
End Function

'@Description("Returns True if the value is a Key of the Kvp")
Public Function HoldsKey(ByVal Key As Variant) As Boolean
Attribute HoldsKey.VB_Description = "Returns True if the value is a Key of the Kvp"
    HoldsKey = p.Keys.HoldsItem(Key)
End Function

'@Description("Returns True if the value is an Item of the Kvp")
Public Function HoldsItem(ByVal ipValue As Variant) As Boolean
Attribute HoldsItem.VB_Description = "Returns True if the value is an Item of the Kvp"
    HoldsItem = p.Items.HoldsItem(ipValue)
End Function

'@Description("Increments the Items  at the given Keys by the specified amount if the Items are Numbers")
Public Function Inc(Optional ByVal ipKeys As Variant = Empty, Optional ByVal ipIncrement As Double) As Kvp
Attribute Inc.VB_Description = "Increments the Items  at the given Keys by the specified amount if the Items are Numbers"
    If ipIncrement = 0 Then ipIncrement = Defaultadjustamount
    
    AdjustbyKey ipKeys, ipIncrement
    Set Inc = Me
End Function


Public Function IncAt(Optional ByVal ipIndexes As Variant = Empty, Optional ByVal ipIncrement As Double) As Kvp
    If ipIncrement = 0 Then ipIncrement = Defaultadjustamount
   
    AdjustByIndex ipIndexes, ipIncrement
    Set IncAt = Me
End Function

'@Description("True if Count = 0, added to match terminology in Lyst and Group Iterable/Arrays")
Public Function HasNoItems() As Boolean
Attribute HasNoItems.VB_Description = "True if Count = 0, added to match terminology in Lyst and Group Iterable/Arrays"

    If p.Keys Is Nothing Then
        
        HasNoItems = True
        
    ElseIf p.Keys.Count = 0 Then
    
        HasNoItems = True
        
    Else
        
        HasNoItems = False
        
    End If
    
End Function


'@Description("True if Count > 0, added to match terminology in Lyst and Group Iterable/Arrays")
Public Function HasItems() As Boolean
Attribute HasItems.VB_Description = "True if Count > 0, added to match terminology in Lyst and Group Iterable/Arrays"
    HasItems = Not HasNoItems
End Function

'@Description("Returns true if the items values onlu occur once")
Public Function IsUnique() As Boolean
Attribute IsUnique.VB_Description = "Returns true if the items values onlu occur once"
    IsUnique = Me.MirrorFirstValues.Item(2&).Count = 0
End Function

'@Description("Returns True is Item values occur more than once")
Public Function IsNotUnique() As Boolean
Attribute IsNotUnique.VB_Description = "Returns True is Item values occur more than once"
    IsNotUnique = Not IsUnique
End Function



'@DefaultMember
Public Property Get Item(ByVal ipKey As Variant) As Variant
Attribute Item.VB_UserMemId = 0
    
    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey)
    If IsObject(p.Items.Item(myIndex)) Then
    
        Set Item = p.Items.Item(myIndex)
        
    Else
    
        Item = p.Items.Item(myIndex)
    
    End If
    
End Property

Public Property Let Item(ByVal ipKey As Variant, ByVal ipValue As Variant)
    
    If BailOut.When(VBA.IsEmpty(ipKey), Msg.HasNoItems) Then Exit Property
    
    Dim myIndex As Long
    myIndex = p.Keys.IndexOf(ipKey)
    If VBA.IsObject(ipValue) Then
    
        Set p.Items.Item(myIndex) = ipValue
        
    Else
    
        p.Items.Item(myIndex) = ipValue
        
    End If
    
End Property


Public Property Get ItemAt(ByVal ipIndex As Long) As Variant
    
    If BailOut.When(ipIndex < 0, Msg.IndexBeforeFirstIndex) Then Exit Property
    If BailOut.When(ipIndex > Me.LastIndex, Msg.IndexAfterLastIndex) Then Exit Property
    
    If IsObject(p.Items.Item(ipIndex)) Then
    
        Set ItemAt = p.Items.Item(ipIndex)
        
    Else
    
        ItemAt = p.Items.Item(ipIndex)
        
    End If
    
End Property

Public Property Set ItemAt(ByVal ipIndex As Long, ByVal ipValue As Variant)
    
    If BailOut.When(ipIndex < 0, Msg.IndexBeforeFirstIndex) Then Exit Property
    If BailOut.When(ipIndex > Me.LastIndex, Msg.IndexAfterLastIndex) Then Exit Property

    If IsObject(ipValue) Then
    
        Set p.Items.Item(ipIndex) = ipValue
        
    Else
    
        p.Items.Item(ipIndex) = ipValue
        
    End If
    
End Property


'@Description("Returns a variant containing an array of the Items For alignment with Scripting.Dictionaries. See Method ItemsRef for a reference to the Items lyst")
Public Function Items() As Variant
Attribute Items.VB_Description = "Returns a variant containing an array of the Items For alignment with Scripting.Dictionaries. See Method ItemsRef for a reference to the Items lyst"
  Items = p.Items.ToArray
End Function


'@Description("Returns a reference to the Kvp Items Lyst")
Public Function ItemsRef() As Lyst
Attribute ItemsRef.VB_Description = "Returns a reference to the Kvp Items Lyst"
    Set ItemsRef = p.Items
End Function


'@Description("Returns a variant containing an array of the keys. For alignment with Scripting.Dictionaries. See Method KeysRef for a reference to the Keys lyst")
Public Function Keys() As Variant
Attribute Keys.VB_Description = "Returns a variant containing an array of the keys. For alignment with Scripting.Dictionaries. See Method KeysRef for a reference to the Keys lyst"

    Keys = p.Keys.ToArray
  
End Function

'@Description("Returns a reference to the Host Keys")
Public Function KeysRef() As Lyst
Attribute KeysRef.VB_Description = "Returns a reference to the Host Keys"

    Set KeysRef = p.Keys
End Function

Public Function KeysInAOnly(ByVal ipB As Variant) As Kvp

    Dim myResult As Kvp
    Set myResult = Me.Deb

    Dim myKey As Variant
    For Each myKey In p.Keys

        If ipB.LacksKey(myKey) Then
        
            myResult.Add myKey, Me.Item(myKey)
            
        End If
        
    Next

    Set KeysInAOnly = myResult
    
End Function


Public Function KeysInBOnly(ByVal ipB As Variant) As Kvp

    Dim myResult As Kvp
    Set myResult = Me.Deb

    Dim myKey As Variant
    For Each myKey In ipB.Keys

        If Me.LacksKey(myKey) Then
        
            myResult.Add myKey, ipB.Item(myKey)
            
        End If
        
    Next

    Set KeysInBOnly = myResult
    
End Function


Public Function KeysAllAandOnlyB(ByVal ipB As Variant) As Kvp

    Dim myResult As Kvp
    Set myResult = Me.Clone
    
    Dim myResultB As Kvp
    Set myResultB = Me.KeysInBOnly(ipB)
    myResult.Add myResultB.KeysRef, myResultB.ItemsRef
    
    Set KeysAllAandOnlyB = myResult
    
End Function


Public Function KeysInAandB(ByVal ipB As Variant) As Kvp
    
    Dim myResult As Kvp
    Set myResult = Me.Deb
    
    Dim myKey As Variant
    For Each myKey In p.Keys
    
        If ipB.HoldsKey(myKey) Then
    
            myResult.Add myKey, Me.Item(myKey)
    
        End If
        
    Next
    
    Set KeysInAandB = myResult
    
End Function


Public Function KVPairsInAandB(ByVal ipB As Variant) As Kvp
    ' myInB is used for keys in B that have a different value to A
    Dim myResult As Kvp
    Set myResult = Me.Deb
    
    Dim myKey As Variant
    For Each myKey In p.Keys
    
        If ipB.HoldsKey(myKey) Then
    
            If Me.Item(myKey) = ipB.Item(myKey) Then

                myResult.Add myKey, Me.Item(myKey)
                
            End If
    
        End If
        
    Next
    
    Set KVPairsInAandB = myResult
    
End Function


Public Function KeysNotInBothAandB(ByVal ipB As Variant) As Kvp

    Dim myResult As Kvp
    Set myResult = ipB.Clone
    
    Dim myKey As Variant
    For Each myKey In p.Keys
    
        If myResult.HoldsKey(myKey) Then
        
            myResult.Remove myKey
            
        Else
        
            myResult.Add myKey, Me.Item(myKey)
            
        End If
    
    Next
    
    Set KeysNotInBothAandB = myResult
    
End Function


Public Function LacksKey(ByVal ipKey As Variant) As Boolean
    LacksKey = Not HoldsKey(ipKey)
End Function


Public Function LacksItem(ByVal ipValue As Variant) As Boolean
    LacksItem = Not HoldsItem(ipValue)
End Function


Public Function LastIndex() As Long

    LastIndex = -1
    
    If p.Keys Is Nothing Then Exit Function
    
    LastIndex = p.Keys.LastIndex
    
End Function


'returns a Kvp with values as keys.  Each Value is linked
' to a Kvp of Index vs Key
Public Function MirrorByValue(Optional ByVal ipOrganiseby As KvpAdmin = KvpAdmin.SelectByIndex) As Kvp
    
    Dim myResult As Kvp
    Set myResult = Me.Deb
    
    Dim myKey  As Variant
    For Each myKey In p.Keys
    
        Dim myIndex As Variant
        myIndex = p.Keys.IndexOf(myKey)
        If myResult.LacksKey(p.Items.Item(myIndex)) Then
        
            myResult.Add p.Items.Item(myIndex), Me.Deb
            
        End If
        
        If ipOrganiseby = KvpAdmin.SelectByIndex Then
        
            myResult.Item(p.Items.Item(myIndex)).Add myIndex, myKey
            
        Else
        
            myResult.Item(p.Items.Item(myIndex)).Add myKey, myIndex
            
        End If
        
    Next
    
    Set MirrorByValue = myResult

End Function

'@Description("Returns a new Kvp where each value has been transformed by the IMap Object")
Public Function MapIt(ByVal ipMapper As IMapper) As Kvp
Attribute MapIt.VB_Description = "Returns a new Kvp where each value has been transformed by the IMap Object"

    Dim myKvp As Kvp
    Set myKvp = Kvp.Deb

    Dim myIndex As Long
    For myIndex = p.Keys.FirstIndex To p.Keys.LastIndex

        myKvp.Add p.Keys.Item(myIndex), ipMapper.ExecMapper(p.Items.Item(myIndex))

    Next

    Set MapIt = myKvp

End Function

'todo: need to add byindex of bykey
Public Function MirrorFirstValues(Optional ByVal ipOrganiseby As KvpAdmin = KvpAdmin.SelectByIndex) As Kvp

    Dim myFirstValues As Kvp
    Set myFirstValues = Me.Deb
    
    Dim myDupValues As Kvp
    Set myDupValues = Me.Deb

    Dim myIndex As Long
    For myIndex = p.Keys.FirstIndex To p.Keys.LastIndex
    
        If myFirstValues.LacksKey(p.Items.Item(myIndex)) Then
            
            If ipOrganiseby = KvpAdmin.SelectByIndex Then
                
                myFirstValues.Add p.Items.Item(myIndex), p.Keys.Item(myIndex)
                
                
            Else
                
                myFirstValues.Add p.Keys.Item(myIndex), p.Items.Item(myIndex)


            End If
        
        Else
        
            myDupValues.Add p.Items.Item(myIndex), p.Keys.Item(myIndex)

            
        End If
        
    Next
        
    Set MirrorFirstValues = Me.Deb.Add(Array(myFirstValues, myDupValues))
    
End Function

' '@Enumerator
' Friend Function NewEnum() As Variant
'     Attribute NewEnum.VB_UserMemId = -4
'     Dim KeysEnumerator As IUnknown
'     Set KeysEnumerator = p.Keys.Host.GetEnumerator(0, p.Keys.Count - 1)
    
'     Dim ItemsENumerator as IUNknown
'     Set ItemsEnumerator = p.Items.Host.GetEnumerator(0, p.Items.Count - 1)
    
'     Set NewEnum = cvar(kvpair.deb(cvar(KeysEnumerator),cvar(Itemsenumerator)))
    
' End Function

'@Enumerator
Friend Function NewEnum() As IUnknown
    Attribute NewEnum.VB_UserMemId = -4
    Dim enumerator As IUnknown
    '@Ignore DefaultMemberRequired
    Set enumerator = p.Keys.Host.GetEnumerator(0, p.Keys.Count)
    Set NewEnum = enumerator
    
End Function

Friend Function GetEnumerator() As Variant
    GetEnumerator = p.Keys.GetEnumerator
End Function

'Public Function MissingKeys(ByVal ipKeysIterable As Variant) As Kvp
'
'    Dim myKeysList As ArrayList
'    Set myKeysList = GetArrayAsList(ipKeysIterable)
'
'    Dim myMissingInHost As Kvp
'    Set myMissingInHost = Kvp.Deb
'
'    Dim myKey As Variant
'    For Each myKey In myKeysList
'
'        If Not p.Keys.ContainsKey(myKey) Then
'
'            myMissingInHost.Add myKey
'
'        End If
'
'    Next
'
'    Dim myMissingInArray As Kvp
'    Set myMissingInArray = Kvp.Deb
'
'    For Each myKey In p.Keys
'
'        If Not myKeysList.Contains(myKey) Then
'
'            myMissingInArray.Add myKey
'
'        End If
'    Next
'
'    Set MissingKeys = Kvp.Deb.Add(Array(myMissingInHost, myMissingInArray))
'
'End Function

'@Description("Returns the string 'Kvp'")
Public Property Get Name() As String
Attribute Name.VB_Description = "Returns the string 'Kvp'"
    Name = "Kvp"
End Property

'@Description("Returns a Kvp of maximum and minimum values.  Keys are the max and min value, associated with the keys is a Kvp of Index vs Key for each value corresponding to the parent key.")
Public Function NumMaxMin() As Kvp
Attribute NumMaxMin.VB_Description = "Returns a Kvp of maximum and minimum values.  Keys are the max and min value, associated with the keys is a Kvp of Index vs Key for each value corresponding to the parent key."
    
    Globals.Res.SetNotOkay
    Set NumMaxMin = Nothing
    If BailOut.When(Types.Group.IsNotNumber(p.Items.First), Msg.IsNotNumber) Then Exit Function
        
    Dim myValues As Lyst
    Set myValues = p.Items.Clone
    myValues.Sort
    
    Dim myMinItem As Variant
    myMinItem = myValues.First
    
    Dim mymaxitem As Variant
    mymaxitem = myValues.Last
    
    Dim myMinKvp As Kvp
    Set myMinKvp = Kvp.Deb
    
    Dim myMaxKvp As Kvp
    Set myMaxKvp = Kvp.Deb

    ' A maximum or minimum value may occur more than once
    ' so we populate the max and min kvp  with the key vs value
    ' of each found max or min value
    
    ' Dim myFirstIndex As Long
    ' myFirstIndex myValues
    
    ' Dim myUBound As Long
    ' myUBound = Me.LastIndex
    
    Dim myIndex As Variant
    For myIndex = p.Items.FirstIndex To p.Items.LastIndex

        If p.Items.Item(myIndex) = myMinItem Then
                
            myMinKvp.Add p.Keys.Item(myIndex), p.Items.Item(myIndex)


        ElseIf p.Items.Item(myIndex) = mymaxitem Then
        
            myMaxKvp.Add p.Keys.Item(myIndex), p.Items.Item(myIndex)


        End If
        
    Next

    Set NumMaxMin = Kvp.Deb.Add(myMinItem, myMinKvp).Add(mymaxitem, myMaxKvp)
    
End Function


Public Function Reverse() As Kvp
Attribute Reverse.VB_Description = "Sugar for InsertFirst"

    p.Keys.Reverse
    p.Items.Reverse
    
    Set Reverse = Me

End Function


Public Property Get Separator() As String
    Separator = p.Separator
End Property

Public Property Let Separator(ByVal ipSeparator As String)
    p.Separator = ipSeparator
End Property

Friend Sub SetAutoKey(Optional ByVal ipFirstKey As Variant)
    
    If BailOut.When(Types.IsNotNothing(p.AutoKey)) Then Exit Sub
        
    Select Case True
        
        Case VBA.IsMissing(ipFirstKey)
        
            SetKeysToNumber DefaultFirstNumberKey
            
        
        Case VBA.IsEmpty(ipFirstKey)

            SetKeysToNumber DefaultFirstNumberKey
                
        
        Case Types.Group.IsNumber(ipFirstKey)
        
            SetKeysToNumber ipFirstKey
            
        
        Case Types.IsString(ipFirstKey)
        
            SetKeysToString ipFirstKey
            
            
        Case Else
        
            Globals.Res.SetNotOkay
        
    End Select
    
    Globals.Res.SetOkay
    s.FirstUse = False
    
End Sub


Public Function SetKeysToNumber(Optional ByVal ipFirstKey As Variant = DefaultFirstNumberKey) As Kvp
    
    Set p.AutoKey = Nothing
    If BailOut.When(Types.Group.IsNotNumber(ipFirstKey)) Then Exit Function
        
    Set p.AutoKey = AutoKeyByNumber.Deb(ipFirstKey)
    s.FirstUse = True
    Set SetKeysToNumber = Me
    
End Function


Public Function SetKeysToString(Optional ByVal ipFirstUseKey As String = DefaultFirstStringKey, Optional ByVal ipAllowedKeyChars As String) As Kvp
  
    Set p.AutoKey = Nothing
    If BailOut.When(Types.IsNotString(ipFirstUseKey), Msg.IsNotString) Then Exit Function
    
    Set p.AutoKey = AutoKeyByString.Deb(ipFirstUseKey, ipAllowedKeyChars)
    If Globals.Res.IsNotOkay Then Exit Function
        
    s.FirstUse = True
    Set SetKeysToString = Me
    
End Function


Public Function SetKeysToIterable(ByVal ipKeysIterable As Variant, Optional ByVal ipFirstUseIndex As Variant) As Kvp
    
    Set p.AutoKey = Nothing
    If BailOut.When(Types.Group.IsNotIterable(ipKeysIterable), Msg.IsNotIterable) Then Exit Function
    
    Set p.AutoKey = AutoKeyByIndex.Deb(Types.Iterable.ToLyst(ipKeysIterable), ipFirstUseIndex)
    If Globals.Res.IsNotOkay Then Exit Function
        
    s.FirstUse = True
    Set SetKeysToIterable = Me
        
End Function


Public Function SumKeys() As LongLong

    If BailOut.When(Types.Group.IsNotNumber(p.Keys.First), Msg.IsNotNumber) Then Exit Function

    Dim mySum As LongLong
    Dim myKey As Variant
    For Each myKey In p.Keys
    
        mySum = mySum + myKey
        
    Next

    SumKeys = mySum
    
End Function


Public Function SumValues() As LongLong
    
    If BailOut.When(Types.Group.IsNotNumber(p.Items.First), Msg.IsNotNumber) Then Exit Function

    Dim mySum As LongLong
    Dim myValue As Variant
    For Each myValue In p.Items
    
        mySum = mySum + myValue
        
    Next

    SumValues = mySum
    
End Function


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' class private methods
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Add methods which specify a Key MUST ensure that they set the current key in the AutoKey
' to the last key specified after completing all adds to ensure continuity of keys
' from the last key used by the method

'Description("Adds.Inserts the forwarded ParamArray based on the ParamArray having 1,2, or more tthan 2 items. If Input action is 0 the paramarray is added otherwise inserted ))")
Friend Sub InputItems(ByVal ipInputType As KvpInput, ByVal ipFPA As Variant, Optional ipIndex As Long = KvpAdmin.noindex)
    'ipFPA  is Forwarded ParamArray
   
    If BailOut.When(p.Keys.HasItems And (VBA.Abs(ipIndex) > p.Keys.LastIndex + 1), Msg.IndexAfterLastIndex) Then Exit Sub
    If BailOut.When((ipIndex = 0) And (ipInputType = KvpInput.IsInsert), Msg.IndexBeforeFirstIndex) Then Exit Sub
        
    Select Case Arrays.Count(ipFPA)

        Case Is < 1
            Globals.Res.SetNotOkay
            
            
        Case 1
            InputWhenFPAHasOneItem ipInputType, ipFPA(0), ipIndex
            
            
        Case 2
            InputWhenFPAHasTwoItems ipInputType, ipFPA(0), ipFPA(1), ipIndex
            
            
        Case Is > 2
            IputWhenFPAIsListOfItems ipInputType, ipFPA, ipIndex

        
    End Select

End Sub

    
Friend Sub InputWhenFPAHasOneItem(ByVal ipInputAction As Long, ByVal ipItem As Variant, ByVal ipIndex As Long)
    
    If Parser.ParseVariantWithOneItem(ipItem).IsNotOkay Then Exit Sub
       
    Dim myParsed As ResultParsedVariant
    Set myParsed = Globals.Res.GetResultParsedVariant
    
    If s.FirstUse Then SetAutoKey
        
    Dim myKeys As Lyst
    Set myKeys = p.AutoKey.NextKeys(myParsed.GetItems.Count)
        
    If ipInputAction = KvpInput.IsAdd Then
    
        p.Keys.Host.AddRange myKeys.ToArrayList
        p.Items.Host.AddRange myParsed.GetItems.ToArrayList
        
    Else
        
        Dim mystartrun As ResultStartRun
        ' remember that ipindex may be negative
       If Ranges.TryStartRunFromAnyStartRunEnd(p.Keys, ipIndex).IsNotOkay Then Exit Sub
        
        '@Ignore DefaultMemberRequired
        Set mystartrun = Globals.Res.GetResultStartRun
        p.Keys.InsertRange mystartrun.StartIndex, myKeys
        p.Items.InsertRange mystartrun.StartIndex, myParsed.GetItems
        
    End If
        
End Sub

Friend Sub InputWhenFPAHasTwoItems(ByVal ipInputAction As KvpAdmin, ByVal ipfirst As Variant, ByVal ipsecond As Variant, ByVal ipIndex As Long)
    
    If Parser.ParseVariantWithTwoItems(ipfirst, ipsecond).IsNotOkay Then Exit Sub
        
    Dim myParsed As ResultParsedVariant
    Set myParsed = Globals.Res.GetResultParsedVariant
    
    If s.FirstUse Then SetAutoKey
    
    If ipInputAction = KvpInput.IsAdd Then
    
        p.Keys.AddRange myParsed.GetKeys
        p.Items.AddRange myParsed.GetItems
        
    Else
        
        Dim mystartrun As ResultStartRun
        ' remember that ipindex may be negative
        If Ranges.TryStartRunFromAnyStartRunEnd(p.Keys, ipIndex).IsNotOkay Then Exit Sub
        
        '@Ignore DefaultMemberRequired
        Set mystartrun = Globals.Res.GetResultStartRun
        p.Keys.InsertRange mystartrun.StartIndex, myParsed.GetKeys
        p.Items.InsertRange mystartrun.StartIndex, myParsed.GetItems
        
    End If
    
End Sub


Friend Sub IputWhenFPAIsListOfItems(ByVal ipInsertAt As Long, ByVal ipList As Variant, ByVal ipIndex As Long)
    
    Dim myCount As Long
    myCount = Arrays.Count(ipList)
    If BailOut.When(VBA.Abs(ipInsertAt) > myCount, Msg.IndexAfterLastIndex) Then Exit Sub
       
    If s.FirstUse Then SetAutoKey
        
    Dim myKeys As Lyst
    Set myKeys = p.AutoKey.NextKeys(myCount)
    
    If ipInsertAt = KvpInput.IsAdd Then
          
        p.Keys.AddRange myKeys
        p.Items.AddRange ipList
        
    Else
    
        If Ranges.TryStartRunFromAnyStartRunEnd(p.Keys, ipIndex).IsNotOkay Then Exit Sub
        Dim myIndex As Long
        myIndex = Globals.Res.Item(ResultItemsEnums.StartRun(srStartindex))
        
        p.Keys.InsertAt myIndex, myKeys
        p.Items.InsertAt myIndex, ipList
            
        
    End If
    
End Sub


Friend Sub AdjustAllItems(ByVal ipAdjustAmount As Variant)
Attribute AdjustAllItems.VB_Description = "Adds or Inserts the items and keys Lysts contained in Globals.Res"
    
    With p.Items
    
        Dim myIndex As Long
        For myIndex = 0 To LastIndex
            
            .Item(myIndex) = .Item(myIndex) + ipAdjustAmount
            
        Next
    
    End With
    
End Sub


Public Property Get AutoKey() As IAutoKey
    Set AutoKey = p.AutoKey
End Property


Friend Sub AdjustByIndex(ByVal ipIndexes As Variant, ByVal ipAmount As Single)
    
    If ipAmount = 0 Then Exit Sub
        
    If BailOut.When(Types.IsNotSameInstance(p.Keys, Nothing), Msg.NullReference) Then Exit Sub
    If BailOut.When(Types.Group.IsNotNumber(ipAmount), Msg.InvalidType) Then Exit Sub
    If BailOut.When(Types.Group.IsNotNumber(p.Items.First), Msg.InvalidType) Then Exit Sub
    
    If VBA.IsEmpty(ipIndexes) Then
        
        AdjustbyKey p.Keys, ipAmount
        Exit Sub
        
    End If
    
    Dim myIndexes As Lyst
    Set myIndexes = Types.Iterable.ToLyst(ipIndexes)
    Dim myIndex As Variant
    For Each myIndex In myIndexes

        ' Ignore any index outside current bounds
        If myIndex > -1 And myIndex < p.Keys.Count Then
            
            ' preserve the type in s.values
            ' we can use vartype as we are only operating on numbers
            Dim myType As VbVarType
            myType = VarType(p.Items.Item(myIndex))
            p.Items.Item(myIndex) = Types.ToVarTypePrimitive(myType, p.Items.Item(myIndex) + ipAmount)
            
        End If
        
    Next
    
            
End Sub


'@Description("Common code for IncByKey and DecByKey")
Friend Sub AdjustbyKey(ByVal ipKeys As Variant, ByVal ipAmount As Variant)
Attribute AdjustbyKey.VB_Description = "Common code for IncByKey and DecByKey"

    'If Guard.IsNothing(p.Keys, Msg.IterableHasNoItems).NotOkay Then Exit Sub
    If BailOut.When(Types.Iterable.HasNoItems(p.Keys), Msg.HasNoItems) Then Exit Sub
    If BailOut.When(Types.Group.IsNotNumber(ipAmount, p.Items.First), Msg.IsNotNumber) Then Exit Sub

    
    Dim myKeys As Variant
    If Arrays.IsNotValid(ipKeys) Then
        
        Set myKeys = p.Keys
        
        
    ElseIf Types.Group.IsIterable(ipKeys) Then
    
        Set myKeys = Lyst.Deb.AddKnownIterableAsItems(ipKeys)
        
        
    Else
    
        Set myKeys = Array(ipKeys)
        
        
    End If

    Dim myitem As Variant
    For Each myitem In myKeys

        ' We choose to ignore any key that is not in p.keys
        If p.Keys.HoldsItem(myitem) Then
            
            Dim myIndex As Long
            myIndex = p.Keys.IndexOf(myitem)
            
            ' The code below preserves the Type of the variable stored at ipIndex
            ' e.g. a Decimal Type is classed as a number But decimal +1 yeilds Double Type (or long Type)
            ' so we need jiggery pokery to make sure that the Type stored at ipIndex is not
            ' when incremented or decremented.
            Dim myType As VbVarType
            myType = VarType(p.Items.Item(myIndex))
            p.Items.Item(myIndex) = Types.ToVarTypePrimitive(myType, p.Items.Item(myIndex) + ipAmount)
            
            
        End If
        
    Next
        
End Sub


Private Sub DoNothing()

End Sub


' Friend Function GetAutoKeySequence(ByVal ipCount As Long) As Lyst
    
'     Dim myLyst As Lyst
'     Set myLyst = Lyst.Deb
    
'     Dim myCount As Long
'     For myCount = 1 To ipCount
    
'         myLyst.Add p.AutoKey.NextKey
        
'     Next
    
'     Set GetAutoKeySequence = myLyst
        
' End Function


' Private Function pvGetStringKeys() As ArrayList

'     Dim myKeys As ArrayList
'     Set myKeys = New ArrayList

'     Dim myitem As Variant
'     For Each myitem In p.Keys

'         myKeys.Add CStr(myitem)

'     Next

'     Set pvGetStringKeys = myKeys

' End Function


Public Sub InjectAutoKey(ByRef ipAutokey As IAutoKey)
    
   Set p.AutoKey = ipAutokey
   s.FirstUse = True
        
End Sub

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Types"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

''@IgnoreModule VariableNotUsed, AssignmentNotUsed
'@Folder("Lib")
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@PredeclaredId
'@Exposed
Option Explicit

        
'Private Type InternalConstants
'
'    Location                                    As String
'
'End Type
'
'Private i                                       As InternalConstants

Public Sub Class_Initialize()
        
    ' If VBA.Len(i.Location) = 0 Then
            
    '     i.Location = "VBALib.Types."
            
    ' End If
        
    'Guard InvalidNew, Me.IsNotSameInstance(Me, Types), i.Location & "Class_Initialize"
        
End Sub

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
'  Class Intellisense
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Public Property Get Group() As TypesGrouped
    Set Group = TypesGrouped
End Property

Public Property Get Name() As TypesNames
    Set Name = TypesNames
End Property

Public Property Get Iterable() As TypesIterables
    Set Iterable = TypesIterables
End Property

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
'  Class Intellisense forwarding
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@Description("Global.Res.Items is populated with the first index,lastindex and count if ipItem is an iterable")
Public Function TryExtent(ByVal ipItem As Variant, Optional ipRank As Long = 1&) As Result
    
    Set TryExtent = Globals.Res.SetNotOkay
        
    Select Case True
        
        ' string is not an iterable but it is allowed to get the 'extent' of the string
        Case Types.IsString(ipItem):
                
            Strs.TryExtent ipItem, ipRank
            
            
        Case Types.Group.IsNotIterable(ipItem)
        
            Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.IsNotIterable)
            
                
        Case VBA.IsArray(ipItem)
        
            Arrays.TryExtent ipItem, ipRank
                        
                        
        Case Types.Group.IsIterableObject(ipItem)
                
            Types.Iterable.TryExtent ipItem, ipRank
                        
                        
        Case Else
                
            Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.InvalidType)
            
                    
    End Select
    
    Set TryExtent = Globals.Res
    
End Function

Public Function HasItems(ParamArray ipArgArray() As Variant) As Boolean
    HasItems = HasItemsByFPA(CVar(ipArgArray))
End Function
 
 Public Function HasNoItems(ParamArray ipArgArray() As Variant) As Boolean
    HasNoItems = Not HasItemsByFPA(CVar(ipArgArray))
End Function

Friend Function HasItemsByFPA(ByVal ipArgArray As Variant) As Result
    
    Set HasItemsByFPA = Globals.Res
    If BailOut.When(Arrays.HasNoItems(ipArgArray), Msg.ArrayHasNoItems) Then Exit Function
    
    Dim myargs As Variant
    If Arrays.IsNotValid(ipArgArray) Then
        
        If Parser.ParseVariantWithOneItem(ipArgArray).IsNotOkay Then Exit Function
        Set myargs = Globals.Res.Item(ResultItemsEnums.ParsedVariant(pvItems))
        
        
    Else
        
        myargs = ipArgArray
        
    End If
    
    Dim myitem As Variant
    For Each myitem In myargs
        
        If BailOut.When(Types.Group.IsNotIterable(myitem), Msg.IsNotIterable) Then Exit Function
        If BailOut.When(Types.Iterable.HasNoItems(myitem), Msg.HasNoItems) Then Exit Function
        
    Next
    
    Set HasItemsByFPA = Globals.Res.Init(Msg.Okay)
        
End Function

'@Description("Returns true if the list of parameters are all arrays))
Public Function IsArray(ParamArray ipArgArray() As Variant) As Boolean
    IsArray = IsArrayByFPA(CVar(ipArgArray))
End Function

'@Description("Returns True if none of the list of parameters is an array)")
Public Function IsNotArray(ParamArray ipArgArray() As Variant) As Boolean
Attribute IsNotArray.VB_Description = "Returns True if none of the list of parameters is an array)"
    IsNotArray = Not IsArrayByFPA(CVar(ipArgArray))
End Function

Friend Function IsArrayByFPA(ByVal ipArgArray As Variant) As Boolean
        
    IsArrayByFPA = False
    If BailOut.When(Arrays.IsNotValid(ipArgArray), Msg.ParamArrayIsNotValid) Then Exit Function
        
    Dim myArg As Variant
    For Each myArg In ipArgArray
        
        If Not VBA.IsArray(myArg) Then Exit Function
        'If UBound(myArg) < LBound(myArg) Then Exit Function
            
    Next
    
    Globals.Res.Init (Msg.Okay)
    IsArrayByFPA = True
        
End Function

'@Description("Returns True if an object has a 'Count' method")
Public Function HasCountMethod(ByVal ipItem As Variant) As Boolean
Attribute HasCountMethod.VB_Description = "Returns True if an object has a 'Count' method"
        
    '@Ignore VariableNotUsed
    Dim myCount As Long
    Dim myError As Long
    On Error Resume Next
    '@Ignore AssignmentNotUsed
    myCount = ipItem.Count
    myError = Err.Number
    Err.Clear
    On Error GoTo 0

    HasCountMethod = myError = 0
        
End Function

'@Description("Returns True if an object does not have a count method")
Public Function LacksCountMethod(ByVal ipItem As Variant) As Boolean
Attribute LacksCountMethod.VB_Description = "Returns True if an object does not have a count method"
    LacksCountMethod = Not HasCountMethod(ipItem)
End Function

Public Function HasCloneMethod(ByVal ipTestItem As Variant) As Boolean
        
    Dim myError As Long
    '@Ignore VariableNotUsed
    Dim myObj As Object
    On Error Resume Next
    '@Ignore AssignmentNotUsed
    Set myObj = ipTestItem.Clone
    myError = Err.Number
    Err.Clear
    On Error GoTo 0
            
    HasCloneMethod = myError = 0
        
End Function

Public Function LacksCloneMethod(ByVal ipTestItem As Variant) As Boolean
    LacksCloneMethod = Not HasCloneMethod(ipTestItem)
End Function

'@Description("Returns True if an object has an Item Method")
Public Function HasItemMethod(ByVal ipItem As Variant) As Result
Attribute HasItemMethod.VB_Description = "Returns True if an object has an Item Method"
        
    ' A reasonable assumption is that an object with an item method also has a count method
        
    Dim myResult As Result
    Set myResult = Result.Deb
    Set HasItemMethod = myResult
    If Not VBA.IsObject(ipItem) Then
        
        myResult.MsgEnum = InvalidType
        Exit Function
            
    End If
        
    If LacksCountMethod(ipItem) Then
        
        ' myresult.reson GuardClause
        Exit Function
        
    End If
    ' Can't get an item if it dowsn't exist
    If ipItem.Count = 0 Then Exit Function
            
            
        
    ' Using Array is the simplest way of recieving an object without an isobject test.
    ' The assignment below is to get the error number only and tests if the item method exists
    '@Ignore VariableNotUsed
    Dim myitem As Variant
    '@Ignore AssignmentNotUsed
    myitem = Array(ipItem.Item(ipItem.Count - 1))
    Dim myErrNo As Long
    myErrNo = Err.Number
        
    On Error GoTo 0

    HasItemMethod = myErrNo = 0
        
End Function

'@Description("Returns True if the object does not have an Item method)")
Public Function LacksItemMethod(ByVal ipItem As Variant) As Boolean
Attribute LacksItemMethod.VB_Description = "Returns True if the object does not have an Item method)"
    LacksItemMethod = Not HasItemMethod(ipItem)
End Function

'@Description("Returns True if any parameter is empty or is ismissing")
Public Function IsMissing(ParamArray ipArgArray() As Variant) As Boolean
Attribute IsMissing.VB_Description = "Returns True if any parameter is empty or is ismissing"
    IsMissing = pvIsMissingByFPA(CVar(ipArgArray))
End Function

'@Description"Returns True if all parameters are not empty and are not missing")
Public Function IsNotMissing(ParamArray ipArgArray() As Variant) As Boolean
    IsNotMissing = Not pvIsMissingByFPA(ipArgArray)
End Function

Public Function pvIsMissingByFPA(ByVal ipArgArray As Variant) As Boolean

    pvIsMissingByFPA = True
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipArgArray) Then Exit Function
    If Arrays.IsNotValid(ipArgArray) Then Exit Function
        
    Dim myArg As Variant
    For Each myArg In ipArgArray
        
        '@Ignore IsMissingWithNonArgumentParameter
        If VBA.IsMissing(myArg) Then Exit Function
            
    Next
        
    pvIsMissingByFPA = False
        
End Function

Public Function IsEmpty(ParamArray ipArgArray() As Variant) As Boolean
    IsEmpty = pvIsEmptyByFPA(CVar(ipArgArray))
End Function

Public Function IsNotEmpty(ParamArray ipArgArray() As Variant) As Boolean
    IsNotEmpty = Not pvIsEmptyByFPA(CVar(ipArgArray))
End Function

Public Function pvIsEmptyByFPA(ByRef ipArgArray As Variant) As Boolean

    pvIsEmptyByFPA = False
    If VBA.IsEmpty(ipArgArray) Then Exit Function
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipArgArray) Then Exit Function
                
    Dim myArg As Variant
    For Each myArg In ipArgArray
        
        If Me.Group.IsIterable(myArg) Then
            
            If Me.Iterable.HasItems(myArg) Then Exit Function
                
        Else
            
            If Not VBA.IsEmpty(myArg) Then Exit Function
            
        End If
        
    Next
        
    pvIsEmptyByFPA = True
        
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' Tests using groups of types
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Public Function IsSameType(ByVal ipRequiredType As Variant, ParamArray ipArgArray() As Variant) As Boolean
    IsSameType = pvIsSameTypeByFPA(ipRequiredType, ipArgArray)
End Function

Public Function IsNotSameType(ByVal ipRequiredType As Variant, ParamArray ipArgArray() As Variant) As Boolean
    IsNotSameType = Not pvIsSameTypeByFPA(ipRequiredType, ipArgArray)
End Function

Public Function pvIsSameTypeByFPA(ByVal ipRequiredType As Variant, ByVal ipArgArray As Variant) As Boolean

    pvIsSameTypeByFPA = False
    If Arrays.HasNoItems(ipArgArray) Then Exit Function
                
    Dim myRequiredType As String
    myRequiredType = TypeName(ipRequiredType)
    Dim myitem As Variant
    For Each myitem In ipArgArray
        ' cannot use vartype as this cannot distinguish object types
            
        If InStr(myRequiredType, TypeName(myitem)) = 0 Then Exit Function
            
    Next
        
    pvIsSameTypeByFPA = True
        
End Function

Public Function IsObject(ParamArray ipArgArray() As Variant) As Boolean
    IsObject = pvIsObjectByFPA(CVar(ipArgArray))
End Function

Public Function IsNotObject(ParamArray ipArgArray() As Variant) As Boolean
    IsNotObject = Not pvIsObjectByFPA(CVar(ipArgArray))
End Function

Public Function pvIsObjectByFPA(ByVal ipArgArray As Variant) As Boolean
        
    pvIsObjectByFPA = False
    If VBA.IsEmpty(ipArgArray) Then Exit Function
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipArgArray) Then Exit Function
                
    Dim myArg As Variant
    For Each myArg In ipArgArray
        
        If Not VBA.IsObject(myArg) Then Exit Function
            
    Next
        
    pvIsObjectByFPA = True
        
End Function

Public Function IsObjectArray(ParamArray ipArgArray() As Variant) As Boolean
    IsObjectArray = pvIsObjectArrayByFPA(CVar(ipArgArray))
End Function

Public Function IsNotObjectArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotObjectArray = Not pvIsObjectArrayByFPA(CVar(ipArgArray))
End Function

Public Function pvIsObjectArrayByFPA(ByVal ipArgArray As Variant) As Boolean
        
    pvIsObjectArrayByFPA = False
    If VBA.IsEmpty(ipArgArray) Then Exit Function
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipArgArray) Then Exit Function
                
    Dim myArg As Variant
    For Each myArg In ipArgArray
            
        If InStr(Me.Name.AsArray.OfObject, TypeName(myArg)) = 0 Then Exit Function
                
    Next
        
    pvIsObjectArrayByFPA = True
        
End Function

'Public Function HasDefaultItemMethod(ByVal ipobject As Variant) As Boolean
'
'    Dim myTLI As TLI.TLIApplication
'    Set myTLI = New TLI.TLIApplication
'
'    Dim myInterface As TLI.TypeInfo
'    Set myInterface = myTLI.InterfaceInfoFromObject(ipobject)
'
''    Dim myMemberInfo as
''    HasDefaultItemMethod = False
''    If Types.IsNotObject(ipobject) Then
'End Function
        


'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
'  Tests for specific types.
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@Description("Returns true if the types of all the values in the parameter list are found in the Types string")
Public Function IsTypeByName(ByVal ipTypesasStringOrIterable As Variant, ParamArray ipArgArray() As Variant) As Boolean
Attribute IsTypeByName.VB_Description = "Returns true if the types of all the values in the parameter list are found in the Types string"
    IsTypeByName = pvIsTypeByNameByFPA(ipTypesasStringOrIterable, ipArgArray)
End Function

Public Function IsNotTypeByName(ByVal ipTypesasStringOrIterable As Variant, ParamArray ipArgArray() As Variant) As Boolean
    IsNotTypeByName = Not IsTypeByName(ipTypesasStringOrIterable, ipArgArray)
End Function

Private Function IsTypeByNameByFPA(ByVal ipTypes As String, ParamArray ipArgArray() As Variant) As Boolean
    IsTypeByNameByFPA = Not pvIsTypeByNameByFPA(ipTypes, ipArgArray)
End Function

Public Function pvIsTypeByNameByFPA(ByVal ipTypesasStringOrIterable As Variant, ByVal ipArgArray As Variant) As Boolean
        
    pvIsTypeByNameByFPA = False
    If BailOut.When(Arrays.IsNotValid(ipArgArray), Msg.ParamArrayIsNotValid) Then Exit Function
        
    Dim myIterable As Variant
    If VBA.VarType(ipTypesasStringOrIterable) = vbString Then
        
        Set myIterable = Types.Iterable.ToArrayList(VBA.Split(ipTypesasStringOrIterable, Char.twComma))
            
    Else

        Set myIterable = Types.Iterable.ToArrayList(ipTypesasStringOrIterable)
    
    End If
    
    Dim myitem As Variant
    For Each myitem In ipArgArray
        'Debug.Print TypeName(myitem)
        If Not myIterable.Contains(TypeName(myitem)) Then Exit Function
        
    Next
        
    pvIsTypeByNameByFPA = True
        
End Function

'@Description("Returns true is all the values in the Parameter array have the VarType ipVarType, Cannot differentiate between objects")
Public Function IsVarType(ByVal ipVarType As VbVarType, ParamArray ipArgArray() As Variant) As Boolean
Attribute IsVarType.VB_Description = "Returns true is all the values in the Parameter array have the VarType ipVarType, Cannot differentiate between objects"
    IsVarType = pvIsVarTypeByFPA(ipVarType, ipArgArray)
End Function

Public Function IsNotVarType(ByVal ipVarType As VbVarType, ParamArray ipArgArray() As Variant) As Boolean
    IsNotVarType = Not pvIsVarTypeByFPA(ipVarType, ipArgArray)
End Function

Public Function pvIsVarTypeByFPA(ByVal ipVarType As VbVarType, ByVal ipArgArray As Variant) As Boolean

    'ipArgArray is derived from CVar(ParamArray) and consequently will always be an array
    pvIsVarTypeByFPA = False
    If VBA.IsEmpty(ipArgArray) Then Exit Function
    '@Ignore IsMissingOnInappropriateArgument
    If VBA.IsMissing(ipArgArray) Then Exit Function
                
    Dim myitem As Variant
    For Each myitem In ipArgArray
        
        If Not VBA.VarType(myitem) = ipVarType Then Exit Function
            
    Next
        
    pvIsVarTypeByFPA = True

End Function

Public Function IsBoolean(ParamArray ipArgArray() As Variant) As Boolean
    IsBoolean = pvIsTypeByNameByFPA(Me.Name.OfBoolean, ipArgArray)
End Function

Public Function IsNotBoolean(ParamArray ipArgArray() As Variant) As Boolean
    IsNotBoolean = Not pvIsTypeByNameByFPA(Me.Name.OfBoolean, ipArgArray)
End Function

Public Function IsBooleanArray(ParamArray ipArgArray() As Variant) As Boolean
    IsBooleanArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfBoolean, ipArgArray)
End Function

Public Function IsNotBooleanArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotBooleanArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfBoolean, ipArgArray)
End Function

Public Function IsByte(ParamArray ipArgArray() As Variant) As Boolean
    IsByte = pvIsTypeByNameByFPA(Me.Name.OfByte, ipArgArray)
End Function

Public Function IsNotByte(ParamArray ipArgArray() As Variant) As Boolean
    IsNotByte = Not pvIsTypeByNameByFPA(Me.Name.OfByte, ipArgArray)
End Function

Public Function IsByteArray(ParamArray ipArgArray() As Variant) As Boolean
    IsByteArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfByte, ipArgArray)
End Function

Public Function IsNotByteArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotByteArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfByte, ipArgArray)
End Function

Public Function IsCurrency(ParamArray ipArgArray() As Variant) As Boolean
    IsCurrency = pvIsTypeByNameByFPA(Me.Name.OfCurrency, ipArgArray)
End Function

Public Function IsNotCurrency(ParamArray ipArgArray() As Variant) As Boolean
    IsNotCurrency = Not pvIsTypeByNameByFPA(Me.Name.OfCurrency, ipArgArray)
End Function

Public Function IsCurrencyArray(ParamArray ipArgArray() As Variant) As Boolean
    IsCurrencyArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfCurrency, ipArgArray)
End Function

Public Function IsNotCurrencyArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotCurrencyArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfCurrency, ipArgArray)
End Function

'Public Function IsDataObject(ParamArray ipArgArray() As Variant) As Boolean
'    IsDataObject = pvIsTypeByNameByFPA(Types.Name.OfCurrency, ipArgArray)
'End Function
'
'Public Function IsNotDataObject(ParamArray ipArgArray() As Variant) As Boolean
'    IsNotDataObject = Not IsVarTypeByFPA(CVar(ipArgArray), vbDataObject)
'End Function
'
'Public Function IsDataObjectArray(ParamArray ipArgArray() As Variant) As Boolean
'    IsDataObjectArray = IsVarTypeByFPA(CVar(ipArgArray), vbDataObject + vbArray)
'End Function
'
'Public Function IsNotDataObjectArray(ParamArray ipArgArray() As Variant) As Boolean
'    IsNotDataObjectArray = Not IsVarTypeByFPA(CVar(ipArgArray), vbDataObject + vbArray)
'End Function



Public Function IsDate(ParamArray ipArgArray() As Variant) As Boolean
    IsDate = pvIsTypeByNameByFPA(Me.Name.OfDate, ipArgArray)
End Function

Public Function IsNotDate(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDate = Not pvIsTypeByNameByFPA(Me.Name.OfDate, ipArgArray)
End Function

Public Function IsDateArray(ParamArray ipArgArray() As Variant) As Boolean
    IsDateArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfDate, ipArgArray)
End Function

Public Function IsNotDateArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDateArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfDate, ipArgArray)
End Function

Public Function IsDecimal(ParamArray ipArgArray() As Variant) As Boolean
    IsDecimal = pvIsTypeByNameByFPA(Me.Name.OfDecimal, ipArgArray)
End Function

Public Function IsNotDecimal(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDecimal = Not pvIsTypeByNameByFPA(Me.Name.OfDecimal, ipArgArray)
End Function

Public Function IsDecimalArray(ParamArray ipArgArray() As Variant) As Boolean
    IsDecimalArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfDecimal, ipArgArray)
End Function

Public Function IsNotDecimalArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDecimalArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfDecimal, ipArgArray)
End Function

Public Function IsDouble(ParamArray ipArgArray() As Variant) As Boolean
    IsDouble = pvIsTypeByNameByFPA(Me.Name.OfDouble, ipArgArray)
End Function

Public Function IsNotDouble(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDouble = Not pvIsTypeByNameByFPA(Me.Name.OfDouble, ipArgArray)
End Function

Public Function IsDoubleArray(ParamArray ipArgArray() As Variant) As Boolean
    IsDoubleArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfDouble, ipArgArray)
End Function

Public Function IsNotDoubleArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotDoubleArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfDouble, ipArgArray)
End Function

Public Function IsError(ParamArray ipArgArray() As Variant) As Boolean
    IsError = pvIsTypeByNameByFPA(Me.Name.OfError, ipArgArray)
End Function

Public Function IsNotError(ParamArray ipArgArray() As Variant) As Boolean
    IsNotError = Not pvIsTypeByNameByFPA(Me.Name.OfError, ipArgArray)
End Function

Public Function IsErrorArray(ParamArray ipArgArray() As Variant) As Boolean
    IsErrorArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfError, ipArgArray)
End Function

Public Function IsNotErrorArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotErrorArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfError, ipArgArray)
End Function

Public Function IsNothing(ParamArray ipArgArray() As Variant) As Boolean
    IsNothing = pvIsTypeByNameByFPA(Me.Name.OfNothing, ipArgArray)
End Function

Public Function IsNotNothing(ParamArray ipArgArray() As Variant) As Boolean
    IsNotNothing = Not pvIsTypeByNameByFPA(Me.Name.OfNothing, ipArgArray)
End Function

Public Function IsNothingArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNothingArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfNothing, ipArgArray)
End Function

Public Function IsNotNothingArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotNothingArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfNothing, ipArgArray)
End Function

Public Function IsNull(ParamArray ipArgArray() As Variant) As Boolean
    IsNull = pvIsTypeByNameByFPA(Me.Name.OfNull, ipArgArray)
End Function

Public Function IsNotNull(ParamArray ipArgArray() As Variant) As Boolean
    IsNotNull = Not pvIsTypeByNameByFPA(Me.Name.OfNull, ipArgArray)
End Function

Public Function IsNullArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNullArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfNull, ipArgArray)
End Function

Public Function IsNotNullArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotNullArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfNull, ipArgArray)
End Function

Public Function IsInteger(ParamArray ipArgArray() As Variant) As Boolean
    IsInteger = pvIsTypeByNameByFPA(Me.Name.OfInteger, ipArgArray)
End Function

Public Function IsNotInteger(ParamArray ipArgArray() As Variant) As Boolean
    IsNotInteger = Not pvIsTypeByNameByFPA(Me.Name.OfInteger, ipArgArray)
End Function

Public Function IsIntegerArray(ParamArray ipArgArray() As Variant) As Boolean
    IsIntegerArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfInteger, ipArgArray)
End Function

Public Function IsNotIntegerArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotIntegerArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfInteger, ipArgArray)
End Function

Public Function IsLong(ParamArray ipArgArray() As Variant) As Boolean
    IsLong = pvIsTypeByNameByFPA(Me.Name.OfLong, ipArgArray)
End Function

Public Function IsNotLong(ParamArray ipArgArray() As Variant) As Boolean
    IsNotLong = Not pvIsTypeByNameByFPA(Me.Name.OfLong, ipArgArray)
End Function

Public Function IsLongArray(ParamArray ipArgArray() As Variant) As Boolean
    IsLongArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfLong, ipArgArray)
End Function

Public Function IsNotLongArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotLongArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfLong, ipArgArray)
End Function

Public Function IsLongLong(ParamArray ipArgArray() As Variant) As Boolean
    IsLongLong = pvIsTypeByNameByFPA(Me.Name.OfLongLong, ipArgArray)
End Function

Public Function IsNotLongLong(ParamArray ipArgArray() As Variant) As Boolean
    IsNotLongLong = Not pvIsTypeByNameByFPA(Me.Name.OfLongLong, ipArgArray)
End Function

Public Function IsLongLongArray(ParamArray ipArgArray() As Variant) As Boolean
    IsLongLongArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfLongLong, ipArgArray)
End Function

Public Function IsNotLongLongArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotLongLongArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfLongLong, ipArgArray)
End Function

'@Description(" True if the object type is object.  Which is different to asking if a variable is an object")
Public Function IsObjectObject(ParamArray ipArgArray() As Variant) As Boolean
Attribute IsObjectObject.VB_Description = " True if the object type is object.  Which is different to asking if a variable is an object"
    IsObjectObject = pvIsTypeByNameByFPA(Me.Name.OfObject, ipArgArray)
End Function

Public Function IsNotObjectObject(ParamArray ipArgArray() As Variant) As Boolean
    IsNotObjectObject = Not pvIsTypeByNameByFPA(Me.Name.OfObject, ipArgArray)
End Function

Public Function IsObjectObjectArray(ParamArray ipArgArray() As Variant) As Boolean
    IsObjectObjectArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfObject, ipArgArray)
End Function

Public Function IsNotArrayOfObjectObjects(ParamArray ipArgArray() As Variant) As Boolean
    IsNotArrayOfObjectObjects = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfObject, ipArgArray)
End Function

Public Function IsSingle(ParamArray ipArgArray() As Variant) As Boolean
    IsSingle = pvIsTypeByNameByFPA(Me.Name.OfSingle, ipArgArray)
End Function

Public Function IsNotSingle(ParamArray ipArgArray() As Variant) As Boolean
    IsNotSingle = Not pvIsTypeByNameByFPA(Me.Name.OfSingle, ipArgArray)
End Function

Public Function IsSingleArray(ParamArray ipArgArray() As Variant) As Boolean
    IsSingleArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfSingle, ipArgArray)
End Function

Public Function IsNotSingleArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotSingleArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfSingle, ipArgArray)
End Function

Public Function IsString(ParamArray ipArgArray() As Variant) As Boolean
    IsString = pvIsTypeByNameByFPA(Me.Name.OfString, ipArgArray)
End Function

Public Function IsNotString(ParamArray ipArgArray() As Variant) As Boolean
    IsNotString = Not pvIsTypeByNameByFPA(Me.Name.OfString, ipArgArray)
End Function

Public Function IsStringArray(ParamArray ipArgArray() As Variant) As Boolean
    IsStringArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfString, ipArgArray)
End Function

Public Function IsNotStringArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotStringArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfString, ipArgArray)
End Function

Public Function IsUnknown(ParamArray ipArgArray() As Variant) As Boolean
    IsUnknown = pvIsTypeByNameByFPA(Me.Name.OfUnknown, ipArgArray)
End Function

Public Function IsNotUnknown(ParamArray ipArgArray() As Variant) As Boolean
    IsNotUnknown = Not pvIsTypeByNameByFPA(Me.Name.OfUnknown, ipArgArray)
End Function

Public Function IsUnknownArray(ParamArray ipArgArray() As Variant) As Boolean
    IsUnknownArray = pvIsTypeByNameByFPA(Me.Name.AsArray.OfUnknown, ipArgArray)
End Function

Public Function IsNotUnknownArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotUnknownArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.OfUnknown, ipArgArray)
End Function

' Its not possible to test for a variable being a variant in vba
Public Function IsVariantArray(ParamArray ipArgArray() As Variant) As Boolean
    IsVariantArray = pvIsTypeByNameByFPA(Me.Name.AsArray.ofVariant, ipArgArray)
End Function

Public Function IsNotVariantArray(ParamArray ipArgArray() As Variant) As Boolean
    IsNotVariantArray = Not pvIsTypeByNameByFPA(Me.Name.AsArray.ofVariant, ipArgArray)
End Function

Public Function IsKVPair(ParamArray ipArgArray() As Variant) As Boolean
    IsKVPair = pvIsTypeByNameByFPA(Me.Name.OfKVPair, ipArgArray)
End Function

Public Function IsNotKVPair(ParamArray ipArgArray() As Variant) As Boolean
    IsNotKVPair = Not pvIsTypeByNameByFPA(Me.Name.OfKVPair, ipArgArray)
End Function

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
'  Miscellaneous
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
Public Function ToVarTypePrimitive(ByVal ipType As VbVarType, ByVal ipValue As Variant) As Variant

    Globals.Res.Init (Msg.Okay)
    If BailOut.When(Types.Group.IsNotPrimitive(ipValue), Msg.InvalidType) Then Exit Function ' ToDo: Msg.IsNotPrimitive
            
    Dim myResult As Variant
    'With Types.Name
        
    Select Case ipType
            
        Case vbBoolean
                    
            myResult = VBA.CBool(ipValue)
                        
        Case vbByte
                    
            myResult = VBA.CByte(ipValue)
                    
        Case vbCurrency
                    
            myResult = VBA.CCur(ipValue)
                    
        Case vbDate
                    
            myResult = VBA.CDate(ipValue)
                        
        Case vbDouble
                    
            myResult = VBA.CDbl(ipValue)
                
        Case vbDecimal
                    
            myResult = VBA.CDec(ipValue)
                    
        Case vbInteger
                    
            myResult = VBA.CInt(ipValue)
                    
        Case vbLong
                    
            myResult = VBA.CLng(ipValue)
                    
        Case vbLongLong
                    
            myResult = VBA.CLngLng(ipValue)
                                
        Case vbSingle
                    
            myResult = VBA.CSng(ipValue)
                        
        Case vbString
                    
            myResult = VBA.CStr(ipValue)
                    
    End Select
            
    ' End With
      
    Globals.Res.Init(Msg.Okay).SetItems (myResult)
    ToVarTypePrimitive = myResult
        
End Function

Public Function GetDefaultValue(ByVal ipItem As Variant) As Variant
            
        
    Select Case True
            
    Case Me.Group.IsPrimitive(ipItem)
            
        If Me.IsString(ipItem) Then
                    
            GetDefaultValue = vbNullString
                        
        ElseIf Me.IsBoolean(ipItem) Then
                    
            GetDefaultValue = False
                        
        Else
                
            GetDefaultValue = vbNullString
                
        End If
                
    Case VBA.IsObject(ipItem)
                
        Set GetDefaultValue = Nothing
                
    Case VBA.IsEmpty(ipItem)
            
        GetDefaultValue = Empty
                
                
    Case Me.IsTypeByName(Me.Name.AsArray.ofVariant, ipItem)
            
        GetDefaultValue = Empty
                
                
    Case IsNull(ipItem)
            
        GetDefaultValue = Null
            
    End Select
        
End Function

Public Function IsSameInstance(ByVal ipInstance As Object, ByVal ipReference As Object) As Boolean
    IsSameInstance = ipInstance Is ipReference
        
End Function

Public Function IsNotSameInstance(ByVal ipInstance As Object, ByVal ipReference As Object) As Boolean
    IsNotSameInstance = Not IsSameInstance(ipInstance, ipReference)
End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Parser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "Parses a ParamArray (or a variant containing an array). Typically used for inputs to the Lyst and Kvp objects"
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib.Helpers")
'@ModuleDescription("Parses a ParamArray (or a variant containing an array). Typically used for inputs to the Lyst and Kvp objects")

Private Enum FPAItems

  ParamOne = 0
  ParamTwo = 1
  
End Enum

' ' Non magic numbers for the 0 and 1 items of the forwarded ParamArray
' Const parseAdmin.ParamOne As Long = 0
' Const parseAdmin.ParamTwo As Long = 1


'Friend Function Parse(ByVal ipVariant As Variant) As Result
'
'    Select Case Types.Iterable.Count(ipFPA)
'
'        Case Is < 1: Globals.Res.SetNotOkay
'        Case 1: InputWhenFPAHasOneItem ipInputType, ipFPA(0), ipIndex
'        Case 2: InputWhenFPAHasTwoItems ipInputType, ipFPA(0), ipFPA(1), ipIndex
'        Case Is > 2: IputWhenFPAIsListOfItems ipInputType, ipFPA, ipIndex
'
'    End Select
'
'    Set Parse = Globals.Res
'
'End Function
'@Descscription("Interprets the single Item in the ParamArray. The generated iterables are accessed through the Item Method of ParseResult.)
Friend Function ParseVariantWithOneItem(ByVal ipItem As Variant) As Result
    
    Select Case True
    
        'special actions are required in the case of a dictionary or a TableArray
        
        Case Arrays.IsTableArray(ipItem)
            'process a 2d array into a lyst of lysts
            Globals.Res.SetOkay.SetItems Arrays.ToLystOfRanksAsLyst(ipItem, RankIsRowFirstItemActionIsNoAction)
            
        
        Case Types.Group.IsIterableKeysByEnum(ipItem)
              
            '@Ignore ValueRequired
            Globals.Res.SetOkay.SetItems ipItem.Items, ipItem.Keys
            
            
        Case Else
        
            Globals.Res.SetOkay.SetItems ipItem
            
                        
    End Select
    
    Set ParseVariantWithOneItem = Globals.Res
    
End Function


'@Description("Parsing of paramarray variant with two items to get keys and items lysts")
Friend Function ParseVariantWithTwoItems(ByVal ipfirst As Variant, ByVal ipsecond As Variant) As Result
Attribute ParseVariantWithTwoItems.VB_Description = "Parsing of paramarray variant with two items to get keys and items lysts"
        
    Globals.Res.SetNotOkay
    
    'Determine the type of first item
    Select Case True
            
        Case Types.Group.IsAdmin(ipfirst)
            'Admin items are not allowed to be Keys-
            Globals.Res.SetNotOkay (Msg.InvalidKey)
            
                        
        Case Types.Group.IsNotIterable(ipfirst) 'Imlemented
            ' a key, value pair
            Globals.Res.SetOkay.SetItems Array(ipsecond), Array(ipfirst)
                 
            
        Case Arrays.IsMDArray(ipfirst)
            ' There is no special action for an array with 3 or more dimensions
            ' as a Key so return an error
            Globals.Res.SetNotOkay (Msg.InvalidKey)
                    
                    
        Case Arrays.IsTableArray(ipfirst)
                    
            SetGlobalsResWhenFirstParamIsTableArray ipfirst, ipsecond
                    
                
        Case Types.Group.IsIterableItemsByEnum(ipfirst)
                
            SetGlobalsResWhenFirstParamIsIterableItemsByEnum ipfirst, ipsecond
                    
                    
        Case Types.Group.IsIterableKeysByEnum(ipfirst)
                
            SetGlobalsResWhenFirstParamIsIterableKeysByENum ipfirst, ipsecond
            
                
        Case Else
            
            Globals.Res.SetNotOkay (Msg.UnexpectedItemInParamArray)
                
            
    End Select
    
    Set ParseVariantWithTwoItems = Globals.Res
    
End Function


Friend Sub SetGlobalsResWhenFirstParamIsTableArray(ByVal ipfirst As Variant, ByVal ipsecond As Variant)
       
    Select Case True
        
        Case Types.Group.IsNotIterable(ipsecond)
            
            If BailOut.When(enums.TableToLystActions.LacksMember(ipsecond), Msg.KvpSecondParamterIsNotValid) Then Exit Sub
                           
            ' ipSecond is a TableToLystActions enumeration member that says how to process the table
          
            Dim myLyst As Lyst
            Set myLyst = enums.TableToLystActions.Action(ipsecond).ExecAction(ipfirst)
            
            'Keys and items are opposite way around to how they need to be in Gobals.Res
            ' remember also that res.items is an arraylist (0 based indexing) and that Lyst has 1 based indexing
            Globals.Res.SetOkay.SetItems myLyst.Item(2), myLyst.Item(1)
          
        Case Arrays.IsMDArray(ipsecond)
                
            Globals.Res.SetNotOkay (enums.Message.AsEnum(Msg.KvpSecondParamterIsNotValid))
                    
                    
        Case Arrays.IsTableArray(ipsecond)
            'Two tables so merge first column of ipfirst with rows of ipSecond
            ' remembering that in GlobalsRes.ResultItems, item(1) is the Items of the Kvp
            ' execaction returns a lyst of lysts where for a split or copy, item(2) is the split or copy values lyst
            ' and item(1) is the remainder of the rows.
            Globals.Res.SetOkay.SetItems _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsNoAction).ExecAction(ipsecond).Item(AfterTableAction.ActionIsNoActionRows), _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsSplit).ExecAction(ipfirst).Item(AfterTableAction.ActionIsSplitKeys)

                    
                    
        Case Types.Group.IterableKeysByEnum(ipsecond)
            ' table vs dictionary, first column of table to dictionary items
            Globals.Res.SetOkay.SetItems _
                ipsecond.Items, _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsSplit).ExecAction(ipfirst).Item(ActionIsSplitKeys)
                
                
        Case Types.Group.IsIterableItemsByEnum(ipsecond)
            'table to iterable, first column of table to iterable
            Globals.Res.SetOkay.SetItems _
                ipsecond, _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsSplit).ExecAction(ipfirst).Item(ActionIsSplitKeys)
                    
        Case Else
                
            Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.UnexpectedItemInParamArray)
                
          
    End Select
        
End Sub


Friend Sub SetGlobalsResWhenFirstParamIsIterableItemsByEnum(ByVal ipfirst As Variant, ByVal ipsecond As Variant)
    'determine what to do based on second item
    
    Select Case True
            
        Case Types.Group.IsPrimitive(ipsecond)
            'iterable to primitive is iterable to const series of primitive
           If BailOut.When(True, Msg.KvpSecondParamterIsNotValid) Then Exit Sub
                    
                
        Case Arrays.IsMDArray(ipsecond)
            'MDarrays have no special action with an iterable so error out
            If BailOut.When(True, Msg.KvpSecondParamterIsNotValid) Then Exit Sub
                        
                        
        Case Arrays.IsTableArray(ipsecond)
            'Iterable vs Table is iterable vs rows of table
                    
            Globals.Res.SetOkay.SetItems _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsNoAction).ExecAction(ipfirst).Item(AfterTableAction.ActionIsNoActionRows), _
                ipfirst
            
                        
        Case Types.Group.IsIterableKeysByEnum(ipsecond)
            ' iterable vs dictionary is iterable to dictionary items
            Globals.Res.SetOkay.SetItems _
                ipsecond.Items, _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsSplit).ExecAction(ipfirst).Item(AfterTableAction.ActionIsSplitRows)
                    
                
        Case Types.Group.IsIterableItemsByEnum(ipsecond)
            'iterable to iterable is iterable to iterable
            Globals.Res.SetOkay.SetItems ipsecond, ipfirst
                        
        Case Else
                
            Globals.Res.SetNotOkay enums.Message.AsEnum(Msg.UnexpectedItemInParamArray)
                
                    
    End Select
        
End Sub

Friend Sub SetGlobalsResWhenFirstParamIsIterableKeysByENum(ByVal ipfirst As Variant, ByVal ipsecond As Variant)
        
  'determine what to do based on second item
    Select Case True
          
        Case Types.Group.IsPrimitive(ipsecond)
            'Keys to primitive, invalid operation
            If BailOut.When(True, Msg.KvpSecondParamterIsNotValid) Then Exit Sub
            
                
        Case Arrays.IsMDArray(ipsecond)
            'MDarrays have no special action with an iterable so error out
            If BailOut.When(True, Msg.KvpSecondParamterIsNotValid) Then Exit Sub
            
                    
        Case Arrays.IsTableArray(ipsecond)
            'Dictionary vs Table is keys vs table rows
            Globals.Res.SetOkay.SetItems _
                enums.TableToLystActions.Action(RankIsRowFirstItemActionIsNoAction).ExecAction(ipfirst).Item(AfterTableAction.ActionIsNoActionRows), _
                ipfirst.Keys
                    
                    
        Case Types.Group.IterableKeysByEnum(ipsecond)
            ' dictionary vs dictionary is keys vs items
            Globals.Res.SetOkay.SetItems ipsecond.Items, ipfirst.Keys
                
                
        Case Types.Group.IsIterableItemsByEnum(ipsecond)
            'dictionary to iterable Is  dictionary keys to iterabl
            Globals.Res.Init(Msg.Okay).SetItems ipsecond, ipfirst.Keys
                    
        Case Else
                
            Globals.Res.SetNotOkay (Msg.UnexpectedItemInParamArray)
            
      
    End Select
  
End Sub

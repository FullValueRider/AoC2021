VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "eMessage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
''@IgnoreModule
'@PredeclaredId
'@Exposed
'@Folder("Enums")


Public Enum Msg
        
    NotOkay = -1
    Okay = 0
        
    vbReturnWithoutGoSub = 3
    vbInvalidProcedureCall = 5
    vbOverflow = 6
    vbOutOfMemory = 7
    vbSubscriptOutOfRange = 9
    vbThisArrayIsFixedOrTemporarilyLocked = 10
    vbDivisionByZero = 11
    vbTypeMismatch = 13
    vbOutOfStringSpace = 14
    vbExpressionTooComplex = 16
    vbCannotPerformRequestedOperation = 17
    vbUserInterruptOccurred = 18
    vbResumeWithoutError = 20
    vbOutOfStackSpace = 28
    vbSubFunctionOrPropertyNotDefined = 35
    vbTooManyCodeResourceOrDLLApplicationClients = 47
    vbErrorInLoadingCodeResourceOrDLL = 48
    vbBadCodeResourceOrDLLCallingConvention = 49
    vbInternalError = 51
    vbBadFileNameOrNumber = 52
    vbFileNotFound = 53
    vbBadFileMode = 54
    vbFileAlreadyOpen = 55
    vbDeviceIOError = 57
    vbFileAlreadyExists = 58
    vbBadRecordLength = 59
    vbDiskFull = 61
    vbInputPastEndOfFile = 62
    vbBadRecordNumber = 63
    vbTooManyFiles = 67
    vbDeviceUnavailable = 68
    vbPermissionDenied = 70
    vbDiskNotReady = 71
    vbCannotRenameWithDifferentDrive = 74
    vbPathFileAccessError = 75
    vbPathNotFound = 76
    vbObjectVariableOrWithBlockVariableNotSet = 91
    vbForLoopNotInitialized = 92
    vbInvalidPatternString = 93
    vbInvalidUseOfNull = 94
    vbCannotCallFriendProcedureOnAnObjectThatIsNotAnInstanceOfTheDefiningClass = 97
    vbAPropertyOrMethodCallCannotIncludeAReferenceToAPrivateObjectEitherAsAnArgumentOrAsAReturnValue = 98
    vbSystemResourceOrDLLCouldNotBeLoaded = 298
    vbCannotUseCharacterDeviceNamesInSpecifiEdfileNames = 320
    vbInvalidFileFormat = 321
    vbCannotMakeNecessaryTemporaryFile = 322
    vbInvalidFormatInResourceFile = 325
    vbDataValueNamedNotFound = 327
    vbIllegalParameterCannotWriteArrays = 328
    vbCouldNotAccessSystemRegistry = 335
    vbComponentNotCorrectlyRegistered = 336
    vbComponentNotFound = 337
    vbComponentDidNotRunCorrectly = 338
    vbObjectAlreadyLoaded = 360
    vbCannotLoadOrUnloadThisObject = 361
    vbControlSpecifiEdnotFound = 363
    vbObjectWasUnloaded = 364
    vbUnableToUnloadWithinThisContext = 365
    vbTheSpecifiEdfileIsOutOfDateThisProgramRequiresALaterVersion = 368
    vbTheSpecifiedObjectCannotBeUsEdasAnOwnerFormForShow = 371
    vbInvalidPropertyValue = 380
    vbInvalidPropertyArrayIndex = 381
    vbPropertySetCannotBeExecutedAtRunTime = 382
    vbPropertySetCannotBeUsedWithAReadOnlyProperty = 383
    vbNeedPropertyArrayIndex = 385
    vbPropertySetNotPermitted = 387
    vbPropertyGetCannotBeExecutEdatRunTime = 393
    vbPropertyGetCannotBeExecutEdonWriteOnlyProperty = 394
    vbFormAlreadyDisplayEdcannotShowModally = 400
    vbCodeMustCloseTopmostModalFormFirst = 402
    vbPermissionToUseObjectDenied = 419
    vbPropertyNotFound = 422
    vbPropertyOrMethodNotFound = 423
    vbObjectRequired = 424
    vbInvalidObjectUse = 425
    vbComponentCannotMakeObjectOrReturnReferenceToThisObject = 429
    vbClassDoesNotSupportAutomation = 430
    vbFileNameOrClassNameNotFoundDuringAutomationOperation = 432
    vbObjectDoesNotSupportThisPropertyOrMethod = 438
    vbAutomationError = 440
    vbConnectionToTypeLibraryOrObjectLibraryForRemoteProcessHasBeenLost = 442
    vbAutomationObjectDoesNotHaveADefaultValue = 443
    vbObjectDoesNotSupportThisAction = 445
    vbObjectDoesNotSupportNamEdarguments = 446
    vbObjectDoesNotSupportCurrentLocaleSetting = 447
    vbNamedArgumentNotFound = 448
    vbArgumentNotOptionalOrInvalidPropertyAssignment = 449
    vbWrongNumberOfArgumentsOrInvalidPropertyAssignment = 450
    vbObjectNotACollection = 451
    vbInvalidOrdinal = 452
    vbSpecifiEdcodeResourceNotFound = 453
    vbCodeResourceNotFound = 454
    vbCodeResourceLockError = 455
    vbThisKeyIsAlreadyAssociatedWithAnElementOfThisCollection = 457
    vbVariableUsesATypeNotSupportEdinVisualBasic = 458
    vbThisComponentDoesNotSupportTheSetOfEvents = 459
    vbInvalidClipboardFormat = 460
    vbMethodOrDataMemberNotFound = 461
    vbTheRemoteServerMachineDoesNotExistOrIsUnavailable = 462
    vbClassNotRegisterEdonLocalMachine = 463
    vbCannotMakeAutoRedrawImage = 480
    vbInvalidPicture = 481
    vbPrinterError = 482
    vbPrinterDriverDoesNotSupportSpecifiEdproperty = 483
    vbProblemGettingPrinterInformationFromTheSystemMakeSureThePrinterIsSetUpCorrectly = 484
    vbInvalidPictureType = 485
    vbCannotPrintFormImageToThisTypeOfPrinter = 486
    vbCannotEmptyClipboard = 520
    vbCannotOpenClipboard = 521
    vbCannotSaveFileToTEMPDirectory = 735
    vbSearchTextNotFound = 744
    vbReplacementsTooLong = 746
    vbApplicationDefinedOrObjectDefinedError = 1004
    ' SystemOutOfMemory = 31001
    ' NoObject = 31004
    ' ClassIsNotSet = 31018
    ' UnableToActivateObject = 31027
    ' UnableToCreateEmbeddedobject = 31032
    ' ErrorSavingToFile = 31036
    ' ErrorLoadingFromFile = 31037
    
    
    'ToDo: Reorganise the enum below to be more coherent
   TwinLib64Errors = vbobjecterror + 1024
        

    'TypeIssues
    IsNotSameType
    IsNotNumber
    IsNotString
    IsNotArray
    HasNoItems
    
    'NoCountMethod
    
    
    
    

    Keys
    Items
    
    
    'Class issues
    InvalidMethod
    UsePredeclaredIdInstance
    InvalidNew
    UseNewInstance
    HasNoInstance
    InvalidInstanceCreation
    DisallowedOverwrite
    

    DoubleInitialisation
    NullReference

    ' Dictionary Issues
    AutoKeyResetNotAllowed
    InvalidKey

    ' Iterable issues
    IsNotIterable
    DoesNotIterateByIndex
    InvalidType
    IterableHasNoItems
    IndexBeforeFirstIndex
    IndexAfterLastIndex
    IterableObjectCountIsNotValid
    NotSameSize
        
    'Array Issues
    ParamArrayIsNotValid
    ArrayHasNoItems
    ArrayLacksRank
    HasNoRanks
    IsNotTableArray
    IsNotListArray
    InvalidArrayMarkup
    InvalidArray
    RankLessThanArrayFirstRank
    ItemDoesNotSupportRanks
    UnexpectedItemInParamArray
        
        
    'Parameter issues
    UnexpectedEmpty
    MissingParameter
    StringIsEmpty
    ZeroIsInvalidParameter
    IterableIsEmpty
    'Result messages
    ResultOkayInputSelectorIsInvalid
    
    'General messages
    notequal
    Unspecified
   

    StartIndexWasZeroResetToOne
    StartIndexExceedsItemCount
    EndIndexExceedsItemCount
    EndIndexWasZeroResetToOne
    RunLengthTooLong
    IndexWillOverrun
    DestinationTooSmall
    
    InvalidInsertCountZero
    RunLengthIsZero
    CountCannotBeLessThanOne


    'Enumeration issues
    ActionNotExecutable
    msgLacksMember
    DisAllowedEnumerationMember
    
    'KvpIsssues
    AutoKeyIsNotValid
    KvpSecondParamterIsNotValid
    KeyNotFound
    IncrementIsNotValid
    DecrementIsNotValid
End Enum

Private Type State
        
    Actions                 As Scripting.Dictionary
    Strings                 As Scripting.Dictionary
        
End Type

Private s                   As State

'Private Type ReadOnly
'
'    Location                As String
'
'
'End Type
'
'Private r                  As ReadOnly

Private Sub Class_Initialise()
        
    'r.Location = "VBALib.Enums."
    If BailOut.When(Me Is eMessage) Then Exit Sub
    SetupDictionaries
        
End Sub

Private Sub SetupDictionaries()
        
    Set s.Strings = CreateObject("Scripting.Dictionary")
    With s.Strings
        
        .Add _
        vbReturnWithoutGoSub, _
        "Return without GoSub"
    
        .Add _
        vbInvalidProcedureCall, _
        "Invalid procedure call"
    
        .Add _
        vbOverflow, _
        "Overflow"
    
        .Add _
        vbOutOfMemory, _
        "Out of memory"
    
        .Add _
        vbSubscriptOutOfRange, _
        "Subscript out of range"
    
        .Add _
        vbThisArrayIsFixedOrTemporarilyLocked, _
        "This array is fixed or temporarily locked"
    
        .Add _
        vbDivisionByZero, _
        "Division by zero"
    
        .Add _
        vbTypeMismatch, _
        "Type mismatch"
    
        .Add _
        vbOutOfStringSpace, _
        "Out of string space"
    
        .Add _
        vbExpressionTooComplex, _
        "Expression too complex"
    
        .Add _
        vbCannotPerformRequestedOperation, _
        "Cannot perform requested operation"
    
        .Add _
        vbUserInterruptOccurred, _
        "User interrupt occurred"
    
        .Add _
        vbResumeWithoutError, _
        "Resume without error"
    
        .Add _
        vbOutOfStackSpace, _
        "Out of stack space"
    
        .Add _
        vbSubFunctionOrPropertyNotDefined, _
        "Sub  Function  or Property not defined"
    
        .Add _
        vbTooManyCodeResourceOrDLLApplicationClients, _
        "Too many code resource or DLL application clients"
    
        .Add _
        vbErrorInLoadingCodeResourceOrDLL, _
        "Error in loading code resource or DLL"
    
        .Add _
        vbBadCodeResourceOrDLLCallingConvention, _
        "Bad code resource or DLL calling convention"
    
        .Add _
        vbInternalError, _
        "Internal error"
    
        .Add _
        vbBadFileNameOrNumber, _
        "Bad file name or number"
    
        .Add _
        vbFileNotFound, _
        "File not found"
    
        .Add _
        vbBadFileMode, _
        "Bad file mode"
    
        .Add _
        vbFileAlreadyOpen, _
        "File already open"
    
        .Add _
        vbDeviceIOError, _
        "Device I O error"
    
        .Add _
        vbFileAlreadyExists, _
        "File already exists"
    
        .Add _
        vbBadRecordLength, _
        "Bad record length"
    
        .Add _
        vbDiskFull, _
        "Disk full"
    
        .Add _
        vbInputPastEndOfFile, _
        "Input past end of file"
    
        .Add _
        vbBadRecordNumber, _
        "Bad record number"
    
        .Add _
        vbTooManyFiles, _
        "Too many files"
    
        .Add _
        vbDeviceUnavailable, _
        "Device unavailable"
    
        .Add _
        vbPermissionDenied, _
        "Permission denied"
    
        .Add _
        vbDiskNotReady, _
        "Disk not ready"
    
        .Add _
        vbCannotRenameWithDifferentDrive, _
        "Cannot rename with different drive"
    
        .Add _
        vbPathFileAccessError, _
        "Path File access error"
    
        .Add _
        vbPathNotFound, _
        "Path not found"
    
        .Add _
        vbObjectVariableOrWithBlockVariableNotSet, _
        "Object variable or With block variable not set"
    
        .Add _
        vbForLoopNotInitialized, _
        "For loop not initialized"
    
        .Add _
        vbInvalidPatternString, _
        "Invalid pattern string"
    
        .Add _
        vbInvalidUseOfNull, _
        "Invalid use of Null"
    
        .Add _
        vbCannotCallFriendProcedureOnAnObjectThatIsNotAnInstanceOfTheDefiningClass, _
        "Cannot call Friend procedure on an object that is not an instance of the defining class"
    
        .Add _
        vbAPropertyOrMethodCallCannotIncludeAReferenceToAPrivateObjectEitherAsAnArgumentOrAsAReturnValue, _
        "A property or method call cannot include a reference to a private object  either as an argument or as aop value"
    
        .Add _
        vbSystemResourceOrDLLCouldNotBeLoaded, _
        "System resource or DLL could not be loaded"
    
        .Add _
        vbCannotUseCharacterDeviceNamesInSpecifiEdfileNames, _
        "Cannot use character device names in specifiEdfile names"
    
        .Add _
        vbInvalidFileFormat, _
        "Invalid file format"
    
        .Add _
        vbCannotMakeNecessaryTemporaryFile, _
        "Cannot Make necessary temporary file"
    
        .Add _
        vbInvalidFormatInResourceFile, _
        "Invalid format in resource file"
    
        .Add _
        vbDataValueNamedNotFound, _
        "Data value namEdnot found"
    
        .Add _
        vbIllegalParameterCannotWriteArrays, _
        "Illegal parameter cannot write arrays"
    
        .Add _
        vbCouldNotAccessSystemRegistry, _
        "Could not access system registry"
    
        .Add _
        vbComponentNotCorrectlyRegistered, _
        "Component not correctly registered"
    
        .Add _
        vbComponentNotFound, _
        "Component not found"
    
        .Add _
        vbComponentDidNotRunCorrectly, _
        "Component did not run correctly"
    
        .Add _
        vbObjectAlreadyLoaded, _
        "Object already loaded"
    
        .Add _
        vbCannotLoadOrUnloadThisObject, _
        "Cannot load or unload this object"
    
        .Add _
        vbControlSpecifiEdnotFound, _
        "Control specifiEdnot found"
    
        .Add _
        vbObjectWasUnloaded, _
        "Object was unloaded"
    
        .Add _
        vbUnableToUnloadWithinThisContext, _
        "Unable to unload within this context"
    
        .Add _
        vbTheSpecifiEdfileIsOutOfDateThisProgramRequiresALaterVersion, _
        "The specifiEdfile is out of date This program requires a later version"
    
        .Add _
        vbTheSpecifiedObjectCannotBeUsEdasAnOwnerFormForShow, _
        "The specifiEdobject Cannot be usEdas an owner form for Show"
    
        .Add _
        vbInvalidPropertyValue, _
        "Invalid property value"
    
        .Add _
        vbInvalidPropertyArrayIndex, _
        "Invalid property array index"
    
        .Add _
        vbPropertySetCannotBeExecutedAtRunTime, _
        "Property Set Cannot be executEdat run time"
    
        .Add _
        vbPropertySetCannotBeUsedWithAReadOnlyProperty, _
        "Property Set Cannot be usEdwith a read only property"
    
        .Add _
        vbNeedPropertyArrayIndex, _
        "NeEdproperty array index"
    
        .Add _
        vbPropertySetNotPermitted, _
        "Property Set not permitted"
    
        .Add _
        vbPropertyGetCannotBeExecutEdatRunTime, _
        "Property Get Cannot be executEdat run time"
    
        .Add _
        vbPropertyGetCannotBeExecutEdonWriteOnlyProperty, _
        "Property Get Cannot be executEdon write only property"
    
        .Add _
        vbFormAlreadyDisplayEdcannotShowModally, _
        "Form already displayEdcannot show modally"
    
        .Add _
        vbCodeMustCloseTopmostModalFormFirst, _
        "Code must close topmost modal form First"
    
        .Add _
        vbPermissionToUseObjectDenied, _
        "Permission to use object denied"
    
        .Add _
        vbPropertyNotFound, _
        "Property not found"
    
        .Add _
        vbPropertyOrMethodNotFound, _
        "Property or method not found"
    
        .Add _
        vbObjectRequired, _
        "Object required"
    
        .Add _
        vbInvalidObjectUse, _
        "Invalid object use"
    
        .Add _
        vbComponentCannotMakeObjectOrReturnReferenceToThisObject, _
        "Component Cannot Make object orop reference to this object"
    
        .Add _
        vbClassDoesNotSupportAutomation, _
        "Class does not support Automation"
    
        .Add _
        vbFileNameOrClassNameNotFoundDuringAutomationOperation, _
        "File name or class name not found during Automation operation"
    
        .Add _
        vbObjectDoesNotSupportThisPropertyOrMethod, _
        "Object does not support this property or method"
    
        .Add _
        vbAutomationError, _
        "Automation error"
    
        .Add _
        vbConnectionToTypeLibraryOrObjectLibraryForRemoteProcessHasBeenLost, _
        "Connection to type library or object library for remote process has been lost"
    
        .Add _
        vbAutomationObjectDoesNotHaveADefaultValue, _
        "Automation object does not have a default value"
    
        .Add _
        vbObjectDoesNotSupportThisAction, _
        "Object does not support this action"
    
        .Add _
        vbObjectDoesNotSupportNamEdarguments, _
        "Object does not support namEdarguments"
    
        .Add _
        vbObjectDoesNotSupportCurrentLocaleSetting, _
        "Object does not support current locale setting"
    
        .Add _
        vbNamedArgumentNotFound, _
        "NamEdargument not found"
    
        .Add _
        vbArgumentNotOptionalOrInvalidPropertyAssignment, _
        "Argument not optional or invalid property assignment"
    
        .Add _
        vbWrongNumberOfArgumentsOrInvalidPropertyAssignment, _
        "Wrong number of arguments or invalid property assignment"
    
        .Add _
        vbObjectNotACollection, _
        "Object not a collection"
    
        .Add _
        vbInvalidOrdinal, _
        "Invalid ordinal"
    
        .Add _
        vbSpecifiEdcodeResourceNotFound, _
        "SpecifiEdcode resource not found"
    
        .Add _
        vbCodeResourceNotFound, _
        "Code resource not found"
    
        .Add _
        vbCodeResourceLockError, _
        "Code resource lock error"
    
        .Add _
        vbThisKeyIsAlreadyAssociatedWithAnElementOfThisCollection, _
        "This Key is already associatEdwith an element of this collection"
    
        .Add _
        vbVariableUsesATypeNotSupportEdinVisualBasic, _
        "Variable uses a type not supportEdin Visual Basic"
    
        .Add _
        vbThisComponentDoesNotSupportTheSetOfEvents, _
        "This component does not support the set of events"
    
        .Add _
        vbInvalidClipboardFormat, _
        "Invalid Clipboard format"
    
        .Add _
        vbMethodOrDataMemberNotFound, _
        "Method or data member not found"
    
        .Add _
        vbTheRemoteServerMachineDoesNotExistOrIsUnavailable, _
        "The remote server machine does not exist or is unavailable"
    
        .Add _
        vbClassNotRegisterEdonLocalMachine, _
        "Class not registerEdon local machine"
    
        .Add _
        vbCannotMakeAutoRedrawImage, _
        "Cannot Make AutoRedraw image"
    
        .Add _
        vbInvalidPicture, _
        "Invalid picture"
    
        .Add _
        vbPrinterError, _
        "Printer error"
    
        .Add _
        vbPrinterDriverDoesNotSupportSpecifiEdproperty, _
        "Printer driver does not support specifiEdproperty"
    
        .Add _
        vbProblemGettingPrinterInformationFromTheSystemMakeSureThePrinterIsSetUpCorrectly, _
        "Problem getting printer information from the system Make sure the printer is set up correctly"
    
        .Add _
        vbInvalidPictureType, _
        "Invalid picture type"
    
        .Add _
        vbCannotPrintFormImageToThisTypeOfPrinter, _
        "Cannot print form image to this type of printer"
    
        .Add _
        vbCannotEmptyClipboard, _
        "Cannot empty Clipboard"
    
        .Add _
        vbCannotOpenClipboard, _
        "Cannot open Clipboard"
    
        .Add _
        vbCannotSaveFileToTEMPDirectory, _
        "Cannot save file to TEMP directory"
    
        .Add _
        vbSearchTextNotFound, _
        "Search text not found"
    
        .Add _
        vbReplacementsTooLong, _
        "Replacements too long"
    
        .Add _
        vbApplicationDefinedOrObjectDefinedError, _
        "Application-defined or object-defined error"
    
        ' .Add _
        '     SystemOutOfMemory, _
        '    "System Out of memory"
    
        ' .Add _
        '     NoObject, _
        '    "No object"
    
        ' .Add _
        '     ClassIsNotSet, _
        '    "Class is not set"
    
        ' .Add _
        '     UnableToActivateObject, _
        '    "Unable to activate object"
    
        ' .Add _
        '     UnableToMakeEmbeddEdobject, _
        '    "Unable to Make embeddEdobject"
    
        ' .Add _
        '     ErrorSavingToFile, _
        '    "Error saving to file"
    
        ' .Add _
        '     ErrorLoadingFromFile, _
        '    "Error loading from file"
        
        '.Add Unspecified, "An unspecified error has occurred"
        
        'Type Messages
        .Add IsNotSameType, "The types do not match '{0}','{1}"
        .Add IsNotNumber, "Expected a number"
        .Add IsNotString, "Expected a string"
        .Add IsNotArray, "Expecting an array: Found '{0}'"
        
        'Class Messages
        .Add InvalidMethod, "Object '{0}' does not have a '{1}' method"
        '.Add NoCountMethod, "Object '{0}' has no Count method"
        .Add HasNoInstance, "The object has no instance"
        
        .Add UnexpectedEmpty, "Unexpected Empty in '{0}'"
        .Add MissingParameter, "An expected parameter is missing"
        .Add DisallowedOverwrite, "The current instance of '{0}' cannot be overridden by a new instance"

        'Array Messages
        .Add ParamArrayIsNotValid, "The paramter array was empty"
        .Add ArrayHasNoItems, "Uninitialised array '{0}'"
        .Add ArrayLacksRank, "Array does not have Rank {0}"
        .Add HasNoRanks, "Item has no Ranks"
        ' Iterables Messages
        .Add IsNotIterable, "Type '{0}' is not Iterable"
        .Add DoesNotIterateByIndex, "Type '{0}' does not iterate by Index"
        .Add IterableHasNoItems, "The iterable {0} does not contain any items"
        .Add NotSameSize, "The two iterables are not the same size {0}, {1}"
        '.Add InvalidDimensions, "Not a '{0}' dimensional array"
        '.Add NotSingleDimension, "Item '{0}' is not a single dimension array"
        .Add RankLessThanArrayFirstRank, "Type '{0}' does not have a rank of '{0}'"
        .Add ItemDoesNotSupportRanks, "Object does not support ranks '{0}'"
        .Add Keys, vbNullString
        .Add Items, vbNullString
       .Add IterableObjectCountIsNotValid, "Iterable does not have a valid count"
        ' AutoKey Messages
        .Add AutoKeyResetNotAllowed, "Second attempty at initialising Autokey"
        .Add AutoKeyIsNotValid, "The provided autokey is not known {0}"
        
        ' Dictionary Messages
        .Add InvalidKey, "The specified key Type '{0}' does not mast the Host Kvp Key Type '{1}'"

        '.Add NotIterableType, "Type '{0}' is not iterable"
        
        'Range  Messages
        
        
        .Add RunLengthIsZero, "Invalid Run of 0"
        .Add DestinationTooSmall, "Cannot copy {0} items to array of {1}"
        
        'Fmt, Stringifier messages
        .Add InvalidArrayMarkup, "The Array Markup was invalid"
        
        .Add InvalidType, "Type error: expecting {0} found '{1} in '{2}''"
        .Add InvalidArray, "Invalid Array, incorrect number of ranks"
        
        .Add StartIndexWasZeroResetToOne, "The start index was zero.  Reset to one"
        .Add StartIndexExceedsItemCount, "The start index was more than the last index"
        .Add EndIndexWasZeroResetToOne, "The end index was zero.  Reset to one"
        .Add EndIndexExceedsItemCount, "The end index was more than the last index"
        .Add RunLengthTooLong, "Run length was reduced to match last index"
        '.Add IndexWillOverrun, "Index will exceed size"
        .Add KeyNotFound, "Key of '{0}' was not found"
        .Add InvalidInsertCountZero, "Cannot insert if count is zero"
        .Add IndexBeforeFirstIndex, "Index less than FirstIndex"
        .Add IndexAfterLastIndex, "Index morethans LastIndex"
        
        .Add UsePredeclaredIdInstance, "Method should be invoked from the default/predeclared instance of this class."
        .Add UseNewInstance, "Method should be invoked from a new instance of this class."
        .Add InvalidNew, "New should no be used for with this predecalredIs '{0}'"
        .Add InvalidInstanceCreation, "Use the PredeclaredId of this class only"

        .Add DoubleInitialisation, "Raises a run-time error if the specified object reference is already set."
        .Add NullReference, "Object reference '{0}' cannot be Nothing."
        .Add StringIsEmpty, "String cannot be empty."

        .Add ActionNotExecutable, "The enumeration action is not an executable object"
        .Add msgLacksMember, "Not a member of Enumeration '{0}'"
        .Add DisAllowedEnumerationMember, "Method does not allow enummeration member at index {0}"
        .Add UnexpectedItemInParamArray, "Don't know how to parse Type '{0}'"
        
        '
        
        ' Parameter messages
        .Add ZeroIsInvalidParameter, "A value of zero is not valid"
        .Add IterableIsEmpty, "The parameter array is empty"
        'Result messages
        
        .Add ResultOkayInputSelectorIsInvalid, "The value for the input type for Results.SetOkay is not valid"
        'kvp issues
        
        .Add KvpSecondParamterIsNotValid, "The second parameter could not be used to construct a Kvp"
        
        'General Messages
        .Add notequal, "Not equal"
        .Add Unspecified, "The type of error was not specified"
        .Add CountCannotBeLessThanOne, "Count cannot be zero"
    End With
        
End Sub

Public Function Strings() As Variant
    Strings = s.Strings.Items
End Function

Public Function Members() As Variant
    Members = s.Strings.Keys
End Function

Public Function Actions() As Variant
    Actions = s.Actions.Items
End Function

Public Function Ord(ByVal ipEnum As Msg) As Long
        
    Dim myitem As Variant
    Dim myOrd As Long
    myOrd = 1
    For Each myitem In s.Strings.Keys
            
        If myitem = ipEnum Then
                
            Ord = myOrd
            Exit Function
                
        Else
            
            myOrd = myOrd + 1
                
        End If
            
    Next
        
End Function

Public Property Get AsEnum(ByVal ipEnum As Msg) As Msg
    AsEnum = ipEnum
End Property

Public Property Get ToString(ByVal ipEnum As Msg) As String
    If enums.Message.HoldsMember(ipEnum) Then
        ToString = s.Strings.Item(ipEnum)
    Else
        ToString = vbNullString
    End If
End Property


Public Function HoldsMember(ByVal ipEnum As Msg) As Boolean
    If s.Strings Is Nothing Then SetupDictionaries
    HoldsMember = s.Strings.Exists(ipEnum)
End Function

Public Function LacksMember(ByVal ipEnum As Msg) As Boolean
    LacksMember = Not HoldsMember(ipEnum)
End Function


Public Property Get Name() As String
    Name = TypeName(Me)
End Property

Public Property Get Count() As Long
    If s.Strings Is Nothing Then SetupDictionaries
    Count = s.Strings.Count
End Property


' We are using Preset to mean constant
' this is because the Name Constant is already used by VBA
Attribute VB_Name = "Preset"
Option Explicit

Public Const NotANumber As String = "NaN"

Public Const MaxLong As Long = &H7FFFFFFF
Public Const MinLong As Long = &HFFFFFFFF

'Arrays
Public Const ArrayFirstRank As Long = 1



'Globals
Public Const ResultStatusOkay As Boolean = True
Public Const ResultStatusNotOkay As Boolean = False

' 'Kvp
' The Kvp class uses 1 based indexing
' , so an index of 0 is used to indicate an
' add operation rather than an InsertAt operation
Public Const KvpInsertIndexIsAdd As Long = 0
Public Const DefaultDec As Long = 1
Public Const DefaultInc As Long = 1
Public Const DefaultAdjust As Long = 1

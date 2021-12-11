VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DDay04"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@IgnoreModule
'@Folder("Days")

Private Const InputData     As String = "Day03.txt"

Private Type State

    Data                        As Lyst
    Transposed                  As Lyst
    
    
End Type

Private s                       As State



Public Sub Execute()
    
    Part01
    Part02
    
End Sub

Public Sub Part01()
    
'    If s.Data Is Nothing Then
'
'        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLystOfChar)
'        Set s.Transposed = s.Data.Transpose
'
'
'     End If
'
'
'
'    Dim myResult As Long
'    myResult = Strs.BinToLong(myGamma) * Strs.BinToLong(myEpsilon)
'
'    Fmt.Dbg "The answer to Day 03 part 1 is 845186.  Found is {0}", myResult
'
End Sub

Public Sub Part02()
    
'    If s.Data Is Nothing Then
'
'        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLystOfChar)
'        Set s.Transposed = s.Data.Transpose
'
'
'     End If
'
'
'
'    Dim myResult As Long
'    myResult = Strs.BinToLong(myLastOxygen.ToString(vbNullString)) * Strs.BinToLong(myLastCO2.ToString(vbNullString))
'    Fmt.Dbg "The answer to Day 03 Part 2 is 4636702. Found {0}", myResult
'
'    End Sub
'
End Sub


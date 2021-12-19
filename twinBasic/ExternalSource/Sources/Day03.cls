VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DDay03"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
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
    
    If s.Data Is Nothing Then
       
        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLystOfChar)
        Set s.Transposed = s.Data.Transpose
        
        
     End If
     
    Dim myOnes As Long
    Dim myGamma As String
    Dim myEpsilon As String

    Dim myItem As Variant
    For Each myItem In s.Transposed
        myOnes = myItem.ReduceIt(rdCountIt.Deb(cmpEQ.Deb("1")))
        ' This part works when the bias is to '1' if '1' and '0' are equal
        'so we can't use >=, just >
        If myOnes > myItem.Count - myOnes Then
            myGamma = myGamma & "1"
            myEpsilon = myEpsilon & "0"
        Else
            myGamma = myGamma & "0"
            myEpsilon = myEpsilon & "1"
            
        End If
        
    Next
     
    Dim myResult As Long
    myResult = Strs.BinToLong(myGamma) * Strs.BinToLong(myEpsilon)

    Fmt.Dbg "The answer to Day 03 part 1 is 845186.  Found is {0}", myResult
    
End Sub

Public Sub Part02()
    
    If s.Data Is Nothing Then
       
        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLystOfChar)
        Set s.Transposed = s.Data.Transpose
        
        
     End If
   
    Dim myOnes As Long
    Dim myLastOxygen As Lyst          'seq[char]
    Dim myLastCO2 As Lyst                'seq[char]
    Dim myReadings As Lyst              'seq [seq[char] ]
    Dim myBit As String                 ' Char

    Set myReadings = s.Data.Clone
    Set s.Transposed = s.Data.Transpose()

     Dim myIndex As Variant
     For myIndex = 0 To s.Transposed.LastIndex
        
        Set myLastOxygen = myReadings.Last
        myOnes = s.Transposed.Item(myIndex).ReduceIt(rdCountIt.Deb(cmpEQ.Deb("1")))
        
        If myOnes >= myReadings.Count - myOnes Then
            myBit = "1"
        Else
            myBit = "0"
            
        End If

        Set myReadings = myReadings.FilterIt(ftIfIt.Deb(cmpEQ.Deb(myBit, myIndex)))
       
        If myReadings.Count = 1 Then
            
            Set myLastOxygen = myReadings.First
            Exit For
            
        End If
        
        Set s.Transposed = myReadings.Transpose
        
    Next


    Set myReadings = s.Data.Clone
    Set s.Transposed = s.Data.Transpose

    
    For myIndex = 0 To s.Transposed.LastIndex
        Set myLastCO2 = myReadings.Last
        myOnes = s.Transposed.Item(myIndex).ReduceIt(rdCountIt.Deb(cmpEQ.Deb("1")))
        If myOnes >= myReadings.Count - myOnes Then
            
            myBit = "0"
            
        Else
            
        
            myBit = "1"
            
        End If
        
        Set myReadings = myReadings.FilterIt(ftIfIt.Deb(cmpEQ.Deb(myBit, myIndex)))
    
        If myReadings.Count = 1 Then
            Set myLastCO2 = myReadings.First
            Exit For
            
        End If
        
        Set s.Transposed = myReadings.Transpose
        
    Next

    Dim myResult As Long
    myResult = Strs.BinToLong(myLastOxygen.ToString(vbNullString)) * Strs.BinToLong(myLastCO2.ToString(vbNullString))
    Fmt.Dbg "The answer to Day 03 Part 2 is 4636702. Found {0}", myResult
    
    End Sub


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "DDay01"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@IgnoreModule

Private Const InputData             As String = "Day01.txt"

Private Type State

    Integers                        As Lyst
    
End Type

Private s                           As State

Private Sub Class_Initialise()

End Sub

Public Sub Execute()
    
    Part01
    Part02
    
End Sub

Public Sub Part01()
    
    If s.Integers Is Nothing Then
       
       Set s.Integers = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLong)
        
       
    End If
    
    Dim myIndex As Long
    Dim myResult As Long
    For myIndex = 1 To s.Integers.LastIndex
       
       
       If s.Integers.Item(myIndex) > s.Integers.Item(myIndex - 1) Then myResult = myResult + 1
           
    Next

    Fmt.Dbg "The answer to Day 01 part 1 is 1711 .  Found is {0}", myResult
    
End Sub


Public Sub Part02()

    If s.Integers Is Nothing Then
       
        Set s.Integers = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLong)
         
        
     End If
     
     Dim mySums As Lyst
     Set mySums = Lyst.Deb
     
     ' Compile a list of sums of 3 consecutive values
     Dim myIndex As Long
     For myIndex = 2 To s.Integers.LastIndex
        
        mySums.Add s.Integers.Item(myIndex) + s.Integers.Item(myIndex - 1) + s.Integers.Item(myIndex - 2)
        
     Next
     
     ' Now repeat the compare that we did for part 1 using mysums
    Dim myResult As Long
    For myIndex = 1 To mySums.LastIndex
    
        If mySums.Item(myIndex) > mySums.Item(myIndex - 1) Then myResult = myResult + 1
        
    Next

    Fmt.Dbg "The answer to Day 01 part 2 is 1743 .  Found is {0}", myResult
    
End Sub

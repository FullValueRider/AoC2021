VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Day02"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@IgnoreModule
'@Folder("Days.Day01")

Private Const InputData     As String = "Day02.txt"

Private Type State

    Data                        As Lyst
    
End Type

Private s                       As State


Public Sub Execute()
    
    Part01
    Part02
    
End Sub

Public Sub Part01()
    
    If s.Data Is Nothing Then
       
        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLower).MapIt(mpSplit)
         
        
     End If
     
     Dim myItem As Variant
     Dim myX As Long
     Dim myY As Long
     
     For Each myItem In s.Data
        
        Dim myMove As Long
        myMove = CLng(myItem(1))
        
        Select Case myItem(0)
            
            
            Case "forward"
            
                myX = myX + myMove
                
            
            Case "up"
            
                myY = myY - myMove
                
            
            Case "down"
            
                myY = myY + myMove
                
                
        End Select
        
     Next
     
    Dim myResult As Long
    myResult = myX * myY

    Console.Log "The answer to Day 02 part 1 is 1507611.  Found is {0}", myResult
    
End Sub

Public Sub Part02()
    
    If s.Data Is Nothing Then
        
        Set s.Data = Lyst.Deb.AddRange(Filer.GetFileAsArrayOfStrings(AoC2021Data & InputData, vbCrLf)).MapIt(mpToLower).MapIt(mpDedup).MapIt(mpSplit)
            
        
    End If
    
    Dim myItem As Variant
    Dim myX As Long
    Dim myY As Long
    Dim myAim As Long
    For Each myItem In s.Data
    
        Dim myMove As Long
        myMove = CLng(myItem(1))
        
        Select Case myItem(0)
            
            Case "forward"
            
                myX = myX + myMove
                myY = myY + myAim * myMove
            
                
            Case "up"
            
                myAim = myAim - myMove
            
                
            Case "down"
            
                myAim = myAim + myMove
                
                
        End Select
    
    Next
        
    Dim myResult As Long
    myResult = myX * myY
     
    Console.Log "The answer to Day 02 part 2 is 1880593125. Found Is {0}", myResult
    
End Sub

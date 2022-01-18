VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
End
Attribute VB_Name = "Day04"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("Comparers")

Private Const InputData     As String = "Day04.txt"

Private Type State
    
    Data                            As Lyst
    
    DrawnNumbers                    As Lyst     ':seq[int]
    BoardsAsNumbers                 As Lyst     ':seq[seq[seq[int]]]
    Boards                          As Lyst     'seq[Board]
    Win                             As Boolean  ':bool
    Answer                          As Long     ':int
    
End Type

Private s                           As State


Private Sub class_initialize()
    
    If s.Data Is Nothing Then
       
        Set s.Data = Lyst.Deb.AddRange(VBA.Split(Filer.GetFileAsString(AoC2021Data & InputData), vbCrLf, 1))
        Fmt.Dbg " Data {0}", s.Data

        Set s.DrawnNumbers = Lyst.Deb.AddRange(VBA.Split(s.Data.First, Char.twComma)).MapIt(mpToLong)
        Fmt.Dbg "DrawnNumbers {0}", s.DrawnNumbers

        Set s.BoardsAsNumbers = _
            Lyst.Deb _  
                .AddRange(VBA.Split(s.Data.Last, vbCrLf & vbCrLf)) _
                .MapIt(mpSplitToLyst.Deb(vbCrLf)) _
                .MapIt(mpInner.Deb(mpSplitToLyst.Deb(Char.twSpace))) _
                .MapIt(mpInner.Deb(mpToLong))
        Fmt.Dbg "s.BoardNUmbers {0}", s.BoardsAsNumbers

    Set s.Boards = s.BoardsAsNumbers.MapIt(mpDeb.Deb(Day04Board))
    Fmt.Dbg "s.Boards {0}", s.Boards
    
    End If
    
End Sub

Public Sub Execute()
    
    Part01
    Part02
    
End Sub

Public Sub Part01()
    
    Dim myResult As Long
    myResult = PlaySquidBingo
    Fmt.Dbg "The answer to Day 04 part 1 is 845186.  Found is {0}", myResult
    
End Sub

Public Sub Part02()
    
    
    
End Sub


Public Function PlaySquidBingo() As Long

    Dim myNumber As Variant
    For Each myNumber In s.DrawnNumbers

        Dim myBoard As Variant
        For Each myBoard In s.Boards

            If myBoard.Hit(myNumber) Then

                If myBoard.IsWinner Then
                    
                   PlaySquidBingo = myBoard.WinningCode * myNumber
                   Exit Function
                   
                End If
                
            End If
            
        Next
        
    Next
                    
    PlaySquidBingo = -1
    
End Function
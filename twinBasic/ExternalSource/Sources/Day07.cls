VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
End
Attribute VB_Name = "Day07"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("ApC2021")

	Const InputData           As String = "Day07.txt"

  
  Private Type State
      
      Data                            As Lyst
      
      
  End Type
  
  Private s                           As State
  
  
  Private Sub class_initialize()
      
    Debug.Print "Starting"
    If s.Data Is Nothing Then
        
      Set s.Data = _
        Lyst _
          .Deb _
          .AddRange(VBA.Split(Filer.GetFileAsString(AoC2021Data & InputData), Char.twComma)) _
          .MapIt(mpToLong.Deb)
        
      End If
      
  End Sub
 _
  Public Sub Execute()
      
      Part01
      Part02
       
  End Sub
  
  Public Sub Part01()
    
    Dim myAverage As Long = VBA.Round(s.Data.ReduceIt(rdSum.Deb) / s.Data.Count, 0)
   
    Dim myAlignAt As Long
    Dim mycost As Long = Sys.MaxLong
    For myAlignAt = myAverage To 0 Step -1
    
      Dim myDist As Lyst = s.Data.Clone.MapIt(mpDec.Deb(myAlignAt))
      Dim mySumDist As Long = myDist.MapIt(mpMath.Deb(Abs)).ReduceIt(rdSum.Deb)
      If mycost < mySumDist Then Exit For
      mycost = mySumDist
      
    Next
  
    Fmt.Dbg "The answer to Day {0} part 1 is {1}.  Found is {2}", VBA.Mid$(InputData, 4, 2), "343441", mycost
        
  End Sub
  
  Public Sub Part02()
    
    Dim myAverage As Long = VBA.Round(s.Data.ReduceIt(rdSum.Deb) / s.Data.Count, 0)
   
    Dim myAlignAt As Long
    Dim mycost As Long = Sys.MaxLong
    For myAlignAt = myAverage To 0 Step -1
      
      Dim myDist As Lyst
      Set myDist = s.Data.Clone.MapIt(mpDec.Deb(myAlignAt))
      Dim mySumDist As Long = myDist.MapIt(mpMath.Deb(Abs)).MapIt(mpMath.Deb(SumOfInt, 1)).ReduceIt(rdSum.Deb(cmpMTEQ.Deb(0)))
      If mycost < mySumDist Then Exit For
      mycost = mySumDist
      
    Next
    
    Fmt.Dbg "The answer to Day {0} part 2 is {1}.  Found is {2}", VBA.Mid$(InputData, 4, 2), "98925151", mycost
        
  End Sub
  
  Private Function Part2FuelCost(ByVal ipMove As Long) As Long
    
    Dim mysgn As Long = 1 * VBA.Sgn(ipMove)
    Dim mySum As Long
    Dim mymove As Long
    For mymove = Abs(ipMove) To 0 Step -1
      
      mySum += mymove
    Next
    
    Return mySum * mysgn
    
  End Function
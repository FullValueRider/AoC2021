VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
End
Attribute VB_Name = "Day05"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("Comparers")

Const InputData           As String = "Day05.txt"

Const myPoints                      As Long = 1
Const myHLines                      As Long = 2
Const myVLines                      As Long = 3
Const myDLines                      As Long = 4

Const myX1                          As Long = 1
Const myX2                          As Long = 3
Const myY1                          As Long = 2
Const myY2                          As Long = 4

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
        .AddRange(VBA.Split(Filer.GetFileAsString(AoC2021Data & InputData), vbCrLf)) _
        .MapIt(mpMultiReplace.Deb(Array(Array(" ", vbNullString), Array("->", ",")))) _
        .MapIt(mpSplitToLyst.Deb) _
        .MapIt(mpInner.Deb(mpToLong.Deb))
      ' we should now have a lyst of lysts where the inner lyst has 4 itemss
    End If
    
End Sub

Public Sub Execute()
    
    Part01
    Part02
     
End Sub

Public Sub Part01()
  
  Dim myLines As Lyst
  Set myLines = FilterRuns(s.Data)
  
  Dim myVentLocations As Scripting.Dictionary
  Set myVentLocations = CalculateVentLocations(myLines, Array(myPoints, myHLines, myVLines))
  
  Dim myResult As Long
  myResult = Types.Iterable.ToLyst(myVentLocations.Items).CountIt(cmpMT.Deb(1))
  Fmt.Dbg "The answer to Day 05 part 2 is 20271.  Found is {0}", myResult
    
End Sub

Public Sub Part02()
    
  Dim myLines As Lyst
  Set myLines = FilterRuns(s.Data)
  
  Dim myVentLocations As Scripting.Dictionary
  Set myVentLocations = CalculateVentLocations(myLines, Array(myPoints, myHLines, myVLines, myDLines))
  
  Dim myResult As Long
  myResult = Types.Iterable.ToLyst(myVentLocations.Items).CountIt(cmpMT.Deb(1))
  
  Fmt.Dbg "The answer to Day 05 part 2 is xxxxx.  Found is {0}", myResult
    
End Sub


Public Function FilterRuns(ByRef ipRuns As Lyst) As Lyst
  
  Dim myLyst As Lyst
  Set myLyst = Lyst.Deb
  
  myLyst.Add Lyst.Deb
  myLyst.Add Lyst.Deb
  myLyst.Add Lyst.Deb
  myLyst.Add Lyst.Deb
  
  Dim myRun As Variant
  For Each myRun In ipRuns

    myLyst.item(GetLineType(myRun)).add myRun
    
  Next

  Return myLyst
  
End Function

Public Function GetLineType(ByRef ipRun:as lyst) as Long
  
  if (ipRun.item(myX1) = ipRun.item(myX2)) and (ipRun.item(myY1) = ipRun.item(myY2)) then
    return 0
    
  elseif ipRun.item(myY1) = ipRun.item(myY2) then
    return 1
    
  elseif ipRun.item(myX1) = ipRun.item(myX2) then
    return 2
    
  else: ' abs(iprun,item[myX1] - iprun.item(myX2)) - abs(iprun.item(myY1) - iprun.item(myY2)) == 0 then
    return 3
    
  End if
  
End function

' Pline is Point line i.e. x1=x2 and y1 = y2
' we need to split plines out seperately to stop then being counted for 
'both HLines and VLines
' Public Function IsPoint(ByVal ipRun As Lyst) As Boolean
'   IsPoint = (ipRun.Item(myX1) = ipRun.Item(myX2)) And (ipRun.Item(myY1) = ipRun.Item(myY2))
' End Function
 

' Public Function IsHLine(ByVal ipRun As Lyst) As Boolean
'   IsHLine = ipRun.Item(myY1) = ipRun.Item(myY2)
' End Function


' Public Function IsVLine(ByVal ipRun As Lyst) As Boolean
'   IsVLine = ipRun.Item(myX1) = ipRun.Item(myX2)
' End Function


' Public Function IsDline(ByVal iprun As Lyst) As Boolean
'   IsDline = Abs(iprun.Item(myX1) - iprun.Item(myX2)) - Abs(iprun.Item(myY1) - iprun.Item(myY2)) = 0
' End Function


Public Function CalculateVentLocations(ByRef ipLines As Lyst, ByVal ipLinesToCheck As Variant) As Scripting.Dictionary
  
  Dim myCoords As Scripting.Dictionary = New Scripting.Dictionary
  
  Dim myLine As Variant
  For Each myLine In ipLinesToCheck

    Dim myRun As Variant
    For Each myRun In ipLines.Item(myLine)
     
      CheckCoords myRun, myCoords
      
    Next
    
  Next
  
  Set CalculateVentLocations = myCoords
  
End Function


Public Sub CheckCoords(ByVal ipRun As Lyst, ByRef ipCoords As Scripting.Dictionary)
  
  Dim mySingleXStep As Long
  Dim mySingleYstep As Long
 
  Dim myX As Long
  Dim myY As Long
  
  Dim myXStop As IComparer
  Dim myYStop As IComparer
  
  Dim myXNotPassedToX As IComparer
  Dim myYNotPassedToY As IComparer
  
  Dim myRunX1 As Long = ipRun.Item(myX1)
  Dim myRunX2 As Long = ipRun.Item(myX2)
  Dim myRunY1 As Long = ipRun.Item(myY1)
  Dim myRunY2 As Long = ipRun.Item(myY2)
  
  myX = myRunX1
  If myRunX1 <= myRunX2 Then
    
    mySingleXStep = 1
    Set myXStop = cmpMTEQ.Deb(myRunX2) ' X1 mt x2
    Set myXNotPassedToX = cmpLT.Deb(myRunX2) 'x1 lteq x2
    
  Else
    
    mySingleXStep = -1
    Set myXStop = cmpLTEQ.Deb(myRunX2)
    Set myXNotPassedToX = cmpMT.Deb(myRunX2)
    
  End If
  
  myY = myRunY1
  If myRunY1 <= myRunY2 Then
    
    mySingleYstep = 1
    Set myYStop = cmpMTEQ.Deb(myRunY2)
    Set myYNotPassedToY = cmpLT.Deb(myRunY2)
  Else
  
    mySingleYstep = -1
    Set myYStop = cmpLTEQ.Deb(myRunY2)
    Set myYNotPassedToY = cmpMT.Deb(myRunY2)
    
  End If
  
  Dim myCoord As String
  
  Do
  
    DoEvents
    myCoord = Fmt.Txt("{0},{1}", myX, myY)
   
    If ipCoords.Exists(myCoord) Then
      
      ipCoords.Item(myCoord) += 1
      
    Else
      
      ipCoords.Add myCoord, 1
      
    End If
    
    If myXStop.ExecCmp(myX) And myYStop.ExecCmp(myY) Then Exit Do
    If myYNotPassedToY.ExecCmp(myY) Then myY = myY + mySingleYstep
    If myXNotPassedToX.ExecCmp(myX) Then myX = myX + mySingleXStep
      
  Loop
 
End Sub
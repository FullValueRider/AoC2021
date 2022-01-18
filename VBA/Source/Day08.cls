VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Day08"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("ApC2021")

        Const InputData           As String = "Day08.txt"

  
  Private Type State
      
      Data                            As Lyst
      
      
  End Type
  
  Private s                           As State
  
  
  Private Sub Class_Initialize()
      
    Debug.Print "Starting"
    If s.Data Is Nothing Then
        
      Set s.Data = _
        Lyst _
          .Deb _
          .AddRange(VBA.Split(Filer.GetFileAsString(AoC2021Data & InputData), vbCrLf)) _
          .MapIt(mpSplitToLyst.Deb(Char.twBar)) _
          .MapIt(mpInner.Deb(mpSplitToLyst.Deb(Char.twSpace)))
        
      End If
      
  End Sub
 
  Public Sub Execute()
      
      Part01
      Part02
       
  End Sub
  
  Public Sub Part01()
    
   
    Dim myItem As Variant
    For Each myItem In s.Data
      Dim myReadouts As Lyst
      Set myReadouts = myItem
      
      Dim myReadout As Variant
      For Each myReadout In myReadouts.Item(2)
      
        Select Case VBA.Len(myReadout)
          
          Case 2, 3, 4, 7
          
            Dim myCount As Long
            mycount += 1
          
        End Select
        
      Next
      
    Next
    

    Fmt.Dbg "The answer to Day {0} part 1 is {1} (Test is {2}).  Found is {3}", VBA.Mid$(InputData, 4, 2), "532", 26, myCount
    
  End Sub
  
  Public Sub Part02()
    
    
    Dim myCost As Long
    Fmt.Dbg "The answer to Day {0} part 2 is {1} (Test is {2}).  Found is {3}", VBA.Mid$(InputData, 4, 2), "xxxx", "xxxx", myCost
    
  End Sub
  
  
  Private Sub DeleteSegment(ByRef ipLyst As Lyst, ByVal ipSegment As String)
    
      Dim myIndex As Long
      For myIndex = 1 To ipLyst.LastIndex
        
        ipLyst.Item [myIndex] = VBA.Replace(ipLyst.Item(myIndex), ipSegment, vbNullString)
        
        
      Next
      
      Stop
    
  End Sub
  
  Private Function GetOddSegment(ByVal ipReading1 As String, ByVal ipreading2 As String) As String
    
    Dim myIndex As Long
    For myIndex = 1 To VBA.Len(ipReading1)
      
      If VBA.InStr(ipreading2, VBA.Mid$(ipReading1, myIndex, 1)) = 0 Then
        
        GetOddSegment = VBA.Mid$(ipReading1, myIndex, 1)
        Exit Function
        
        
      End If
      
    Next
    
    Stop
    
  End Function
  
  Private Function GetSingleSegment(ByRef ipLyst As Lyst) As String
    
    Dim myItem As Variant
    For Each myItem In ipLyst
      
      If VBA.Len(myItem) = 1 Then
        
        GetSingleSegment = VBA.CStr(myItem)
        Exit Function
        
        
      End If
    
    Next
    
    Stop
    
  End Function
  
  Private Function GetMostCommon(ByRef ipLyst As Lyst) As String
    
    
    
    
  End Function

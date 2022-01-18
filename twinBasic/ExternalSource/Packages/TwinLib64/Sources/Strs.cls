VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Strs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib")
        
Private Type Properties
        
    Separator               As String
    Nums                    As ROL
    Upper                   As ROL
    Lower                   As ROL
    Alphanum                As ROL
    WhiteSpace              As ROL
    
End Type

Private p                   As Properties

Private Sub Class_Initialize()
  
    p.Separator = Char.twComma
    Set p.WhiteSpace = ROL.Deb(ToCharLyst(WhiteSpaceChars).ToArrayList)
    Set p.Nums = ROL.Deb(ToCharLyst(NumberChars).ToArrayList)
    Set p.Upper = ROL.Deb(ToCharLyst(UCaseChars).ToArrayList)
    Set p.Lower = ROL.Deb(ToCharLyst(LCaseChars).ToArrayList)
    Set p.Alphanum = ROL.Deb(ToCharLyst(AlphanumChars).ToArrayList)
    
End Sub

Public Function WhiteSpaceChars() As String: WhiteSpaceChars = Char.twSpace & Char.twPeriod & Char.twSemiColon & Char.twColon & Char.twComma & vbTab & vbCrLf: End Function
Public Function WhitespaceList() As ROL: Set WhitespaceList = p.WhiteSpace: End Function
  
Public Function NumberChars() As Variant: NumberChars = "0123456789": End Function
Public Function LCaseChars() As Variant: LCaseChars = "abcdefghijklmnopqrstuvwxyz": End Function
Public Function UCaseChars() As Variant: UCaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ": End Function
Public Function AlphanumChars() As Variant: AlphanumChars = NumberChars & UCaseChars & LCaseChars: End Function
 
Public Function NumbersList() As ROL: Set NumbersList = p.Nums: End Function
Public Function LCaseList() As ROL: Set LCaseList = p.Lower: End Function
Public Function UCaseList() As ROL: Set UCaseList = p.Upper: End Function
Public Function AlphaNumRoc() As ROL: Set AlphaNumRoc = p.Alphanum: End Function
  
' Friend Function TryExtent(ByVal ipItem As String) As Result
        
    
        
'     Set TryExtent = Globals.Res.Init(Msg.Okay).SetItems(1, myCount, myCount)
     
' End Function

Public Function TryExtent(ByVal ipString As String, Optional ByVal ipRank As Long = 1) As Result
  
    Globals.Res.SetNotOkay
    Set TryExtent = Globals.Res
    
    If BailOut.When(ipRank <> 1, Msg.ItemDoesNotSupportRanks) Then Exit Function
        
    Dim myCount As Long
    myCount = VBA.Len(ipString)
    If BailOut.When(myCount = 0, Msg.StringIsEmpty) Then Exit Function
    
    Set TryExtent = Globals.Res.SetOkay.SetItems(1, myCount, myCount)
  
End Function

'@Description("Return the long value of a string containing a binary number")
Public Function BinToLong(ByVal ipBinary As String) As Long
Attribute BinToLong.VB_Description = "Return the long value of a string containing a binary number"

        
    Dim myValue As Long
    myValue = 0
    Dim myIndex As Long
    For myIndex = Len(ipBinary) To 1 Step -1
        
        Dim myChar As String
        myChar = VBA.Mid$(ipBinary, myIndex, 1)
        
        If myChar = "1" Then
            
            myValue = myValue + 2 ^ (Len(ipBinary) - myIndex)
                
        End If
            
    Next
        
    BinToLong = myValue
        
End Function

' Public Function dedup(ByVal ipsource As String, ByRef ipDedupChars As Scripting.Dictionary) As String
        
' End Function
' Public Function dedup(ByVal ipsource As String, ByRef ipDedupChars As ArrayList) As String
        
' End Function
    
' Public Function Dedup(ByVal ipsource As String, ByRef ipDedupArray As Collection) As String
    
        
' 'End Function
    
Public Property Get DefaultSeparator() As String
    DefaultSeparator = p.Separator
End Property

Public Property Let DefaultSeparator(ByVal ipSeparator As String)
    p.Separator = ipSeparator
End Property

Public Function Dedup(ByVal ipSource As String, ParamArray ipDedupItems() As Variant) As String

    Dedup = ipSource
    If BailOut.When(VBA.Len(ipSource) = 0, Msg.StringIsEmpty) Then Exit Function
        
    Dim myDedupItems As Lyst
    If Arrays.IsNotValid(ipDedupItems) Then
        
        Set myDedupItems = Lyst.Deb.AddKnownItemsAsItems(Char.twSpace)
        
    ElseIf Arrays.HasOneItem(ipDedupItems) Then
        
        If Types.Group.IsIterable(ipDedupItems(0)) Then
            
            Set myDedupItems = Lyst.Deb.AddKnownIterableAsItems(ipDedupItems(0))
            
        Else
            
            Set myDedupItems = Lyst.Deb.AddKnownIterableAsItems(ipDedupItems)
            
        End If
        
    Else
        
        Set myDedupItems = Lyst.Deb.AddKnownIterableAsItems(ipDedupItems)
        
    End If
        
    Dim mySource As String
    mySource = ipSource
       
    Dim myDeDup As Variant
    For Each myDeDup In myDedupItems
        
        If Types.IsString(myDeDup) Then
            
            Dim MyDedupDedup As String
            MyDedupDedup = myDeDup & myDeDup
                
            Do
            
                DoEvents
                Dim myLen As Long
                myLen = Len(mySource)
                mySource = Replace(mySource, MyDedupDedup, myDeDup)
                    
            Loop Until myLen = Len(mySource)
            
        End If
            
    Next
        
    Dedup = mySource
        
End Function

'@Description("Takes a list of characters and removes them from both ends of the target string.  If the list contains strings >1 character then these are ignored")
Public Function Trimmer(ByVal ipSource As String, ParamArray ipTrimChars() As Variant) As String
Attribute Trimmer.VB_Description = "Takes a list of characters and removes them from both ends of the target string.  If the list contains strings >1 character then these are ignored"

    Trimmer = ipSource
    If VBA.Len(ipSource) = 0 Then Exit Function
    
      Dim mywhite As Variant
      Set mywhite = Strs.WhitespaceList '.ToArray
    If Arrays.HasNoItems(ipTrimChars) Then ipTrimChars = mywhite.ToArray
        
    Dim myTrimArray As Variant
    If Arrays.HasOneItem(ipTrimChars) Then
        
        'Dim myResult As Result
        If Parser.ParseVariantWithOneItem(ipTrimChars(0)).IsNotOkay Then Exit Function
        myTrimArray = Globals.Res.Item(ResultItemsEnums.ParsedVariant(pvItems))
            
    Else
            
        myTrimArray = ipTrimChars
            
    End If
        
    Dim myTrimLyst As Lyst
    Set myTrimLyst = Lyst.Deb.AddKnownIterableAsItems(myTrimArray)
    Dim myString As String
    myString = ipSource
      
    Dim myLen As Long
    Do
  
      DoEvents  'Always put a do event statement in a do loop
      myLen = VBA.Len(myString)
      If myTrimLyst.HoldsItem(VBA.Left$(myString, 1)) Then myString = VBA.Mid$(myString, 2)
       
                
    Loop Until myLen = VBA.Len(myString)
         
    Do
        
      DoEvents                                 ' Always put a do event statement in a do loop
      myLen = VBA.Len(myString)
      If myTrimLyst.HoldsItem(VBA.Right$(myString, 1)) Then myString = VBA.Mid$(myString, 1, myLen - 1)

            
    Loop Until myLen = VBA.Len(myString)
            
    Trimmer = myString
        
End Function

Public Function PadLeft(ByVal ipString As String, ByVal ipWidth As Long) As String

    PadLeft = ipString
    If Len(ipString) >= ipWidth Then Exit Function
        
    Dim myReturn As String
    myReturn = VBA.String$(ipWidth, Char.twSpace)
    LSet myReturn = ipString
    PadLeft = myReturn
        
End Function

Public Function PadRight(ByVal ipString As String, ByVal ipWidth As Long, Optional ByVal ipChar As String = " ") As String
    PadRight = ipString
    If Len(ipString) >= ipWidth Then Exit Function
        
    Dim myReturn As String
    myReturn = String$(ipWidth, ipChar)
    RSet myReturn = ipString
    PadRight = myReturn
        
End Function

Public Function Count(ByVal ipString As String, ByVal ipChar As String) As Long
    Count = Len(ipString) - Len(Replace(ipString, ipChar, vbNullString))
End Function

'Public Function NullStrArr(ByVal ipCount As Long) As Variant
'
'    'Dim myKvp As Kvp
'    ' vbNullString gives an EMpty variant, "" gives ""
'    '@Ignore EmptyStringLiteral
'    NullStrArr = Kvp.Deb.Add("", ipCount).GetValues
'
'End Function


'@Description("Takes string in the form of X,Y and returns array containing X Long, Y Long")
Public Function CoordsToXY(ByVal ipCoord As String) As Variant
Attribute CoordsToXY.VB_Description = "Takes string in the form of X,Y and returns array containing X Long, Y Long"
    CoordsToXY = Array(CLng(Split(ipCoord, ",")(0)), CLng(Split(ipCoord, ",")(1)))
End Function

'@Description("Converts a string to an Lyst of trimmed substrings")
Public Function ToSubStrLyst(ByVal ipString As String, Optional ByVal ipSeparator_twComma As Variant, Optional ByVal ipDeleteChars_WhiteSpace As Variant) As Lyst
Attribute ToSubStrLyst.VB_Description = "Converts a string to an Lyst of trimmed substrings"

    Dim myArray As Variant
    Dim myString As String
    ipSeparator_twComma = IIf(VBA.IsMissing(ipSeparator_twComma), Char.twComma, ipSeparator_twComma)
    ipDeleteChars_WhiteSpace = IIf(VBA.IsMissing(ipDeleteChars_WhiteSpace), Strs.WhiteSpaceChars, ipDeleteChars_WhiteSpace)
        
    myString = Strs.Trimmer(ipString, ipDeleteChars_WhiteSpace)
    If InStr(myString, ipSeparator_twComma) = 0 Then
            
        myArray = Array(myString)
            
    Else
            
        myArray = VBA.Split(myString, ipSeparator_twComma)
            
    End If
        
    Dim myitem As Variant
    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    For Each myitem In myArray
        
        myLyst.Add myitem
            
    Next

    Set ToSubStrLyst = myLyst
        
End Function

Public Function RepeatReplacer(ByVal ipHost As String, Optional ByVal ipFind As Variant, Optional ByVal ipReplace As Variant) As String
    
    RepeatReplacer = ipHost
    If VBA.Len(ipHost) = 0 Then Exit Function
    If VBA.IsMissing(ipFind) Then ipFind = Char.twSpace
    If VBA.IsMissing(ipReplace) Then ipReplace = vbNullString
        
    Dim myFind As String
    Dim myReplace As String
    
    If Types.IsNotString(ipFind) Then
        
        myFind = Stringifier.ToString(ipFind)
        
        
    Else
        
        myFind = ipFind
        
        
    End If
       
    If Types.IsNotString(ipReplace) Then
        
        myReplace = Stringifier.ToString(ipReplace)
        
        
    Else
        
        myReplace = ipReplace
        
        
    End If
    
    Do
    
        DoEvents
        
        Dim myLen As Long
        myLen = VBA.Len(ipHost)
        ipHost = VBA.Replace(ipHost, myFind, myReplace)
        
        
    Loop While myLen > VBA.Len(ipHost)

    RepeatReplacer = ipHost
        
End Function



'@dewcription("Takes an array of find/replace pairs  an repeat replaces each pair.  Default for ipFindReplaceItems is Array(array(" ",vbnullstring))")
Public Function MultiReplacer(ByVal ipHost As String, Optional ByVal ipFindReplaceItems As Variant) As String
    
    MultiReplacer = ipHost
    If BailOut.When(VBA.Len(ipHost) = 0, Msg.StringIsEmpty) Then Exit Function

    'Dim myFindReplaceItems As Variant
    If VBA.IsMissing(ipFindReplaceItems) Then
        
        ipFindReplaceItems = Array(Array(Char.twSpace, vbNullString))
        
    ElseIf Arrays.HasNoItems(ipFindReplaceItems) Then
        
        ipFindReplaceItems = Array(Array(Char.twSpace, vbNullString))
        
    End If
        
    Dim myFindReplaceArray As Variant
    For Each myFindReplaceArray In ipFindReplaceItems
        
        ipHost = RepeatReplacer(ipHost, myFindReplaceArray(0), myFindReplaceArray(1))
        
    Next
    
    MultiReplacer = ipHost
    
End Function

Public Function ToAnsiBytes(ByVal ipString As String) As Lyst

    If VBA.Len(ipString) = 0 Then
        
        Set ToAnsiBytes = Lyst.Deb
            
    Else
        
        Set ToAnsiBytes = Lyst.Deb.AddKnownIterableAsItems(VBA.Split(StrConv(ipString, vbFromUnicode)))
            
    End If
        
End Function

Public Function ToUnicodeBytes(ByVal ipString As String) As Lyst

    If VBA.Len(ipString) = 0 Then
        
        Set ToUnicodeBytes = Lyst.Deb
            
    Else
        
        Dim myBytes() As Byte
        myBytes = ipString
        Set ToUnicodeBytes = Lyst.Deb.AddKnownIterableAsItems(myBytes)
            
    End If
        
End Function

Public Function ToCharLyst(ByVal ipString As String) As Lyst

    Dim myLyst As Lyst
    Set myLyst = Lyst.Deb
    Set ToCharLyst = myLyst
        
    Dim myLen As Long
    myLen = VBA.Len(ipString)
    If myLen = 0 Then Exit Function
     
   
    Dim myIndex As Long
    For myIndex = 1 To myLen
        
        myLyst.AddKnownItemsAsItems VBA.Mid$(ipString, myIndex, 1)
            
    Next
        
    Set ToCharLyst = myLyst

End Function
'@Description("increments characters based on thier position in the ipAllowedChar list")
Public Function Inc(ByVal ipString As String, Optional ByRef ipAllowedChar As ROL) As String
Attribute Inc.VB_Description = "increments characters based on thier position in the ipAllowedChar list"
  
  If VBA.Len(ipString) = 0 Then
    
      Inc = vbNullString
      Exit Function
      
  End If
  
  Dim myAllowedChar As ROL
  If ipAllowedChar Is Nothing Then
    
    Set myAllowedChar = p.Alphanum
      
  ElseIf ipAllowedChar.HasNoItems Then
    
    Set myAllowedChar = p.Alphanum
    
  Else
    
    Set myAllowedChar = ipAllowedChar
    
  End If
  
  
  Dim myChars As Lyst
  Set myChars = Strs.ToCharLyst(ipString)
  
  Dim myIndex As Long
  myIndex = myChars.LastIndex
  Dim myChar As String
  Dim myCarryFlag As Boolean
  myCarryFlag = False
  Do
  
    DoEvents
    
    If myIndex = 0 And myCarryFlag Then
      
      myChars.InsertAt myChars.FirstIndex, myAllowedChar.Item(myAllowedChar.FirstIndex + 1)
      Inc = myChars.ToString
      Exit Function
      
      
    Else
    
        myChar = IncChar(myChars.Item(myIndex), myAllowedChar)
    
    
    End If
    
    Select Case VBA.Len(myChar)
      
      Case 1
      
        If myChar <> myChars.Item(myIndex) Then
          ' the character was incremented so replace in mychars
          myChars.Item(myIndex) = myChar
          Inc = myChars.ToString
          Exit Function
          
          
        Else
          ' the character is the same so we can exit
          ' but first check for carry status
          
          If myCarryFlag Then
            
            ' we had a rollover before finding a character we couldn't increment so we need to
            ' insert the character of allowedchars.firstindex +1
            
            myChars.InsertAt myIndex + 1, myAllowedChar.Item(myAllowedChar.FirstIndex + 1)
            Inc = myChars.ToString
            Exit Function
            
            
          End If
          
        End If
      
      
      Case 2
        ' if two chars are returned a rollover has occurred
        myChars.Item(myIndex) = VBA.Left$(myChar, 1)
        myIndex = myIndex - 1
        myCarryFlag = True
      
    End Select
    ' If VBA.Left$(myChar, 1) = myChars.Item(myIndex) Then
    '   ' if the character is unchanged we can exit the loop
    '   ' but if the carry flag is true we firt also need to
    '   ' insert a character after location myindex
      
    '   'e.g. "\zzzz" would become "\10000"
      
    '   If myCarryFlag Then
        
    '     myChars.InsertAt myIndex + 1, myAllowedChar.Item(myAllowedChar.FirstIndex + 1)
    '     Exit Do
        
    '   End If
      
    ' End If
    
    ' If VBA.Len(myChar) = 1 Then
    '   ' if only one character is returned no rollover occured
    '   ' so we can update mychars and exit the loop
    '   myChars.Item(myIndex) = myChar
    '   Exit Do
      
    ' End If
    
    ' 'A rollover occurred so we need to update mychars
    ' ' and continue incrementing
    
    ' myChars.Item(myIndex) = VBA.Left$(myChar, 1)
    ' myIndex = myIndex - 1
    ' myCarryFlag = True
    
  Loop
  
  Inc = myChars.ToString
  
End Function


Friend Function IncChar(ByVal ipChar As String, ByRef ipAllowedChars As ROL) As String
  
  IncChar = ipChar
  If ipAllowedChars.LacksItem(ipChar) Then Exit Function
    
  Dim myCharIndex As Long
  myCharIndex = ipAllowedChars.IndexOf(ipChar)
  If myCharIndex = ipAllowedChars.LastIndex Then
    
    ' if the returned character string has two chars this indicated
    ' that a rollover has occurred and only the first character needs to be
    ' used for further processing
    IncChar = ipAllowedChars.Item(ipAllowedChars.FirstIndex) & Char.twHash
    
  Else
    
    IncChar = ipAllowedChars.Item(myCharIndex + 1)
    
  End If
    
End Function

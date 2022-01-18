VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ROL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
' ========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
' ========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
 
' Preamble
'
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'
' ReadOnlyList is a wrapped arraylist which does not provide a property set for the items method

'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
'@PredeclaredId
'@Exposed
'@Folder("Collections")

Private Type State
  
  Items                     As ArrayList
  
End Type

Private s                   As State

Public Function Deb(ByVal ipIterable As Variant) As ROL
  
  With New ROL
  
    Set Deb = .ReadyToUseInstance(ipIterable)
  
  End With
  
End Function


Friend Function ReadyToUseInstance(ByVal ipIterable As Variant) As ROL
  
  If Types.IsTypeByName(Types.Name.OfArrayList, ipIterable) Then
    
    Set s.Items = ipIterable
    
If Types.IsTypeByName(Array(Types.Name.OfLyst, Types.Name.OfROL), ipIterable) Then
    Set s.Items = ipIterable.toarraylist
End If
    
  ElseIf Types.IsString(ipIterable) Then
    
    Set s.Items = Strs.ToCharLyst(ipIterable).Deduplicate.ToArrayList
    
    
  Else
  
    Set s.Items = Types.Iterable.ToArrayList(ipIterable)
  
    
  End If
  
  Set ReadyToUseInstance = Me
  
End Function


Public Property Get Count() As Long
  If s.Items Is Nothing Then Debug.Print "Items in ROC is nothing"
  Count = s.Items.Count
End Property


Public Function FirstIndex() As Long
  FirstIndex = 1
End Function

Public Function LastIndex() As Long
  
  If s.Items.Count = 0 Then
    
    LastIndex = -1
    
    
  Else
    
    LastIndex = s.Items.Count
    
    
  End If
  
End Function


Public Function HasNoItems() As Boolean
  HasNoItems = s.Items.Count = 0
End Function

Public Function HasItems() As Boolean
  HasItems = s.Items.Count > 0
End Function

Public Function HoldsItem(ByVal ipItem As Variant) As Boolean
  
  If VBA.IsEmpty(ipItem) Then
    
    HoldsItem = False
    
  Else
  
    HoldsItem = s.Items.Contains(ipItem)
  
  End If
  
End Function


Public Function LacksItem(ByVal ipItem As Variant) As Boolean
  LacksItem = Not HoldsItem(ipItem)
End Function


Public Property Get Item(ByVal ipIndex As Long) As Variant
  
  If ipIndex < 1 Or ipIndex > s.Items.Count Then
    
    Item = Null
    
  Else
    
    Item = s.Items.Item(ipIndex - 1)
    
  End If
  
End Property

Public Function IndexOf(ByVal ipChar As String) As Long
  
  If Not s.Items.Contains(VBA.Left$(ipChar, 1)) Then
    
    IndexOf = -1
  
    
  Else
    
    IndexOf = s.Items.IndexOf(VBA.Left$(ipChar, 1), Nothing) + 1
    
    
  End If
   
End Function

Public Function ToArray() As Variant
  ToArray = s.Items.ToArray
End Function

Public Function ToArrayList() As ArrayList
  Set ToArrayList = s.Items.Clone
End Function

Public Function ToLyst() As Lyst
  Set ToLyst = Lyst.Deb.AddRange(s.Items.Clone)
End Function

Public Function ToString() As String
  ToString = VBA.Join(s.Items.ToArray, vbNullString)
End Function

'@Enumerator
Private Function NewEnum() As IUnknown
        
    Dim enumerator As IEnumVARIANT
    '@Ignore DefaultMemberRequired
    Set enumerator = s.Items.GetEnumerator(0, s.Items.Count)
    Set NewEnum = enumerator
      
End Function

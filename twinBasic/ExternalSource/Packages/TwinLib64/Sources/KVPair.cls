VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "KVPair"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "A simple single item dictionary"
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========C
' Code line limit should be 120 characters.
' Comment line limit should be 80 characters
'========1=========2=========3=========4=========5=========6=========7=========8=========9=========A=========B=========COption Explicit
'@Moduledescription("A simple single item dictionary")
' Originally this class was implemented to emulate a tuple.  However it was an
' oddity when trying to triage a paramarray and consequently it was transformed
' into a single item dictionary so that it could be treated a member of the
' IterableKeysByEnum.
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("Kvp")

Private Type Properties

    Key                                 As ArrayList
    Item                                As ArrayList
        
End Type

Private p               As Properties

Public Function Deb(Optional ByVal ipKVPairOrKey As Variant = Empty, Optional ByVal ipItem As Variant = Empty) As KVPair
        
        
    With New KVPair
    
        Set Deb = .ReadyToUseInstance(ipKVPairOrKey, ipItem)
    
    
    End With
        
End Function
 
Friend Function ReadyToUseInstance(ByVal ipKVPairOrKey As Variant, ByVal ipItem As Variant) As KVPair

    Set p.Key = New ArrayList
    Set p.Item = New ArrayList
    If Types.IsKVPair(ipKVPairOrKey) Then

        p.Key.Add ipKVPairOrKey.Key
        p.Item.Add ipKVPairOrKey.Item
        Exit Function
        
        
    ElseIf Types.IsNotMissing(ipItem) And Types.IsNotKVPair(ipKVPairOrKey) Then
        
        p.Key.Add ipKVPairOrKey
        p.Item.Add ipItem
        
        
    End If
        
    Set ReadyToUseInstance = Me
    
End Function

Public Property Get Key() As Variant
    Key = p.Key.Item(0)
End Property

Public Property Let Key(ByVal ipKey As Variant)
    p.Key.Item(0) = ipKey
End Property

Public Property Get Item() As Variant
    If VBA.IsObject(p.Item.item(0)) Then
        
        Set Item = p.Item.Item(0)
   
    Else
        
        Item = p.Item.item(0)
        
    End If
End Property

Public Property Let Item(ByVal ipItem As Variant)

    If VBA.IsObject(ipItem) Then
        
        Set p.Item.Item(0) = ipItem
            
        
    Else
        
        p.Item.Item(0) = ipItem
        
        
        
    End If
        
End Property

Public Function ToString(Optional ByVal ipSeparator As Variant) As String
    If VBA.IsMissing(ipSeparator) Then ipSeparator = Char.twComma
        'Debug.Print ipSeparator, p.Key.Item(0), p.Item.Item(0)
    ToString = Fmt.Txt("{1}{0}{2}", ipSeparator, p.Key.Item(0), p.Item.Item(0))
End Function

'@DefaultMember
Public Function Name() As String
Attribute Name.VB_UserMemId = 0
    Name = TypeName(Me)
End Function

'This may seem stupid but a KVPair can be treated as a single item dictionary
' So to conform with other dictionary type we implement Keys and Items functions

Public Function Keys() As Variant
    Set Keys = p.Key.ToArray
End Function

Public Function Items() As Variant
    Set Items = p.Item.ToArray
End Function

'@Enumerator
Public Function NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4

    Dim enumerator As IUnknown
    '@Ignore DefaultMemberRequired
    Set enumerator = p.Key.GetEnumerator(0, p.Key.Count)
    Set NewEnum = enumerator

End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ResultItemsEnums"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Attribute VB_Description = "This module holds enumerations that give the indexing for the items lyst in a Result objects"
Option Explicit
'@Exposed
'@PredeclaredId
'@Folder("VBALib")
'@ModuleDescription("This module holds enumerations that give the indexing for the items lyst in a Result objects")

' We'd prefer enums to not use prefixes but unfortunately these are required in VBA
' to prevent name clashes between enums members.
' Also need to remeber that Items is an Arraylist as the Lyst class cannot
' be used to to neverending recursion
Public Enum ItemExtent
' item 0 is the parameter count
   
    ieFirstIndex = 0
    ieLbound = 0
    ieLastIndex = 1
    ieUbound = 1
    ieCount = 2
        
End Enum

Public Enum StartRun
        
    srStartindex = 0
    srRunLength = 1
        
End Enum

Public Enum ParsedVariant
        
    pvItems = 0
    pvKeys = 1
        
End Enum

Public Enum SameSize
    ssRefItem = 0
    ssTestItem = 1
    
End Enum

' Funtions below allow intellisense for the enums above
Public Function ItemExtent(ByVal ipItemExtent As ItemExtent) As ItemExtent
    ItemExtent = ipItemExtent
End Function

Public Function StartRun(ByVal ipStartRun As StartRun) As StartRun
    StartRun = ipStartRun
End Function

Public Function ParsedVariant(ByVal ipParseResult As ParsedVariant) As ParsedVariant
    ParsedVariant = ipParseResult
End Function


Public Function SameSize(ByVal ipSameSizeEnum As SameSize) As SameSize
    SameSize = ipSameSizeEnum
End Function

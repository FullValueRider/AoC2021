VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpToType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib.Mappers")
'ModuleDescription("Mapper to allow converion between types ... mostly")
Implements IMapper

Public Enum ToType
  
  ToByte = vbByte
  ToCurrency = vbCurrency
  ToDate = vbDate
  ToDecimal = vbDecimal
  ToDouble = vbDouble
  ToInteger = vbInteger
  ToLong = vbLong
  ToLongLong = vbLongLong
  ToLongPtr = ToLongLong
  ToSingle = vbSingle
  ToString = vbString
  ToHexStr
  ToOctStr
  ToBinStr
  
End Enum

Private Type State
  
    Conversion                    As ToType
    
    
End Type

Private s                         As State

'TwinBasic requirement
Private Sub Class_Initialize()
End Sub

Public Function Deb(ByVal ipType As ToType) As mpToType
        
    With New mpToType
        
        Set Deb = .ReadyToUseInstance(ipType)
            
    End With
        
End Function

Friend Function ReadyToUseInstance(ByVal ipType As ToType) As mpToType
    
    s.Conversion = ipType
    Set ReadyToUseInstance = Me
        
End Function

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function

'@Description("Converts tthe items in the Lyst to Long Integers.  If the input item cannot be converted the string "NaN" is returned")
Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
        
 Select Case s.Conversion
    
    Case ToHexStr: ExecMapper = Hex$(ipHostItem)
    Case ToOctStr: ExecMapper = Oct$(ipHostItem)
    Case ToLongPtr: ExecMapper = CLngPtr(ipHostItem)
    Case Else
    
      ExecMapper = Types.ToVarTypePrimitive(s.Conversion, ipHostItem)
      
  End Select
      
End Function

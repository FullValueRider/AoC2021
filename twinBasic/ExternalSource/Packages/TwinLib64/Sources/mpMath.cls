VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "mpMath"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib.Mappers")
    
Implements IMapper

Public Enum Fx
  
  vbAbs
  Atn
  Atn2
  Ceil
  Cos
  Exp
  Factorial
  Floor
  IsPrime
  Ln
  Log
  Rnd
  TriangularNumber
  Power
  Round
  vbSgn
  Sin
  Root
  Tan
  
End Enum
'TwinBasic requirement

Private Type State
  
  Function                      As Fx
  OptionalParam                 As Variant
  
  
End Type

Private s                     As State


'@Description("Applies the specified function. Check with the equivalent VBA function to determine if the option argument should be used")
Public Function Deb(ByVal ipFx As Fx, Optional ByVal ipOptionalParam As Variant = 0) As mpMath
Attribute Deb.VB_Description = "Applies the specified function. Check with the equivalent VBA function to determine if the option argument should be used"
        
    With New mpMath
        
        Set Deb = .ReadyToUseInstance(ipFx, ipOptionalParam)
            
    End With
        
End Function

Friend Function ReadyToUseInstance(ByVal ipFx As Fx, ByVal ipOptionalParam As Variant) As mpMath
  
    s.OptionalParam = ipOptionalParam
    s.Function = ipFx
    Set ReadyToUseInstance = Me
        
End Function

Private Function IMapper_ExecMapper(ByVal ipHostItem As Variant) As Variant
    IMapper_ExecMapper = ExecMapper(ipHostItem)
End Function


Public Function ExecMapper(ByVal ipHostItem As Variant) As Variant
     
  Select Case s.Function
    
    Case vbAbs: ExecMapper = VBA.Abs(ipHostItem)
    Case Atn: ExecMapper = VBA.Atn(ipHostItem)
    Case Cos: ExecMapper = VBA.Cos(ipHostItem)
    Case Exp: ExecMapper = VBA.Exp(ipHostItem)
    Case Round: ExecMapper = VBA.Round(ipHostItem, s.OptionalParam)
    Case Power: ExecMapper = ipHostItem ^ s.OptionalParam
    Case vbSgn: ExecMapper = VBA.Sgn(ipHostItem)
    Case Sin: ExecMapper = VBA.Sin(ipHostItem)
    Case Tan: ExecMapper = VBA.Tan(ipHostItem)
    
    ' Function defined, or redefined, in Class Maths
    Case Root: ExecMapper = ipHostItem ^ (1 / s.OptionalParam)
    Case IsPrime: ExecMapper = Maths.IsPrime(ipHostItem)
    Case Factorial: ExecMapper = Maths.Factorial(ipHostItem)
    Case Ln: ExecMapper = Maths.Ln(ipHostItem)
    Case Log: ExecMapper = Maths.Log(ipHostItem)
    Case TriangularNumber: ExecMapper = Maths.TriangularNumber(ipHostItem, 1)
    
    
  End Select
        
End Function

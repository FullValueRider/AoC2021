VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "BailOut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'@PredeclaredId
'@Exposed
'@Folder("VBALib.Filters")


' Guard statements
' Guard statements imply allowing execution to continue if the test is true
' This is incompatible with a global result value because we wish to say
' the result is NOTOKAY when the test is true
' for this reason the exit when class decouples setting the result
' from the return value and so we can just return a simple
' boolean
Private Sub Class_Initialize()
End Sub

Public Function When(ByVal ipBailOut As Boolean, Optional ByVal ipMsg As Msg = Msg.Unspecified, Optional ByRef ipMsgArgsLyst As Lyst, Optional ByVal ipAltMessage As String) As Boolean
    
    ' because we wish 'When' to be true to facilitate bailing out,
    ' globals.res.status MUST be reversed.
    If ipBailOut Then
        
        SetGlobalResNotOkay ipMsg, ipMsgArgsLyst, ipAltMessage
        When = True
        
    Else
        
        'Globals.Res.SetOkay
        When = False
        
    End If
    
End Function


Friend Sub SetGlobalResNotOkay _
( _
    ByVal ipMessageEnum As Msg, _
    Optional ByVal ipArgLyst As Lyst, _
    Optional ByVal ipAltMessage As String _
)
    
    Dim myMessage As String
    If VBA.Len(ipAltMessage) = 0 Then
        
        myMessage = enums.Message.ToString(ipMessageEnum)
            
        
    Else
            
        myMessage = ipAltMessage
            
        
    End If
    
    Dim myargs As Variant
    If ipArgLyst Is Nothing Then
        
        myargs = Array()
        
    Else
        
        myargs = ipArgLyst.ToArray
        
    End If
        
    
    
    Dim myErrorText As String
    myErrorText = Fmt.TxtArr(myMessage, myargs)
    Globals.Res.SetText myErrorText
    Globals.Res.SetNotOkay
    
End Sub

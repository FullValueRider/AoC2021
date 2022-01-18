VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "rdSum"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
 Option Explicit
 '@PredeclaredId
 '@Exposed
 '@Folder("VBALib.Filters")
Implements IReduce

Private Type State

    Comparer                        As IComparer


End Type

Private s                           As State


Public Function Deb(Optional ByRef ipComparer As IComparer) As rdSum

    With New rdSum

        Set Deb = .ReadyToUseInstance(ipComparer)

    End With

End Function

Friend Function ReadyToUseInstance(ByRef ipComparer As IComparer) As rdSum

    If Not (IComparer Is Nothing) Then
      
        Set s.Comparer = ipComparer
        
    End If
    
    Set ReadyToUseInstance = Me

End Function

'@Description("Adds the value in ipArgsArray(0) to each item in the Lyst.  If the host item is not a number the string NAN is returned")
Private Function IReduce_ExecRed(ByRef ipHostItems As Lyst) As Variant
Attribute IReduce_ExecRed.VB_Description = "Adds the value in ipArgsArray(0) to each item in the Lyst.  If the host item is not a number the string NAN is returned"
    IReduce_ExecRed = ExecRed(ipHostItems)
End Function

Public Function ExecRed(ByRef ipHostItems As Lyst) As Variant

  Dim mySum As LongLong
  mySum = 0
   Dim myitem As Variant
   For Each myitem In ipHostItems

        If s.Comparer Is Nothing Then
          
          mySum = mySum + myitem
          
        Else
          
          If s.Comparer.ExecCmp(myitem) Then mySum = mySum + myitem
            
        End If

   Next

   ExecRed = mySum

End Function
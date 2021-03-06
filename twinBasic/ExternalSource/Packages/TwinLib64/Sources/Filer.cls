VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Filer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
'@Folder("Helpers")
Option Explicit
'@PredeclaredId
'@Exposed

Public Function GetFileAsArrayOfStrings(ByVal ipFilePath As String, Optional ByRef ipSplitAtToken As String = vbCrLf) As Variant

    Dim myFso  As Scripting.FileSystemObject
    Set myFso = New Scripting.FileSystemObject
        
    Dim myfile As TextStream
    Set myfile = myFso.OpenTextFile(ipFilePath, Scripting.IOMode.ForReading)
            
    GetFileAsArrayOfStrings = VBA.Split(myfile.ReadAll, ipSplitAtToken)
        
    myfile.Close
        
End Function

Public Function GetFileAsString(ByVal ipPath As String) As String

    Dim myFso  As Scripting.FileSystemObject
    Set myFso = New Scripting.FileSystemObject
    Dim myfile As TextStream
    Set myfile = myFso.OpenTextFile(ipPath, Scripting.IOMode.ForReading)
        
        
    GetFileAsString = myfile.ReadAll

    myfile.Close
        
End Function

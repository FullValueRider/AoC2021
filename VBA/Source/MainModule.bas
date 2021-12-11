Attribute VB_Name = "MainModule"
Option Explicit

Public Const AoC2021Data As String = "C:\Users\slayc\source\repos\AoC2021\RawData\"

' This project type is set to 'Standard EXE' in the Settings file, so you need a Main() subroutine to run when the EXE is started.
Public Sub Main()
    
    Dim myDay As Object
    Set myDay = New DDay01
    myDay.Execute
    Set myDay = New DDay02
    myDay.Execute
    Set myDay = New DDay03
    myDay.Execute
    
End Sub

Attribute VB_Name = "calldirect"
Option Explicit

        Dim returnValue
        
         Declare Function AcuInitialize Lib "wrun32.dll" _
            (Optional ByVal cmdLine As String) As Integer
      
         Declare Sub AcuShutdown Lib "wrun32.dll" ()
      
         Declare Function AcuCall Lib "wrun32.dll" _
            (ByVal name As String, _
              Optional param1, _
              Optional param2, _
              Optional param3, _
              Optional param4, _
              Optional param5, _
              Optional param6, _
              Optional param7, _
              Optional param8, _
              Optional param9, _
              Optional param10, _
              Optional param11, _
              Optional param12, _
              Optional param13, _
              Optional param14) As Integer
      
         Declare Function AcuGetCallError Lib "wrun32.dll" () As Integer
         Declare Sub AcuCancel Lib "wrun32.dll" (ByVal name As String)

Sub main()
    frmMainWindow.Show
    
End Sub

Sub MyCallError()

    Dim strErrorMsg As String
    
    ' You are here since AcuCall did not return 0, use AcuGetCallError to find
    ' out what the problem is:
    Select Case AcuGetCallError()
        Case -4
            strErrorMsg = "AcuCall has been called in multiple threads"
        Case -3
            strErrorMsg = "AcuInitialize failed." + _
                    "(AcuInitialize cannot be called after AcuShutdown in a single process.)"
        Case 1
            strErrorMsg = "Program missing or inaccessible"
        Case 2
            strErrorMsg = "Not a COBOL program"
        Case 3
            strErrorMsg = "Corrupted program"
        Case 4
            strErrorMsg = "Inadequate memory available"
        Case 5
            strErrorMsg = "Unsupported version of object code"
        Case 6
            strErrorMsg = "Program already in use"
        Case 7
            strErrorMsg = "Too many external segments"
        Case 25
            strErrorMsg = "Connection refused - perhaps AcuConnect is not running"
        Case 27
            strErrorMsg = "Program contains object code for a different processor"
        Case 28
            strErrorMsg = "Incorrect serial number"
        Case 30
            strErrorMsg = "License error"
        Case Else
            strErrorMsg = "Unknown call failed error"
    End Select
    returnValue = MsgBox("Return Code = " + Format(AcuGetCallError()) + _
                   " Error Message = " + Format(strErrorMsg), vbOKOnly, _
                    "AcuGetCallError Values")
End Sub

      


       IDENTIFICATION DIVISION.
       PROGRAM-ID.  AS-TEST.

       DATE-WRITTEN.  28-FEB-1999 - Dovid Lubin.

      * Copyright (c) 1999-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * This program tests the ability to pass parameters to a COBOL program,
      * for the COBOL program to modify the parameter values and return them
      * to the caller. It is typically used to test Visual Basic calling COBOL,
      * but can be used to test any language calling COBOL using the
      * ACUCOBOL-GT Automation Server or Runtime DLL.

      * This program, AS-TEST (astest.cbl), takes 4 parameters. The first
      * is an integer number, the second is a string, the third is a long
      * number and the fourth is a floating point number. The caller actually
      * passes Variant type data by reference for each parameter. The COBOL
      * program receives a handle for each Variant parameter and calls
      * C$GETVARIANT to convert the Variant data to a COBOL data item.
      * Then to return the modified parameters it calls C$SETVARIANT to
      * convert COBOL data items back into the Variant parameters using the
      * same handles.

      * The easiest way to call COBOL from another programming language is to
      * use the ACUCOBOL-GT Automation Server.

      * To use the ACUCOBOL-GT Automation Server from Visual Basic:
      *
      * 1. Add "ACUCOBOL-GT Library 4.3" to your project references
      *   (Project menu/ References menu item)
      *
      * 2. Add the following code to declare and create the AcuGT object:
      *
      *    Dim cblObj As Object
      *    Set cblObj = New AcuGT
      *
      * 3. Then call the Initialize, Call, Cancel, or Shutdown methods
      *
      *    cblObj.Initialize "-d"   ' Start ACUCOBOL-GT in debug mode
      *    retVal = cblObj.Call(programName, arg0, arg1, arg2)
      *    cblObj.Shutdown
      *
      * or use the "With" construct. For example:
      *
      *    With cblObj
      *      .Initialize "-e @myserver:\myprogs\errorfile"
      *      .Call "*myserver:\myprogs\program1.acu", "call1", 1.2, 37
      *      .Call "*myserver:\myprogs\program1.acu", "call2", 2.3, 38
      *      .Call "*myserver:\myprogs\program1.acu", "call3", 3.4, 39
      *      .Cancel "*myserver:\myprogs\program1.acu"
      *    End With
      *
      * 4. 'Initialize' will automatically be called with an empty command line
      *    parameter if you don't explicitly call it. 'Shutdown' will be
      *    automatically called when the object is destroyed by VB. The
      *    following is perfectly valid.
      *
      *    Private Sub Command1_Click()
      *      Dim cblObj As Object
      *      Set cblObj = New AcuGT
      *      cblObj.Call "program"
      *    End Sub
      *
      *    In that case the AcuGT object will be created, and 'Initialize'
      *    called automatically. Then at the end of the subroutine, the AcuGT
      *    object will be destroyed which will cause 'Shutdown' to be called
      *    automatically.
      *
      *    If you have several COBOL calls to make, it is much more efficient
      *    to create the AcuGT object as a Public variable in the module,
      *    class, or form initialization.
      *
      * 5. Note that you may use the CreateObject function instead:
      *
      *    Dim cblObj As Object
      *    Set cblObj = CreateObject("AcuGT.Application");
      *
      * 6. The ACUCOBOL-GT Automation Server is thread-safe. If you want you
      *    can run COBOL programs asynchronously. To do this you must create
      *    a new thread and create a new AcuGT object in that thread. Then
      *    you may call the COBOL program from that thread.
      *
      *    For an example of how to create new threads in Visual Basic see
      *    "Creating a Multithreaded Test Application" in the Visual Basic
      *    documentation. It is located in MSDN Library Visual Studio 6.0 at:
      *
      *    Visual Basic Documentation/Using Visual Basic/Component Tools Guide/
      *    Creating ActiveX Components/Building Code Components/Scalability and
      *    Multithreading/Creating a Multithreaded Test Application

      * You may also call COBOL from Visual Basic by directly calling the
      * ACUCOBOL-GT Runtime DLL.

      * If you want to call the ACUCOBOL-GT Runtime DLL, the VB program should
      * have the following declarations:
      *
      *   Declare Function AcuInitialize Lib "wrun32.dll" _
      *      (Optional ByVal cmdLine As String) As Integer
      *
      *   Declare Sub AcuShutdown Lib "wrun32.dll" ()
      *
      *   Declare Function AcuCall Lib "wrun32.dll" _
      *      (ByVal name As String, _
      *        Optional param1, _
      *        Optional param2, _
      *        Optional param3, _
      *        Optional param4, _
      *        Optional param5, _
      *        Optional param6, _
      *        Optional param7, _
      *        Optional param8, _
      *        Optional param9, _
      *        Optional param10, _
      *        Optional param11, _
      *        Optional param12, _
      *        Optional param13, _
      *        Optional param14) As Integer
      *
      *   Declare Function AcuGetCallError Lib "wrun32.dll" () As Integer
      *   Declare Sub AcuCancel Lib "wrun32.dll" (ByVal name As String)
      *
      * To call COBOL from VB, first call AcuInitialize passing the runtime
      * command line options. For example:
      *
      *   returnValue = AcuInitialize("-c myconfig -le myerrors")
      *
      * You may use the runtime "-d" option to debug you COBOL program. Specify
      * "-d" in your command line to AcuInitialize. The debugger window will
      * appear when you actually call a COBOL program.
      *
      * AcuInitialize returns 0 on success and -1 on failure. It is safe to
      * call AcuInitialize multiple times. The command line from the first
      * call will be used and will be ignored on subsequent calls.
      *
      * Then call AcuCall passing the program name and parameters. For example,
      * to call this program, AS-TEST:
      *
      *   returnValue = AcuCall("astest", testNum, testStr, testLongNum,
      *                         testFloat)
      *
      * AcuCall returns 0 on success and -1 on failure.
      *
      * If AcuInitialize hasn't been called yet, AcuCall will call it passing
      * an empty command line.
      *
      * If AcuCall returns -1 you may call AcuGetCallError to get the error
      * code. The error codes are as follows:
      *
      *   -4    AcuCall has been called in multiple threads
      *   -3    AcuInitialize failed. (AcuInitialize cannot be called after
      *         AcuShutdown in a single process.)
      *    1    Program missing or inaccessible
      *    2    Not a COBOL program
      *    3    Corrupted program
      *    4    Inadequate memory available
      *    5    Unsupported version of object code
      *    6    Program already in use
      *    7    Too many external segments
      *    25   Connection refused - perhaps AcuConnect is not running
      *
      * Call AcuShutdown after you are completely finished using COBOL in
      * your VB application.
      *
      * Note that if a COBOL program issues a STOP RUN, AcuCall will return
      * but the runtime DLL will not shut down.
      *
      * To cancel a COBOL program call AcuCancel passing the name of the
      * program. For example:
      *
      *   AcuCancel("astest")
      *
      *

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  TEST-NUM                            USAGE SIGNED-SHORT.
       77  TEST-STR                            PIC X(100).
       77  TEST-LONG-NUM                       USAGE SIGNED-INT.
       77  TEST-FLOAT                          USAGE DOUBLE.

       LINKAGE SECTION.

       77  VARIANT-NUM                         USAGE HANDLE.
       77  VARIANT-STR                         USAGE HANDLE.
       77  VARIANT-LONG-NUM                    USAGE HANDLE.
       77  VARIANT-FLOAT                       USAGE HANDLE.

       PROCEDURE DIVISION USING VARIANT-NUM, VARIANT-STR,
           VARIANT-LONG-NUM, VARIANT-FLOAT.
       MAIN-LOGIC.

      * Move the Variant data into COBOL items

           CALL "C$GETVARIANT" USING VARIANT-NUM,      TEST-NUM.
           CALL "C$GETVARIANT" USING VARIANT-STR,      TEST-STR.
           CALL "C$GETVARIANT" USING VARIANT-LONG-NUM, TEST-LONG-NUM.
           CALL "C$GETVARIANT" USING VARIANT-FLOAT,    TEST-FLOAT.

      * Modify the data

           ADD 1 TO TEST-NUM.
           ADD 1 TO TEST-LONG-NUM.
           ADD 1 TO TEST-FLOAT.
           MOVE TEST-STR(2:) TO TEST-STR.

      * Go to sleep for a couple of seconds
           CALL "C$SLEEP" USING 2.

      * Convert the COBOL items to Variant data

           CALL "C$SETVARIANT" USING TEST-NUM,      VARIANT-NUM.
           CALL "C$SETVARIANT" USING TEST-STR,      VARIANT-STR.
           CALL "C$SETVARIANT" USING TEST-LONG-NUM, VARIANT-LONG-NUM.
           CALL "C$SETVARIANT" USING TEST-FLOAT,    VARIANT-FLOAT.

           EXIT PROGRAM.

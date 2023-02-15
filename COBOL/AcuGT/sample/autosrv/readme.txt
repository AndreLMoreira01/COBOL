RUNNING Visual Basic Samples
============================

Automation Server

Please see the Automation Server section of the User's Guide for additional
information.  If you are creating a new project from scratch, be sure to
enable the reference to the ACUCOBOL-GT Library in your project.

To run the Visual Basic/ACUCOBOL-GT Automation Server tests:

        1. Double-click on bin\acugt.exe to enable the reference to the
           ACUCOBOL-GT Library in your project.
        2. Double-click on sample\autosrv\projectx\projectx.exe, where
           "x" is 1 or 2, to run the project sample or double-click on
           sample\autosrv\projectx\projectx.vbp to open Visual Basic.
        3. In project1 press the "Call COBOL" push button.
        4. In project2 Press the "New Thread" push button a few times, press
           the "Call COBOL" push button in each thread window.
        5. Note that there is a 2-second pause in astest.acu to simulate a
           busy COBOL program.

Calling the ACUCOBOL-GT DLL directly

Project3 demonstrates calling the ACUCOBOL-GT DLL directly.

To run the Visual Basic Project test:

        1. Make sure that wrun32.dll and all DLLs it depends on are in
           your PATH or in the same directory as project3.exe.
        2. Double-click on sample\autosrv\project3\project3.exe to run
           the project sample or double-click on
           sample\autosrv\project3\project3.vbp to open Visual Basic.
        3. Press the "Call COBOL" push button.
        4. Note that there is a 2-second pause in astest.acu to simulate
           a busy COBOL program.


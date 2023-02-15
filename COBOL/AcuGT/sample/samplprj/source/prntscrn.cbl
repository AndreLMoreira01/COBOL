       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRTSCR IS INITIAL PROGRAM.

       DATE-WRITTEN.    09-MAY-1989  TDC.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * This program demonstrates how to print screens from ACUCOBOL
      * using the ACCEPT FROM SCREEN verb.  It is written as a subroutine
      * that can be called from any program to print the current screen.
      * This is not very interesting for MS-DOS users who have a perfectly
      * good print screen key but this routine also works for Unix, Xenix
      * and VMS users who do not.

      * NOTE: this program only works with screens that do not use
      * graphical controls.  This program is effectively obsolete when
      * used with graphical programs.  It is provided for backwards
      * compatibility with earlier versions of ACUCOBOL.

      * The program inquires from the user which printer to use.  The
      * code assumes that there is a printer named "PRINTER" as the
      * system default printer and alternate printers named "PRINTER1",
      * "PRINTER2", etc.  These assumptions can be changed by modifying
      * this program.  This program also uses the Escape key to cancel
      * the request.  This can be changed to match the key normally used
      * by an application to cancel an operation.  See the definition of
      * CANCEL-KEY in Working-Storage below.

      * The program assumes one file is available to open as a print file.
      * Any errors encountered will print an simple error message and
      * cancel the print operation.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-FILE
           ASSIGN TO PRINT PRINTER-NAME
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS PRINTER-STATUS.


      /*** DATA DIVISION ***

       DATA DIVISION.
       FILE SECTION.
       FD  PRINT-FILE.
       01  PRINT-RECORD                        PIC X(80).

       WORKING-STORAGE SECTION.

       77  PRINTER-STATUS                      PIC X(2).

       77  EXCEPTION-KEY                       PIC 9(4) COMP-1.
           88  CANCEL-KEY                      VALUE 27.
           88  CONVERSION-ERROR                VALUE 98.

       77  WINDOW-HANDLE                       PIC X(10).
       77  TWO-DIGITS                          PIC 99.
       77  LINE-NO                             PIC 9(3) COMP-1.

       01  PRINTER-NAME.
           03  VALUE "PRINTER"                 PIC X(7).
           03  PRINTER-NUMBER                  PIC X(2).

       01  TERM-INFO.
           03  FILLER                          PIC X(17).
           03  NO-OF-SCREEN-LINES              PIC 9(3).


      /*** PROCEDURE DIVISION ***

       PROCEDURE DIVISION.
       DECLARATIVES.

       PRINTER-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON PRINT-FILE.

       PRINTER-ERR.
      * Note: no print file operations occur until after a pop-up window
      * has been created for the entire screen.  This procedure assumes
      * that this window is in place.

           DISPLAY WINDOW, LINE 10, COLUMN 20, SIZE 40, LINES 4,
                   BOXED, ERASE, TITLE "Printer Error!"
           DISPLAY "Printer error #", LINE 2, COLUMN 5,
                   PRINTER-STATUS, " has occurred".
           DISPLAY " Operation cancelled, press return: ", LINE 4.
           ACCEPT PRINTER-NUMBER, TAB.
           CLOSE WINDOW WINDOW-HANDLE.
           EXIT PROGRAM.
           STOP RUN.

       END DECLARATIVES.

      /*** LEVEL-1 SECTION ***

       LEVEL-1 SECTION.
       MAIN-LOGIC.

           PERFORM ASK-WHICH-PRINTER.

      * The calling program may not have the current window set to the
      * entire screen.  The following statement will save the currrent
      * screen state and make the current window the full screen.

           DISPLAY WINDOW, POP-UP AREA IS WINDOW-HANDLE.

           OPEN OUTPUT PRINT-FILE.

      * In the following loop, we read each line of the screen.
      * We then translate any special line-drawing characters to printable
      * characters.  These characters are always the same even for
      * different terminals.

           ACCEPT TERM-INFO FROM TERMINAL-INFO.
           PERFORM VARYING LINE-NO FROM 1 BY 1
                           UNTIL LINE-NO IS > NO-OF-SCREEN-LINES
               ACCEPT PRINT-RECORD FROM SCREEN, LINE LINE-NO
               INSPECT PRINT-RECORD CONVERTING
                       X"0102030405060708090A0B0C0D0E0F1011" TO
                        " -|+++++++++|-|- "
               WRITE PRINT-RECORD BEFORE ADVANCING 1 LINE
           END-PERFORM.

      * All done, close the file and the restore the caller's window

           CLOSE PRINT-FILE.
           CLOSE WINDOW WINDOW-HANDLE.
           EXIT PROGRAM.
           STOP RUN.

       ASK-WHICH-PRINTER.

           DISPLAY WINDOW, LINE 9, COLUMN 20, SIZE 40, LINES 5,
                   BOXED, ERASE, TITLE "Print Current Screen",
                   COLOR 8, POP-UP AREA IS WINDOW-HANDLE.
           DISPLAY " Enter the number of the printer to use",
                   LINE 4.
           DISPLAY " Return = default, Escape = cancel",
                   LINE 5.
           DISPLAY "Print on which printer?", LINE 2, COLUMN 8.

           PERFORM WITH TEST AFTER UNTIL NOT CONVERSION-ERROR
               ACCEPT TWO-DIGITS, LINE 2, COLUMN 33, PROMPT, TAB,
                      CONVERT, NO BEEP, CONTROL KEY IN EXCEPTION-KEY
           END-PERFORM.

           CLOSE WINDOW WINDOW-HANDLE.

           IF CANCEL-KEY
               EXIT PROGRAM
               STOP RUN.

           EVALUATE TWO-DIGITS
               WHEN ZERO           MOVE SPACES TO PRINTER-NUMBER
               WHEN 1 THRU 9       MOVE TWO-DIGITS( 2:1 ) TO
                                               PRINTER-NUMBER
               WHEN OTHER          MOVE TWO-DIGITS TO PRINTER-NUMBER.

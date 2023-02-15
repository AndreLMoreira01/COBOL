       IDENTIFICATION DIVISION.
       PROGRAM-ID.  NOTEPAD IS RESIDENT PROGRAM.
       DATE-WRITTEN.  29-Jun-89 - TDC.
           15-Oct-90 - Incorporate left/right word actions and word
               wrapping.
           10-Jun-91 - Make notepad dimensions flexible (see NUM-LINES and
               NUM-COLS below).  Correct right-word action bug.
           05-Jun-92 - Add mouse handling.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * This program implements a simple "pop up" notepad.  The idea
      * here is to provide the user with a scratch pad for keeping
      * notes and reminders.  This program is designed to be called
      * from other applications.  The calling application should
      * designate a special "hot" key to bring up the notepad.  As long
      * as the run unit is active, the notepad will retain the scratch
      * pad contents.

      * This program demonstrates several interesting features of
      * ACUCOBOL.  In particular, it makes a fair use of "pop up" windows
      * and it also makes use of the ability to redefine the keyboard
      * from within a program.

      * NOTE: this program uses only pre-"GT" facilities of ACUCOBOL.
      * Much of what this program does can be more easily done by
      * creating a multi-line ENTRY-FIELD in COBOL.  However, this
      * program demonstrates several interesting programming
      * techniques, so we continue to provide it as a sample.

      * Note that this program assumes that the default ACUCOBOL keyboard
      * settings are being used.  If you redefine the keyboard, you
      * will probably have to make some changes to this program to match
      * your keyboard handling.  In particular, you may have to add
      * code to the INITAILIZE-NOTEPAD paragraph to change your keyboard
      * configuration to meet the assumptions of this program.
      * This program also assumes that the 1985 file status codes are used.

      * This program should be compiled using the default ACUCOBOL options.
      * This can be most easily done with "ccbl -xo @ notepad.cbl".
      * The "-x" will override any CBLFLAGS settings you may have, and the
      * "-o @" flag will cause the generated object file to be called
      * "notepad".  (Note that some Unix systems treat "@" as the cancel
      * line character.  You should re-map it with "stty" so that you
      * can use the "@" character.  For example, to set the kill character
      * to Control-U, you would type "stty kill \^u".)

      * This program is provided as a demonstration of programming techniques.
      * There are lots of possible enhancements to this program that could
      * be made.  For example, this program does not have a print option.
      * Also, multiple notepad pages would be nice.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SAVE-FILE
           ASSIGN TO INPUT-OUTPUT FILE-NAME
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD  SAVE-FILE.
       01  SAVE-RECORD                         PIC X(40).

       WORKING-STORAGE SECTION.

      * You can adjust the colors used by the notepad program
      * by changing the following values.  See ACUCOBOL.DEF for
      * a list of values.  Note that each value is a background
      * color added to a foreground color.

       01  COLOR-TABLE.
           03  MENU-COLOR                      PIC 9(4) COMP-1
                                               VALUE 35.
           03  NOTEPAD-COLOR                   PIC 9(4) COMP-1
                                               VALUE 129.
           03  ERROR-COLOR                     PIC 9(4) COMP-1
                                               VALUE 161.

      * You can adjust the dimensions of the notepad by changing these
      * two values.

       78  NUM-LINES                           VALUE 16.
       78  NUM-COLS                            VALUE 40.

       01  NOTEPAD-LINES.
           03  NOTEPAD-LINE
               OCCURS NUM-LINES TIMES          PIC X(NUM-COLS).

       01  KEY-ENTERED                         PIC 9(3).
           88  F1-KEY                          VALUE 1.
           88  CR-ENTERED                      VALUE 13.
           88  UP-ARROW                        VALUE 52.
           88  DOWN-ARROW                      VALUE 53.
           88  PAGE-UP                         VALUE 67.
           88  PAGE-DOWN                       VALUE 68.
                88  LEFT-BUTTON-PRESSED VALUE 81.
           88  RIGHT-BUTTON-PRESSED            VALUE 87.
           88  BACKSPACE                       VALUE 201.
           88  INSERT-LINE                     VALUE 202.
           88  DELETE-LINE                     VALUE 203.
           88  RIGHT-ARROW                     VALUE 204.
           88  LEFT-ARROW                      VALUE 205.
           88  RIGHT-WORD                      VALUE 206.
           88  LEFT-WORD                       VALUE 207.
           88  WORD-WRAP                       VALUE 0.

       01  SUB-MENU-FUNCTION                   PIC X.
           88  EXIT-SELECTED                   VALUE "E".

       01  CUR-POS.
           03  CUR-LINE                        PIC 9(2) COMP-1 VALUE 1.
           03  CUR-COLUMN                      PIC 9(2) COMP-1 VALUE 1.

       01  SAVE-POS.
           03  FILLER                          PIC 9(2) COMP-1.
           03  FILLER                          PIC 9(2) COMP-1.

       77  COUNTER                             PIC 9(2) COMP-1.
       77  WINDOW-COLOR                        PIC 9(4) COMP-1.

       01  FILE-STATUS                         PIC X(2).
           88  FILE-NOT-FOUND                  VALUE "35".
       01  REDEFINES FILE-STATUS               PIC X.
           88  FILE-OKAY                       VALUE "0".

       77  FILE-NAME                           PIC X(30).

       77  ERROR-NAME                          PIC X(30).
       77  ERROR-MESSAGE                       PIC X(35).

       77  ERROR-WINDOW                        PIC X(10).
       77  NOTEPAD-WINDOW                      PIC X(10).
       77  MENU-WINDOW                         PIC X(10).

       77  FILLER                              PIC 9.
           88  VALID-ENTRY                     VALUE 1, FALSE 0.

       77  SAVE-MOUSE-FLAGS                    PIC 9(5).
       77  MOUSE-FLAGS                         PIC 9(5).

       01  KEYMAP-OPERATIONS.
           03  SAVE-KEYMAP                     PIC 9 VALUE 1.
           03  RESTORE-KEYMAP                  PIC 9 VALUE ZERO.

       COPY "def/acugui.def".


       PROCEDURE DIVISION.
       DECLARATIVES.
       FILE-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON SAVE-FILE.

       FILE-ERROR-PGH.
           MOVE FILE-NAME TO ERROR-NAME.
           IF FILE-NOT-FOUND
               MOVE "This file does not exist" TO ERROR-MESSAGE
           ELSE
               STRING "File error #", FILE-STATUS,
                      " - operation aborted" DELIMITED BY SIZE,
                      INTO ERROR-MESSAGE.

           PERFORM ERROR-ROUTINE.

       END DECLARATIVES.


       LEVEL-1 SECTION.
       MAIN-LOGIC.
           PERFORM INITIALIZE-NOTEPAD.
           PERFORM EDIT-COMMAND WITH TEST AFTER
                   UNTIL EXIT-SELECTED.
           PERFORM EXIT-NOTEPAD.
           EXIT PROGRAM.
           STOP RUN.


       LEVEL-2 SECTION.
       EDIT-COMMAND.
           ACCEPT NOTEPAD-LINE( CUR-LINE ), LINE CUR-LINE,
                   UPDATE, CURSOR CUR-COLUMN, AUTO,
                   CONTROL KEY IN KEY-ENTERED.

           EVALUATE TRUE
             WHEN RIGHT-BUTTON-PRESSED
             WHEN F1-KEY
                   PERFORM SUB-MENU

             WHEN WORD-WRAP
                   PERFORM WORD-WRAP-LOGIC

             WHEN CR-ENTERED
                   MOVE 1 TO CUR-COLUMN
                   IF CUR-LINE IS < NUM-LINES
                       ADD 1 TO CUR-LINE
                   END-IF

             WHEN UP-ARROW
                   IF CUR-LINE IS > 1
                       SUBTRACT 1 FROM CUR-LINE
                   END-IF

             WHEN DOWN-ARROW
                   IF CUR-LINE IS < NUM-LINES
                       ADD 1 TO CUR-LINE
                   END-IF

             WHEN LEFT-ARROW
                   IF CUR-LINE IS > 1
                       SUBTRACT 1 FROM CUR-LINE
                       MOVE NUM-COLS TO CUR-COLUMN
                   END-IF

             WHEN RIGHT-ARROW
                   IF CUR-LINE IS < NUM-LINES
                       ADD 1 TO CUR-LINE
                       MOVE 1 TO CUR-COLUMN
                   END-IF

             WHEN LEFT-WORD
                   PERFORM MOVE-LEFT WITH TEST AFTER
                           UNTIL NOTEPAD-LINE( CUR-LINE )
                                             ( CUR-COLUMN : 1 )
                                             IS NOT = SPACE OR
                                 ( CUR-LINE IS = 1 AND
                                   CUR-COLUMN IS = 1 )
                   PERFORM MOVE-LEFT WITH TEST AFTER
                           UNTIL NOTEPAD-LINE( CUR-LINE )
                                             ( CUR-COLUMN : 1 )
                                             IS = SPACE OR
                                 ( CUR-LINE IS = 1 AND
                                   CUR-COLUMN IS = 1 )
                   IF CUR-LINE IS NOT = 1 OR
                      CUR-COLUMN IS NOT = 1
                       PERFORM MOVE-RIGHT
                   END-IF

             WHEN RIGHT-WORD
                   MOVE CUR-POS TO SAVE-POS
                   PERFORM MOVE-RIGHT
                           UNTIL CUR-LINE IS > NUM-LINES OR
                                 NOTEPAD-LINE( CUR-LINE )
                                             ( CUR-COLUMN : 1 )
                                             IS = SPACE
                   PERFORM MOVE-RIGHT WITH TEST AFTER
                           UNTIL CUR-LINE IS > NUM-LINES OR
                                 NOTEPAD-LINE( CUR-LINE )
                                             ( CUR-COLUMN : 1 )
                                             IS NOT = SPACE
                   IF CUR-LINE IS > NUM-LINES
                       MOVE SAVE-POS TO CUR-POS
                   END-IF

             WHEN PAGE-UP
                   MOVE 1 TO CUR-LINE

             WHEN PAGE-DOWN
                   MOVE NUM-LINES TO CUR-LINE

             WHEN BACKSPACE
                   IF CUR-LINE IS > 1
                       SUBTRACT 1 FROM CUR-LINE
                       MOVE ZERO TO COUNTER
                       INSPECT NOTEPAD-LINE( CUR-LINE )
                               TALLYING COUNTER FOR TRAILING SPACES
                       IF COUNTER IS >= NUM-COLS
                           MOVE 1 TO CUR-COLUMN
                       ELSE
                           COMPUTE CUR-COLUMN = NUM-COLS - COUNTER
                       END-IF
                       MOVE SPACE TO NOTEPAD-LINE( CUR-LINE )
                                                 ( CUR-COLUMN : 1 )
                   END-IF

             WHEN DELETE-LINE
                   PERFORM VARYING COUNTER FROM CUR-LINE BY 1
                                   UNTIL COUNTER IS > NUM-LINES - 1
                       MOVE NOTEPAD-LINE( COUNTER + 1 ) TO
                            NOTEPAD-LINE( COUNTER )
                       DISPLAY NOTEPAD-LINE( COUNTER ), LINE COUNTER
                   END-PERFORM
                   MOVE SPACES TO NOTEPAD-LINE( NUM-LINES )
                   DISPLAY SPACE, LINE NUM-LINES, ERASE LINE

             WHEN INSERT-LINE
                   PERFORM INSERT-A-LINE

             WHEN LEFT-BUTTON-PRESSED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   MOVE MOUSE-ROW TO CUR-LINE
                   MOVE MOUSE-COL TO CUR-COLUMN

           END-EVALUATE.


       SUB-MENU.
           DISPLAY WINDOW, LINE 2,
                   COLUMN 80 - ( NUM-COLS + 2 ), LINES 2,
                   SIZE NUM-COLS + 1,
                   COLOR MENU-COLOR, ERASE, NO WRAP,
                   POP-UP AREA IS MENU-WINDOW.

           DISPLAY "E", LINE 1, COLUMN 3, HIGH, "xit", LOW,
                   "L", COLUMN 13, HIGH, "oad", LOW,
                   "S", COLUMN 23, HIGH, "ave", LOW,
                   "C", COLUMN 33, HIGH, "alc", LOW.

           PERFORM WITH TEST AFTER UNTIL VALID-ENTRY
               SET VALID-ENTRY TO TRUE

               DISPLAY "Function: ", LINE 2, COLUMN 3
               ACCEPT SUB-MENU-FUNCTION, COLUMN 0, UPPER, NO ECHO, AUTO,
                       CONTROL KEY IN KEY-ENTERED

               IF LEFT-BUTTON-PRESSED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   IF MOUSE-ROW = 1
                       EVALUATE MOUSE-COL
                         WHEN 3 THRU 6
                               MOVE "E" TO SUB-MENU-FUNCTION
                         WHEN 13 THRU 16
                               MOVE "L" TO SUB-MENU-FUNCTION
                         WHEN 23 THRU 26
                               MOVE "S" TO SUB-MENU-FUNCTION
                         WHEN 33 THRU 36
                               MOVE "C" TO SUB-MENU-FUNCTION
                         WHEN OTHER
                               SET VALID-ENTRY TO FALSE
                       END-EVALUATE
                   ELSE
                       SET VALID-ENTRY TO FALSE
                   END-IF
              END-IF
           END-PERFORM.

           EVALUATE SUB-MENU-FUNCTION
             WHEN "S"        PERFORM ENTER-FILE-NAME
                             CLOSE WINDOW MENU-WINDOW
                             IF FILE-NAME IS NOT = SPACES
                                 PERFORM SAVE-NOTEPAD
                             END-IF

             WHEN "L"        PERFORM ENTER-FILE-NAME
                             CLOSE WINDOW MENU-WINDOW
                             IF FILE-NAME IS NOT = SPACES
                                 PERFORM LOAD-NOTEPAD
                             END-IF

             WHEN "C"        CLOSE WINDOW MENU-WINDOW
                             CALL "calc3"
                                 ON EXCEPTION
                                     MOVE "CALC3" TO ERROR-NAME
                                     MOVE "Calculator program missing"
                                              TO ERROR-MESSAGE
                                     PERFORM ERROR-ROUTINE
                             END-CALL

             WHEN OTHER      CLOSE WINDOW MENU-WINDOW

           END-EVALUATE.


       INITIALIZE-NOTEPAD.
           DISPLAY WINDOW, LINE 2,
                   COLUMN 80 - ( NUM-COLS + 2 ),
                   LINES NUM-LINES,
                   SIZE NUM-COLS + 1,
                   COLOR NOTEPAD-COLOR, BOXED, ERASE,
                   POP-UP AREA IS NOTEPAD-WINDOW,
                   BOTTOM RIGHT TITLE IS "F1 = menu".

           PERFORM PAINT-FULL-SCREEN.

           MOVE SPACE TO SUB-MENU-FUNCTION.

      * The following commands redefine the keyboard.  See the
      * "Terminal Manager" chapter for details on the "KEYSTROKE"
      * environment setting.  The following command enables the
      * Insert Line, Delete Line, and Left/Right Word keys (if any) and sets
      * the backspace and left/right arrow keys to generate exceptions
      * when the user leaves the field with them.  First we save
      * the current keyboard state so that we can restore it easily
      * when we leave.

           CALL "C$KEYMAP" USING SAVE-KEYMAP.

           SET ENVIRONMENT "KEYSTROKE" TO
                               "Edit=Backspace Exception=201 ZB",
                           "KEYSTROKE" TO "Exception=202 kA",
                           "KEYSTROKE" TO "Exception=203 kL",
                           "KEYSTROKE" TO
                               "Edit=Right Exception=204 kr",
                           "KEYSTROKE" TO
                               "Edit=Left Exception=205 kl",
                           "KEYSTROKE" to "Exception=206 Kr",
                           "KEYSTROKE" to "Exception=207 Kl",
                           "KEYSTROKE" to "Exception=81 Ml",
                           "KEYSTROKE" to "Exception=87 Mr".

      * Save the current MOUSE-FLAGS setting and then enable automatic
      * handling (for handling the line with the cursor) and enable
      * left-button-down actions (for transfering control to another line).
      * Also enable the right button to be used as a method of brining up
      * the menu.

           ACCEPT SAVE-MOUSE-FLAGS FROM ENVIRONMENT "MOUSE-FLAGS".
           ADD AUTO-MOUSE-HANDLING, ALLOW-LEFT-DOWN, ALLOW-RIGHT-DOWN
                   GIVING MOUSE-FLAGS.
           SET ENVIRONMENT "MOUSE-FLAGS" TO MOUSE-FLAGS.


       EXIT-NOTEPAD.

      * Restore the keyboard to the original settings.

           CALL "C$KEYMAP" USING RESTORE-KEYMAP.
           SET ENVIRONMENT "MOUSE-FLAGS" TO SAVE-MOUSE-FLAGS.

           CLOSE WINDOW NOTEPAD-WINDOW.


       LEVEL-3 SECTION.
       INSERT-A-LINE.
           ADD 1 TO CUR-LINE
           PERFORM VARYING COUNTER FROM NUM-LINES BY -1
                                   UNTIL COUNTER IS < CUR-LINE
               MOVE NOTEPAD-LINE( COUNTER - 1 ) TO
                            NOTEPAD-LINE( COUNTER )
               DISPLAY NOTEPAD-LINE( COUNTER ), LINE COUNTER
           END-PERFORM
           SUBTRACT 1 FROM CUR-LINE
           MOVE SPACES TO NOTEPAD-LINE( CUR-LINE )
           DISPLAY SPACE, LINE CUR-LINE, ERASE LINE.

       WORD-WRAP-LOGIC.
           IF CUR-LINE < NUM-LINES
               IF CUR-COLUMN IS > NUM-COLS
                   MOVE NUM-COLS TO CUR-COLUMN
               END-IF
               PERFORM MOVE-LEFT WITH TEST BEFORE
                       UNTIL NOTEPAD-LINE ( CUR-LINE )
                                          ( CUR-COLUMN : 1 )
                                          IS = SPACE OR
                             CUR-COLUMN IS = 1
               IF CUR-COLUMN IS NOT = 1 AND
                  CUR-COLUMN IS NOT = NUM-COLS
                   IF NOTEPAD-LINE( CUR-LINE + 1 ) IS NOT = SPACES
                       MOVE CUR-POS TO SAVE-POS
                       ADD 1 TO CUR-LINE
                       PERFORM INSERT-A-LINE
                       MOVE SAVE-POS TO CUR-POS
                   END-IF
                   MOVE NOTEPAD-LINE ( CUR-LINE ) ( CUR-COLUMN + 1 : )
                       TO NOTEPAD-LINE ( CUR-LINE + 1 )
                                       ( 1 : NUM-COLS + 1 - CUR-COLUMN )
                   MOVE SPACES TO NOTEPAD-LINE ( CUR-LINE )
                                               ( CUR-COLUMN + 1 : )
                   DISPLAY NOTEPAD-LINE ( CUR-LINE ) LINE CUR-LINE
                   SUBTRACT CUR-COLUMN, -1 FROM NUM-COLS GIVING
                                               CUR-COLUMN
               ELSE
                   MOVE 1 TO CUR-COLUMN
               END-IF
               ADD 1 TO CUR-LINE
           END-IF.

       MOVE-LEFT.
           IF CUR-COLUMN IS > 1
               SUBTRACT 1 FROM CUR-COLUMN
           ELSE
               IF CUR-LINE IS > 1
                   SUBTRACT 1 FROM CUR-LINE
                   MOVE NUM-COLS TO CUR-COLUMN
               END-IF
           END-IF.

       MOVE-RIGHT.
           IF CUR-COLUMN IS < NUM-COLS
               ADD 1 TO CUR-COLUMN
           ELSE
               ADD 1 TO CUR-LINE
               MOVE 1 TO CUR-COLUMN
           END-IF.

       LOAD-NOTEPAD.
           OPEN INPUT SAVE-FILE.
           IF FILE-OKAY
               READ SAVE-FILE RECORD
               IF SAVE-RECORD IS NOT = "NOTEPAD FILE"
                   MOVE "Not a NOTEPAD file" TO ERROR-MESSAGE
                   PERFORM ERROR-ROUTINE
               ELSE
                   PERFORM VARYING COUNTER FROM 1 BY 1 UNTIL
                               COUNTER IS > NUM-LINES OR NOT FILE-OKAY
                       READ SAVE-FILE INTO NOTEPAD-LINE( COUNTER )
                   END-PERFORM
               END-IF
               CLOSE SAVE-FILE
               PERFORM PAINT-FULL-SCREEN
               MOVE 1 TO CUR-LINE, CUR-COLUMN.


       SAVE-NOTEPAD.
           OPEN OUTPUT SAVE-FILE
           IF FILE-OKAY
               WRITE SAVE-RECORD FROM "NOTEPAD FILE"
               PERFORM VARYING COUNTER FROM 1 BY 1
                         UNTIL COUNTER IS > NUM-LINES OR NOT FILE-OKAY
                   WRITE SAVE-RECORD FROM NOTEPAD-LINE( COUNTER )
               END-PERFORM
               CLOSE SAVE-FILE.


       UTILITY-ROUTINES SECTION.
       ENTER-FILE-NAME.
           DISPLAY "File: ", LINE 2, COLUMN 3, ERASE LINE.
           ACCEPT FILE-NAME, COLUMN 0, UPDATE, TAB, UPPER, HIGH.
           IF FILE-NAME IS NOT = SPACES
               MOVE ZERO TO COUNTER
               INSPECT FILE-NAME TALLYING COUNTER FOR ALL "."
               IF COUNTER IS = ZERO
                   MOVE FILE-NAME TO ERROR-NAME
                   STRING ERROR-NAME, DELIMITED BY SPACE,
                          ".NTS" DELIMITED BY SIZE INTO FILE-NAME
               END-IF
               MOVE FILE-NAME TO ERROR-NAME.


       PAINT-FULL-SCREEN.
           PERFORM VARYING COUNTER FROM 1 BY 1
                           UNTIL COUNTER IS > NUM-LINES
               DISPLAY NOTEPAD-LINE( COUNTER ), LINE COUNTER
           END-PERFORM.


       ERROR-ROUTINE.
           DISPLAY WINDOW, LINE 9, COLUMN 20, LINES 5, SIZE 40,
                   COLOR ERROR-COLOR, BOXED, ERASE, SHADOW,
                   POP-UP AREA IS ERROR-WINDOW,
                   TITLE IS "File Error!".

           DISPLAY ERROR-MESSAGE, LINE 2, COLUMN 3.
           DISPLAY "Name: ", LINE 4, COLUMN 3, ERROR-NAME.

           DISPLAY "(press enter) ", LINE 5, COLUMN 25.
           ACCEPT OMITTED, TAB, COLUMN 0.

           CLOSE WINDOW ERROR-WINDOW.

       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CALCULATOR.

       DATE-WRITTEN.  25-JUN-1989 - TDC.
                      03-FEB-1991 - Fuss with the colors a little bit.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * >>>> FOR A GRAPHICAL VERSION OF THIS, SEE "CALC3.CBL" <<<<

      * This program implements a simple 4-function "pop up" calculator.
      * It demonstrates several unique features of ACUCOBOL including
      * "pop up" windows and the ability to reconfigure the keyboard.

      * As implemented, this calculator allows for 12 digits before the
      * decimal point and 6 digits after.  By default, it shows 2 digits
      * after the decimal point, but it can shifted to show all 6 digits.
      * This calculator is designed to be called from another program.
      * It "pops up" over the program's screen.  As long as the
      * calculator program is not cancelled, it will retain its last
      * value and display mode.

      * The caller may optionally pass a S9(12)V9(6) data item to the
      * calculator.  If it does so, the passed item is filled in with
      * the calculator's last value when it exits.

      * The calculator accepts the normal commands: '+', '-', '*', '/'
      * and '='.  The Return key may also be used as the '=' key.
      * The F1 key terminates the program, the F2 key toggles the
      * display precision between 2 digits and 6 digits, and the F3
      * key acts as a "change sign" key.  Note that unlike a normal
      * calculator, the "change sign" key also acts as an '=' key.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  ANSWER                              PIC S9(12)V9(6) VALUE 0.
           88  CALC-OVERFLOW                   VALUES
                                               +999999999999.999999,
                                               -999999999999.999999.

       77  UENTRY                              PIC S9(12)V9(6).

       77  FORMATTED-ANSWER-ALL                PIC -(13).9(6).
       77  FORMATTED-ANSWER-2                  PIC -(13).99.
       77  SHOW-ANSWER                         PIC X(20).

       01  PRECISION-FLAG                      PIC 9 VALUE ZERO.
           88  SHOW-FULL-PRECISION             VALUE 1.

       01  OPERATION                           PIC 9(3).
           88  OP-ADD                          VALUE 101.
           88  OP-SUBTRACT                     VALUE 102.
           88  OP-MULTIPLY                     VALUE 103.
           88  OP-DIVIDE                       VALUE 104.

       01  KEY-ENTERED                         PIC 9(3).
           88  EXIT-SELECTED                   VALUE 1.
           88  PRECISION-SELECTED              VALUE 2.
           88  CHANGE-SIGN-SELECTED            VALUE 3.

       77  CURSOR-OFFSET                       PIC 9(2).
       77  CALC-WINDOW                         PIC X(10).
       77  NUMBER-OF-PARAMETERS                PIC 9(4) COMP-1.
       77  FOREGROUND                          PIC 9(4) COMP-1.
       77  INTENSITY                           PIC 9(4) COMP-1.

       COPY "def/acucobol.def".

       LINKAGE SECTION.

       77  RETURN-VALUE                        PIC S9(12)V9(6).


       PROCEDURE DIVISION USING RETURN-VALUE.
       MAIN-LOGIC.

           PERFORM INITIALIZE-CALCULATOR.
           PERFORM CALC-OPERATION, WITH TEST AFTER, UNTIL EXIT-SELECTED.
           PERFORM EXIT-CALCULATOR.
           GOBACK.

       INITIALIZE-CALCULATOR.

           MOVE ZERO TO OPERATION.
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.
           IF HAS-COLOR
               MOVE WHITE TO FOREGROUND
               MOVE 4096 TO INTENSITY
           ELSE
               MOVE BLACK TO FOREGROUND
               MOVE ZERO TO INTENSITY.

           DISPLAY WINDOW, LINE 8, COLUMN 23, SIZE 34, LINES 8,
                   BOXED, ERASE, BOTTOM RIGHT TITLE "F1 to exit",
                   COLOR FOREGROUND + BCKGRND-BLUE, SHADOW,
                   POP-UP AREA IS CALC-WINDOW.

           DISPLAY BOX, LINE 1, COLUMN 3, SIZE 30, LINES 3.

           DISPLAY "1     2     3     +", LINE 4, COLUMN 8.
           DISPLAY "4     5     6     -", LINE 5, COLUMN 8.
           DISPLAY "7     8     9     *", LINE 6, COLUMN 8.
           DISPLAY "   0     =        /", LINE 7, COLUMN 8.


      * The following lines cause the '+', '-', '*', '/' and '=' keys
      * to terminate input.  This greatly simplifies the entering
      * of numbers as the program does not need to input the numbers
      * one character at a time.  Instead, it re-programs the keyboard
      * so that each of the operation keys terminates the input and
      * returns a unique termination value.  This allows the use of
      * a normal ACCEPT statement to enter the number while still
      * allowing immediate return when one of the operation keys is
      * pressed.  The following lines assign a unique termination value
      * to the five operation keys.  There is nothing special about
      * the values chosen except that they are unique from all other
      * keys.  Note, however, that the '=' key is assigned the same value
      * as the Return key (13).  Also note that the values used here
      * refer to the ASCII values of the keys being redefined.

           SET ENVIRONMENT "KEYSTROKE" TO "Terminate=101 43",
                           "KEYSTROKE" TO "Terminate=102 45",
                           "KEYSTROKE" TO "Terminate=103 42",
                           "KEYSTROKE" TO "Terminate=104 47",
                           "KEYSTROKE" TO "Terminate=13 61".


       CALC-OPERATION.

      * This routine handles the guts of the calculator.  Note that the
      * logic of an infix calculator is a little confusing because we
      * don't know the value of the second operand when the operation
      * is entered.  We get around this by delaying the evaluation of
      * each operation by one cycle through the loop.

           IF SHOW-FULL-PRECISION
               MOVE ANSWER TO FORMATTED-ANSWER-ALL
               MOVE FORMATTED-ANSWER-ALL TO SHOW-ANSWER
           ELSE
               IF CALC-OVERFLOW
                   MOVE ANSWER TO FORMATTED-ANSWER-2
               ELSE
                   COMPUTE FORMATTED-ANSWER-2 ROUNDED = ANSWER
               END-IF
               MOVE FORMATTED-ANSWER-2 TO SHOW-ANSWER.

           DISPLAY SHOW-ANSWER, LINE 2, COLUMN 4, SIZE 27, RIGHT,
                   COLOR INTENSITY.

           MOVE 1 TO CURSOR-OFFSET.
           ACCEPT UENTRY, LINE 2, COLUMN 4, CONVERT, TAB,
                   COLOR INTENSITY, CURSOR CURSOR-OFFSET,
                   CONTROL KEY IN KEY-ENTERED.

      * If the cursor offset is 1 and the entered value is zero, then
      * the user just pressed an operation key without entering a
      * number.  In this case, copy the current value as the number
      * entered.

           IF CURSOR-OFFSET IS = 1 AND UENTRY IS = ZERO
               MOVE ANSWER TO UENTRY.

           IF PRECISION-SELECTED
               COMPUTE PRECISION-FLAG = 1 - PRECISION-FLAG.

           IF CHANGE-SIGN-SELECTED
               COMPUTE UENTRY = - UENTRY.

           EVALUATE TRUE
               WHEN OP-ADD           ADD UENTRY TO ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-ADD
               WHEN OP-SUBTRACT      SUBTRACT UENTRY FROM ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-SUBTRACT
               WHEN OP-MULTIPLY      MULTIPLY UENTRY BY ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-MULTIPLY
               WHEN OP-DIVIDE        DIVIDE UENTRY INTO ANSWER
                                         ON SIZE ERROR
                                             SET CALC-OVERFLOW TO TRUE
                                         END-DIVIDE
               WHEN OTHER            MOVE UENTRY TO ANSWER
           END-EVALUATE.

           MOVE KEY-ENTERED TO OPERATION.


       EXIT-CALCULATOR.

           CLOSE WINDOW CALC-WINDOW.

      * The following lines reset the operation keys so that they act
      * like normal data keys instead of termination keys.

           SET ENVIRONMENT "KEYSTROKE" TO "Data=43 43",
                           "KEYSTROKE" TO "Data=45 45",
                           "KEYSTROKE" TO "Data=42 42",
                           "KEYSTROKE" TO "Data=47 47",
                           "KEYSTROKE" TO "Data=61 61".

      * See if the caller passed an argument.  If it did, then return
      * the last answer to the caller.

           CALL "C$NARG" USING NUMBER-OF-PARAMETERS.
           IF NUMBER-OF-PARAMETERS IS >= 1
               MOVE ANSWER TO RETURN-VALUE.

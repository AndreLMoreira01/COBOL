IDENTIFICATION DIVISION.
PROGRAM-ID.  COMPCALC.
DATE-WRITTEN.  20-SEP-1989 - TDC.

* Copyright (c) 1995-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

remarks.  This is a hexadecimal version of the ACUCOBOL calculator
          program.  It converts between decimal, hex, octal, and ascii.

DATA DIVISION.
WORKING-STORAGE SECTION.

01  ANSWER                              PIC S9(12) VALUE 0.

77  UENTRY                              PIC X(16).
77  NUMERIC-ENTRY REDEFINES UENTRY      PIC 9(16).
77  ENTERED-NUMBER                      PIC S9(12).

77  SHOW-ANSWER                         PIC X(20).

01  CURRENT-BASE                        PIC 9(2) VALUE 10.
    88  BASE-2                          VALUE 2.
    88  BASE-8                          VALUE 8.
    88  BASE-10                         VALUE 10.
    88  BASE-16                         VALUE 16.

01  ALTERNATE-BASE                      PIC 9(2) VALUE 16.

01  WORD-SIZE-PARAMETERS.
    03  PIC 99                          VALUE 32.
    03  PIC 9(10)                       VALUE 2147483647.
    03  PIC S9(10)                      VALUE -2147483648.
    03  PIC 9(10)                       VALUE 4294967296.
    03  PIC 99                          VALUE 16.
    03  PIC 9(10)                       VALUE 32767.
    03  PIC S9(10)                      VALUE -32768.
    03  PIC 9(10)                       VALUE 65536.
    03  PIC 99                          VALUE 8.
    03  PIC 9(10)                       VALUE 127.
    03  PIC S9(10)                      VALUE -128.
    03  PIC 9(10)                       VALUE 256.

01  WORD-SIZE-TABLE REDEFINES WORD-SIZE-PARAMETERS.
    03  WORD-SIZE-ITEM OCCURS 3 TIMES.
        05  WORD-SIZE                   PIC 99.
        05  MAX-POSITIVE                PIC 9(10).
        05  MAX-NEGATIVE                PIC S9(10).
        05  WORD-ADJUST                 PIC 9(10).

77  WORD-IDX                            PIC 9 COMP-1, VALUE 1.

01  OPERATION                           PIC 9(3).
    88  OP-ADD                          VALUE 101.
    88  OP-SUBTRACT                     VALUE 102.
    88  OP-MULTIPLY                     VALUE 103.
    88  OP-DIVIDE                       VALUE 104.
    88  OP-MOD                          VALUE 105.

01  KEY-ENTERED                         PIC 9(3) VALUE ZERO.
    88  EXIT-SELECTED                   VALUE 1.
    88  CHANGE-SIGN-SELECTED            VALUE 2.
    88  TOGGLE-BASE                     VALUE 3.
    88  SET-BASE-16                     VALUE 4.
    88  SET-BASE-8                      VALUE 5.
    88  SET-BASE-2                      VALUE 6.
    88  SHOW-ASCII                      VALUE 7.
    88  CHANGE-WORD-SIZE                VALUE 9.
    88  TOGGLE-SIGNED-UNSIGNED          VALUE 10.

01  HEX-DEC-DATA                        PIC X(48) VALUE
    "000101202303404505606707808909A10B11C12D13E14F15".

01  HEX-DECIMAL-TABLE REDEFINES HEX-DEC-DATA.
    03  HEX-TABLE
        OCCURS 16 TIMES
        ASCENDING KEY IS HEX-VALUE, DEC-VALUE
        INDEXED BY HEX-IDX.
        05  HEX-VALUE                   PIC X.
        05  DEC-VALUE                   PIC 99.

01  ASCII-NUMERIC-VALUE                 PIC 999 COMP-1.

01  ASCII-MAP-VALUE REDEFINES ASCII-NUMERIC-VALUE.
    03  FILLER                          PIC X.
    03  ASCII-CHARACTER-VALUE           PIC X.

01  FILLER                              PIC X.
    88  NUM-IN-ERROR                    VALUE "Y", FALSE "N".

01  FILLER                              PIC X VALUE "Y".
    88  SIGNED-WORD                     VALUE "Y", FALSE "N".

77  IDX                                 PIC 9(3) COMP-1.
77  TEMP-NUM                            PIC 9(12).
77  MOD-VALUE                           PIC 9(2).
77  SIGN-CHAR                           PIC X.

77  CURSOR-OFFSET                       PIC 9(2).
77  CALC-WINDOW                         PIC X(10).
77  CALC-COLOR                          PIC 9(4) COMP-1, VALUE 0.

COPY "def/acucobol.def".

PROCEDURE DIVISION.
MAIN-LOGIC.

    PERFORM INITIALIZE-CALCULATOR.
    PERFORM CALC-OPERATION, WITH TEST AFTER, UNTIL EXIT-SELECTED.
    PERFORM EXIT-CALCULATOR.
    GOBACK.

INITIALIZE-CALCULATOR.

* By default, the calculator display is white on blue.  You
* can select different colors by changing the next line.

    ADD BCKGRND-BLUE, WHITE GIVING CALC-COLOR.
    MOVE ZERO TO OPERATION.

    DISPLAY WINDOW, LINE 8, COLUMN 18, SIZE 44, LINES 9,
            BOXED, ERASE, BOTTOM RIGHT TITLE "F1 to exit",
            COLOR CALC-COLOR, POP-UP AREA IS CALC-WINDOW.

    DISPLAY BOX, LINE 1, COLUMN 5, SIZE 36, LINES 3.

    DISPLAY "1     2     3     +     F2: Chs", LINE 4, COLUMN 8.
    DISPLAY "4     5     6     -     F3: Cvrt", LINE 5, COLUMN 8.
    DISPLAY "7     8     9     *     F4: Hex", LINE 6, COLUMN 8.
    DISPLAY "   0     =        /     F5: Oct", LINE 7, COLUMN 8.
    DISPLAY "F9: 32   F10: -   %     F6: Bin", LINE 8, COLUMN 8.

    PERFORM DISPLAY-WORD-SIZE.

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
                    "KEYSTROKE" TO "Terminate=105 37",
                    "KEYSTROKE" TO "Terminate=13 61".


CALC-OPERATION.

* This routine handles the guts of the calculator.  Note that the
* logic of an infix calculator is a little confusing because we
* don't know the value of the second operand when the operation
* is entered.  We get around this by delaying the evaluation of
* each operation by one cycle through the loop.

    PERFORM CONVERT-TO-BASE.

    DISPLAY SHOW-ANSWER, LINE 2, COLUMN 6, SIZE 30, RIGHT, HIGH.
    EVALUATE TRUE
        WHEN SHOW-ASCII    MOVE "a" TO SIGN-CHAR
        WHEN BASE-2        MOVE "b" TO SIGN-CHAR
        WHEN BASE-8        MOVE "o" TO SIGN-CHAR
        WHEN BASE-10       MOVE "d" TO SIGN-CHAR
        WHEN BASE-16       MOVE "h" TO SIGN-CHAR
    END-EVALUATE.
    DISPLAY SPACE, HIGH, SIGN-CHAR, HIGH.

    MOVE 1 TO CURSOR-OFFSET.
    ACCEPT UENTRY, LINE 2, COLUMN 6, HIGH, TAB, UPPER,
           CURSOR CURSOR-OFFSET, CONTROL KEY IN KEY-ENTERED.

* If the cursor offset is 1 and the entered value is zero, then
* the user just pressed an operation key without entering a
* number.  In this case, copy the current value as the number
* entered.

    IF CURSOR-OFFSET IS = 1 AND UENTRY IS = SPACES
        MOVE ANSWER TO ENTERED-NUMBER
    ELSE
        PERFORM CONVERT-TO-DECIMAL
        IF NUM-IN-ERROR
            DISPLAY "Illegal Value " LINE 2, COLUMN 6, HIGH
            ACCEPT UENTRY, TAB, SIZE 3
            GO TO CALC-OPERATION.

    EVALUATE TRUE
        WHEN TOGGLE-BASE
            IF BASE-10
                MOVE ALTERNATE-BASE TO CURRENT-BASE
            ELSE
                MOVE 10 TO CURRENT-BASE
            END-IF

        WHEN SET-BASE-16
            MOVE 16 TO ALTERNATE-BASE, CURRENT-BASE

        WHEN SET-BASE-8
            MOVE 8 TO ALTERNATE-BASE, CURRENT-BASE

        WHEN SET-BASE-2
            MOVE 2 TO ALTERNATE-BASE, CURRENT-BASE

        WHEN CHANGE-SIGN-SELECTED
            COMPUTE ENTERED-NUMBER = - ENTERED-NUMBER

        WHEN CHANGE-WORD-SIZE
            ADD 1 TO WORD-IDX
            IF WORD-IDX IS >= 4
                MOVE 1 TO WORD-IDX
            END-IF
            PERFORM DISPLAY-WORD-SIZE

        WHEN TOGGLE-SIGNED-UNSIGNED
            IF SIGNED-WORD
                SET SIGNED-WORD TO FALSE
            ELSE
                SET SIGNED-WORD TO TRUE
            END-IF
            PERFORM DISPLAY-WORD-SIZE

        WHEN SHOW-ASCII
            IF SIGNED-WORD
                SET SIGNED-WORD TO FALSE
                PERFORM DISPLAY-WORD-SIZE
            END-IF

    END-EVALUATE.

    EVALUATE TRUE
        WHEN OP-ADD           ADD ENTERED-NUMBER TO ANSWER
        WHEN OP-SUBTRACT      SUBTRACT ENTERED-NUMBER FROM ANSWER
        WHEN OP-MULTIPLY      MULTIPLY ENTERED-NUMBER BY ANSWER
        WHEN OP-DIVIDE        DIVIDE ENTERED-NUMBER INTO ANSWER
        WHEN OP-MOD           DIVIDE ENTERED-NUMBER INTO ANSWER
                                  GIVING TEMP-NUM
                                  REMAINDER ANSWER
        WHEN OTHER            MOVE ENTERED-NUMBER TO ANSWER
    END-EVALUATE.

    DIVIDE WORD-ADJUST( WORD-IDX ) INTO ANSWER GIVING TEMP-NUM,
        REMAINDER ANSWER.

    IF SIGNED-WORD
        IF ANSWER IS > MAX-POSITIVE( WORD-IDX )
            SUBTRACT WORD-ADJUST( WORD-IDX ) FROM ANSWER
        END-IF
        IF ANSWER IS < MAX-NEGATIVE( WORD-IDX )
            ADD WORD-ADJUST( WORD-IDX ) TO ANSWER
        END-IF
    ELSE
        IF ANSWER IS NEGATIVE
            ADD WORD-ADJUST( WORD-IDX ) TO ANSWER
        END-IF
    END-IF.

    MOVE KEY-ENTERED TO OPERATION.


EXIT-CALCULATOR.

    CLOSE WINDOW CALC-WINDOW.

* The following lines reset the operation keys so that they act
* like normal data keys instead of termination keys.

    SET ENVIRONMENT "KEYSTROKE" TO "Data=43 43",
                    "KEYSTROKE" TO "Data=45 45",
                    "KEYSTROKE" TO "Data=42 42",
                    "KEYSTROKE" TO "Data=47 47",
                    "KEYSTROKE" TO "Data=37 37",
                    "KEYSTROKE" TO "Data=61 61".

DISPLAY-WORD-SIZE.

    IF SIGNED-WORD
        MOVE "-" TO SIGN-CHAR
    ELSE
        MOVE "+" TO SIGN-CHAR.

    DISPLAY WORD-SIZE( WORD-IDX ), LINE 8, COLUMN 12, SIZE 2,
            CONVERT, RIGHT; SIGN-CHAR, COLUMN 22.

CONVERT-TO-DECIMAL.

* Converts UENTRY to ENTERED-NUMBER using the current radix.

    MOVE ZERO TO ENTERED-NUMBER.
    SET NUM-IN-ERROR TO FALSE.
    PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 16
        IF UENTRY( IDX : 1 ) IS NOT = SPACE
            SEARCH ALL HEX-TABLE
                AT END
                    SET NUM-IN-ERROR TO TRUE
                WHEN HEX-VALUE( HEX-IDX ) IS = UENTRY( IDX : 1 )
                    COMPUTE ENTERED-NUMBER =
                        ENTERED-NUMBER * CURRENT-BASE +
                            DEC-VALUE( HEX-IDX )
                    IF DEC-VALUE( HEX-IDX ) IS >= CURRENT-BASE
                        SET NUM-IN-ERROR TO TRUE
                    END-IF
            END-SEARCH
        END-IF
    END-PERFORM.

CONVERT-TO-BASE.

* Converts ANSWER to SHOW-ANSWER using current radix

    IF SHOW-ASCII
        PERFORM CONVERT-TO-ASCII
    ELSE IF ANSWER IS = ZERO
        MOVE "0" TO SHOW-ANSWER
    ELSE
        MOVE SPACES TO SHOW-ANSWER
        MOVE 20 TO IDX
        IF ANSWER IS NEGATIVE
            MOVE "-" TO SIGN-CHAR
            COMPUTE TEMP-NUM = - ANSWER
        ELSE
            MOVE SPACE TO SIGN-CHAR
            MOVE ANSWER TO TEMP-NUM
        END-IF
        PERFORM UNTIL TEMP-NUM IS = ZERO
            DIVIDE CURRENT-BASE INTO TEMP-NUM
                   GIVING TEMP-NUM REMAINDER MOD-VALUE
            SEARCH ALL HEX-TABLE
                WHEN DEC-VALUE( HEX-IDX ) IS = MOD-VALUE
                    IF IDX IS = 1
                        MOVE '*' TO SIGN-CHAR
                        MOVE ZERO TO TEMP-NUM
                    ELSE
                        MOVE HEX-VALUE( HEX-IDX ) TO
                             SHOW-ANSWER( IDX : 1 )
                        SUBTRACT 1 FROM IDX
                    END-IF
            END-SEARCH
        END-PERFORM
        MOVE SIGN-CHAR TO SHOW-ANSWER( IDX : 1 ).

CONVERT-TO-ASCII.

    MOVE SPACES TO SHOW-ANSWER.
    MOVE ANSWER TO TEMP-NUM.
    COMPUTE IDX = WORD-SIZE( WORD-IDX ) / 8.
    PERFORM UNTIL IDX IS = ZERO
        DIVIDE 256 INTO TEMP-NUM GIVING TEMP-NUM
            REMAINDER ASCII-NUMERIC-VALUE
        IF ASCII-CHARACTER-VALUE IS < SPACE OR > X'7E'
            MOVE '.' TO SHOW-ANSWER( IDX : 1 )
        ELSE
            MOVE ASCII-CHARACTER-VALUE TO SHOW-ANSWER( IDX : 1 )
        END-IF
        SUBTRACT 1 FROM IDX
    END-PERFORM.

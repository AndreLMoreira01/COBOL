       IDENTIFICATION DIVISION.
       PROGRAM-ID.  GENMENU.
       DATE-WRITTEN.   01-Aug-92 - TDC.
                       03-Aug-97 - TDC - added pop-up menus
           This program aids in the generation of menu bars.  It takes as
           input a script that describes one or more menus and it produces
           COBOL source code to create these menus.  For detailed
           instructions, see the ACUCOBOL documentation.

           If switch "1" is set (use "-1" on the command line), then
           this program runs quitely if there are no errors.  This
           is useful when run from a makefile.

           Copyright (c) 1992-2006 by Acucorp, Inc.  All rights reserved.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           SWITCH 1, ON STATUS IS QUIET-MODE
           SYMBOLIC TAB-CHAR IS 10.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MENU-FILE
           ASSIGN TO INPUT MENU-FILE-NAME
           LINE SEQUENTIAL
           FILE STATUS IS MENU-STATUS.

           SELECT OUT-FILE
           ASSIGN TO OUTPUT OUT-FILE-NAME
           LINE SEQUENTIAL
           FILE STATUS IS OUT-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD  MENU-FILE.
       01  MENU-LINE                           PIC X(100).

       FD  OUT-FILE.
       01  OUT-LINE.
           03  FILLER                          PIC X(7).
           03  AREA-A.
               05  FILLER                      PIC X(4).
               05  AREA-B                      PIC X(61).

       WORKING-STORAGE SECTION.

       01  MENU-STATUS                         PIC XX.
           88  MENU-OK                         VALUES "00" THRU "0Z".
           88  MENU-EOF                        VALUE "10".

       01  OUT-STATUS                          PIC XX.

       01  MENU-FILE-NAME                      PIC X(40).
       01  OUT-FILE-NAME                       PIC X(40).

       78  MENU-NAME-SIZE                      VALUE 16.
       01  MENU-NAME                           PIC X(MENU-NAME-SIZE).
       01  MENU-EXIT-NAME                      PIC X(30).

       77  FILLER                              PIC 9.
           88  POPUP-MENU                      VALUE 1, FALSE ZERO.

       01  PARSED-MENU-LINE.
           03  FILLER                          PIC 9.
               88  LINE-DOES-NOT-HAVE-TEXT     VALUE ZERO.
               88  LINE-HAS-TEXT               VALUE 1.
           03  TEXT-FIELD                      PIC X(50).
           03  NUM-WORDS                       PIC 9.
           03  PARSED-WORDS
               OCCURS 1 TO 6 TIMES
                   DEPENDING ON NUM-WORDS
               INDEXED BY WORD-IDX             PIC X(30).

       77  LEADING-CHARS                       PIC X(100).
       77  TRAILING-CHARS                      PIC X(100).
       77  NUM-TOKENS                          PIC 9 COMP-4.
       77  COUNTER                             PIC 999 COMP-4.
       77  SOURCE-PTR                          PIC 999 COMP-4.

       78  PARAM-OFFSET                        VALUE 21.
       78  MAX-PARAM-SIZE                      VALUE 50.
       77  PARAM-VALUE                         PIC X(MAX-PARAM-SIZE).
       77  PARAM-PTR                           PIC 99 COMP-4.
       77  SOURCE-INDENT                       PIC 99 COMP-4 VALUE 1.

       78  MAX-MENU-DEPTH                      VALUE 5.
       77  MENU-DEPTH                          USAGE INDEX.

       01  HANDLE-NAMES.
           03  PIC X(20) VALUE "MENU-HANDLE".
           03  PIC X(20) VALUE "SUB-HANDLE-1".
           03  PIC X(20) VALUE "SUB-HANDLE-2".
           03  PIC X(20) VALUE "SUB-HANDLE-3".
           03  PIC X(20) VALUE "SUB-HANDLE-4".

       01  HANDLE-TABLE REDEFINES HANDLE-NAMES.
           03  HANDLE-NAME
               OCCURS MAX-MENU-DEPTH TIMES     PIC X(20).

       77  WHEN-FLAG                           PIC X(30).
       01  WHEN-ACTIVE-TABLE.
           03  WHEN-ACTIVE-FLAG
               OCCURS MAX-MENU-DEPTH TIMES     PIC 9 VALUE ZERO.
               88  WHEN-ACTIVE                 VALUE 1, FALSE ZERO.

       77  MENU-FLAGS                          PIC 9(5).
       77  MENU-ID                             PIC X(30).
       77  FIRST-FLAG-WORD                     PIC 9 COMP-4.
       77  SUB-MENU-FLAG                       PIC 9.
           88  SUB-MENU-WANTED                 VALUE 1, FALSE ZERO.

       77  ERROR-MSG                           PIC X(40).
       77  LINE-NUM                            PIC 9(4) VALUE ZERO.
       77  FILLER                              PIC 9 VALUE ZERO.
           88  LAST-LINE-BLANK                 VALUE 1, FALSE ZERO.
       77  FILLER                              PIC 9 VALUE ZERO.
           88  WANT-BLANK-LINE                 VALUE 1, FALSE ZERO.
       77  FILLER                              PIC 9 VALUE ZERO.
           88  HAS-ERRORS                      VALUE 1, FALSE ZERO.

       01  MONTH-TABLE.
           03  PIC X(3) VALUE "Jan".
           03  PIC X(3) VALUE "Feb".
           03  PIC X(3) VALUE "Mar".
           03  PIC X(3) VALUE "Apr".
           03  PIC X(3) VALUE "May".
           03  PIC X(3) VALUE "Jun".
           03  PIC X(3) VALUE "Jul".
           03  PIC X(3) VALUE "Aug".
           03  PIC X(3) VALUE "Sep".
           03  PIC X(3) VALUE "Oct".
           03  PIC X(3) VALUE "Nov".
           03  PIC X(3) VALUE "Dec".

       01  MONTH-NAMES REDEFINES MONTH-TABLE.
           03  MONTH-NAME OCCURS 12 TIMES      PIC X(3).

       01  TODAYS-DATE.
           03  YEAR                            PIC 9999.
           03  MONTH                           PIC 99.
           03  TODAY                           PIC 99.

       77  LOWER-CASE                          PIC X(26) VALUE
           "abcdefghijklmnopqrstuvwxyz".
       77  UPPER-CASE                          PIC X(26) VALUE
           "ABCDEFGHIJKLMNOPQRSTUVWXYZ".

       COPY "def/acucobol.def".
       COPY "def/acugui.def".

       PROCEDURE DIVISION CHAINING MENU-FILE-NAME, OUT-FILE-NAME.
       DECLARATIVES.

       MENU-FILE-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON MENU-FILE.
       MENU-FILE-ERR.
           EXIT.

       OUT-FILE-ERROR SECTION.
           USE AFTER STANDARD ERROR PROCEDURE ON OUT-FILE.
       OUT-FILE-ERR.
           DISPLAY "*** OUTPUT FILE ERROR ", OUT-STATUS, " ***".
           SET HAS-ERRORS TO TRUE
           PERFORM SHUTDOWN.

       END DECLARATIVES.

       LEVEL-1 SECTION.
       MAIN-LOGIC.
           PERFORM INITIALIZATION.
           PERFORM GET-FILE-NAMES.

           OPEN INPUT MENU-FILE.
           IF NOT MENU-OK
               DISPLAY "*** CANNOT OPEN INPUT FILE, STATUS = ",
                       MENU-STATUS, " ***"
               SET HAS-ERRORS TO TRUE
               PERFORM SHUTDOWN.

           OPEN OUTPUT OUT-FILE WITH LOCK.

           PERFORM PARSE-MENU-LINE.
           PERFORM GENERATE-MENU-PARAGRAPH UNTIL NOT MENU-OK.

           CLOSE MENU-FILE, OUT-FILE.
           IF NOT QUIET-MODE
               DISPLAY QUOTE, OUT-FILE-NAME, LEFT, QUOTE, " generated".
           PERFORM SHUTDOWN.

       LEVEL-2 SECTION.
       GENERATE-MENU-PARAGRAPH.
           PERFORM PARSE-MENU-LINE
               UNTIL NOT MENU-OK OR
                   ( LINE-DOES-NOT-HAVE-TEXT AND NUM-WORDS = 2
                       AND PARSED-WORDS(1) = "MENU" OR "POPUP" ).

           IF MENU-OK
               IF PARSED-WORDS(2)( MENU-NAME-SIZE + 1 : ) NOT = SPACES
                   MOVE "Menu name too long" TO ERROR-MSG
                   PERFORM PARSING-ERROR-ROUTINE
               END-IF

               MOVE PARSED-WORDS(2) TO MENU-NAME
               IF PARSED-WORDS(1) = "POPUP"
                  SET POPUP-MENU TO TRUE
               ELSE
                  SET POPUP-MENU TO FALSE
               END-IF

               MOVE SPACES TO MENU-EXIT-NAME
               STRING 'GEN-', DELIMITED BY SIZE,
                      MENU-NAME, DELIMITED BY SPACES,
                      '-EXIT', DELIMITED BY SIZE INTO MENU-EXIT-NAME

               PERFORM WRITE-MENU-HEADER

               MOVE 1 TO MENU-DEPTH

               PERFORM HANDLE-NEXT-MENU-LINE
                    UNTIL NOT MENU-OK OR MENU-DEPTH = ZERO

               SET WANT-BLANK-LINE TO FALSE
               MOVE '.' TO AREA-B
               PERFORM WRITE-OUT-FILE
               PERFORM WRITE-BLANK-LINE
               STRING MENU-EXIT-NAME, DELIMITED BY SPACES,
                      '.', DELIMITED BY SIZE INTO AREA-A
               PERFORM WRITE-OUT-FILE
               MOVE SPACES TO OUT-LINE
               MOVE 'MOVE ZERO TO RETURN-CODE.' TO AREA-B
               PERFORM WRITE-OUT-FILE
               PERFORM WRITE-BLANK-LINE
           END-IF.

       HANDLE-NEXT-MENU-LINE.
           PERFORM PARSE-MENU-LINE.
           IF MENU-OK
               PERFORM HANDLE-MENU-LINE
           ELSE
               PERFORM UNTIL MENU-DEPTH = ZERO
                   IF WHEN-ACTIVE( MENU-DEPTH )
                       PERFORM END-WHEN-CONDITION
                   END-IF
                   SUBTRACT 1 FROM MENU-DEPTH
               END-PERFORM
           END-IF.

       HANDLE-MENU-LINE.
           IF WHEN-ACTIVE( MENU-DEPTH )
               PERFORM END-WHEN-CONDITION.

           EVALUATE TRUE
             WHEN LINE-DOES-NOT-HAVE-TEXT AND
                       ( PARSED-WORDS(1) = "MENU" OR "POPUP" OR
                         "END-MENU" OR "END-POPUP" )
                 IF ( PARSED-WORDS(1) = "MENU" OR "POPUP"
                             OR MENU-DEPTH = 1 )
                     PERFORM UNTIL MENU-DEPTH = ZERO
                         IF WHEN-ACTIVE( MENU-DEPTH )
                             PERFORM END-WHEN-CONDITION
                         END-IF
                         SUBTRACT 1 FROM MENU-DEPTH
                     END-PERFORM
                 ELSE
                     SUBTRACT 1 FROM MENU-DEPTH
                     SET WANT-BLANK-LINE TO TRUE
                 END-IF

             WHEN LINE-HAS-TEXT AND NUM-WORDS >= 1
                 IF WANT-BLANK-LINE
                     PERFORM WRITE-BLANK-LINE
                     SET WANT-BLANK-LINE TO FALSE
                 END-IF
                 MOVE 2 TO FIRST-FLAG-WORD
                 PERFORM COMPUTE-FLAGS
                 MOVE PARSED-WORDS(1) TO MENU-ID
                 IF SUB-MENU-WANTED
                     PERFORM WRITE-BLANK-LINE
                     IF WHEN-FLAG NOT = SPACES
                         PERFORM START-WHEN-CONDITION
                     END-IF
                     MOVE SPACES TO AREA-B
                     MOVE SOURCE-INDENT TO PARAM-PTR
                     STRING 'CALL "W$MENU" USING WMENU-NEW GIVING ',
                            DELIMITED BY SIZE,
                            HANDLE-NAME( MENU-DEPTH + 1 ),
                            DELIMITED BY SPACES,
                            INTO AREA-B WITH POINTER PARAM-PTR
                     PERFORM WRITE-OUT-FILE
                     MOVE SPACES TO AREA-B
                     MOVE SOURCE-INDENT TO PARAM-PTR
                     STRING 'IF ', DELIMITED BY SIZE,
                            HANDLE-NAME( MENU-DEPTH + 1 ),
                            DELIMITED BY SPACES,
                            ' = ZERO', DELIMITED BY SIZE
                            INTO AREA-B WITH POINTER PARAM-PTR
                     PERFORM WRITE-OUT-FILE
                     MOVE '    MOVE ZERO TO MENU-HANDLE' TO
                                         AREA-B( SOURCE-INDENT : )
                     PERFORM WRITE-OUT-FILE
                     MOVE SPACES TO AREA-B
                     MOVE SOURCE-INDENT TO PARAM-PTR
                     STRING '    GO TO ', DELIMITED BY SIZE,
                            MENU-EXIT-NAME, DELIMITED BY SPACES,
                            INTO AREA-B WITH POINTER PARAM-PTR
                     PERFORM WRITE-OUT-FILE
                     MOVE 'END-IF' TO AREA-B( SOURCE-INDENT : )
                     PERFORM WRITE-OUT-FILE
                     PERFORM WRITE-BLANK-LINE
                 ELSE
                     IF WHEN-FLAG NOT = SPACES
                         PERFORM START-WHEN-CONDITION
                     END-IF
                     IF MENU-ID = "0"
                         MOVE "Menu id may not be zero" TO ERROR-MSG
                         PERFORM PARSING-ERROR-ROUTINE
                     END-IF
                 END-IF
                 MOVE SPACES TO AREA-B
                 MOVE SOURCE-INDENT TO PARAM-PTR
                 STRING 'CALL "W$MENU" USING WMENU-ADD, ',
                                       DELIMITED BY SIZE,
                        HANDLE-NAME( MENU-DEPTH ), DELIMITED BY SPACES,
                        ', 0', DELIMITED BY SIZE INTO AREA-B
                        WITH POINTER PARAM-PTR
                 EVALUATE MENU-FLAGS
                   WHEN W-CHECKED
                       MOVE "W-CHECKED" TO PARAM-VALUE
                   WHEN W-DISABLED
                       MOVE "W-DISABLED" TO PARAM-VALUE
                   WHEN ZERO
                       MOVE "0" TO PARAM-VALUE
                   WHEN OTHER
                       MOVE 1 TO COUNTER
                       INSPECT MENU-FLAGS
                            TALLYING COUNTER FOR LEADING ZEROS
                       MOVE MENU-FLAGS( COUNTER : ) TO PARAM-VALUE
                 END-EVALUATE
                 PERFORM ADD-PARAM
                 STRING ',', DELIMITED BY SIZE INTO AREA-B
                        WITH POINTER PARAM-PTR
                 PERFORM WRITE-OUT-FILE
                 MOVE SPACES TO AREA-B
                 MOVE PARAM-OFFSET TO PARAM-PTR
                 INSPECT TEXT-FIELD REPLACING TRAILING
                                    SPACES BY LOW-VALUES
                 MOVE SPACES TO PARAM-VALUE
                 STRING '"', DELIMITED BY SIZE,
                        TEXT-FIELD, DELIMITED BY LOW-VALUES,
                        '"', DELIMITED BY SIZE INTO PARAM-VALUE
                 PERFORM ADD-PARAM
                 MOVE MENU-ID TO PARAM-VALUE
                 PERFORM ADD-PARAM
                 IF SUB-MENU-WANTED
                     MOVE HANDLE-NAME( MENU-DEPTH + 1 ) TO PARAM-VALUE
                     PERFORM ADD-PARAM
                 END-IF
                 PERFORM WRITE-OUT-FILE
                 IF SUB-MENU-WANTED
                     ADD 1 TO MENU-DEPTH
                 END-IF

             WHEN LINE-DOES-NOT-HAVE-TEXT AND
                       PARSED-WORDS(1) = "SEPARATOR"
                 IF WANT-BLANK-LINE
                     PERFORM WRITE-BLANK-LINE
                     SET WANT-BLANK-LINE TO FALSE
                 END-IF
                 MOVE 3 TO FIRST-FLAG-WORD
                 PERFORM COMPUTE-FLAGS
                 IF WHEN-FLAG NOT = SPACES
                      PERFORM START-WHEN-CONDITION
                 END-IF
                 MOVE SPACES TO AREA-B
                 MOVE SOURCE-INDENT TO PARAM-PTR
                 STRING 'CALL "W$MENU" USING WMENU-ADD, ',
                                       DELIMITED BY SIZE,
                        HANDLE-NAME( MENU-DEPTH ), DELIMITED BY SPACES,
                        ', 0', DELIMITED BY SIZE
                        INTO AREA-B WITH POINTER PARAM-PTR
                 MOVE 'W-SEPARATOR' TO PARAM-VALUE
                 PERFORM ADD-PARAM
                 IF NUM-WORDS > 1
                     MOVE 'NULL' TO PARAM-VALUE
                     PERFORM ADD-PARAM
                     MOVE PARSED-WORDS(2) TO PARAM-VALUE
                     PERFORM ADD-PARAM
                 END-IF
                 PERFORM WRITE-OUT-FILE

             WHEN OTHER
                 MOVE "Syntax error" TO ERROR-MSG
                 PERFORM PARSING-ERROR-ROUTINE

           END-EVALUATE.

           MOVE SPACES TO WHEN-FLAG.

       COMPUTE-FLAGS.
           MOVE ZERO TO MENU-FLAGS, SUB-MENU-FLAG.
           PERFORM VARYING WORD-IDX FROM FIRST-FLAG-WORD BY 1
                           UNTIL WORD-IDX > NUM-WORDS
               EVALUATE PARSED-WORDS( WORD-IDX )
                 WHEN "CHECKED"      ADD W-CHECKED TO MENU-FLAGS
                 WHEN "DISABLED"     ADD W-DISABLED TO MENU-FLAGS
                 WHEN "SUBMENU"      MOVE 1 TO SUB-MENU-FLAG
                 WHEN "WHEN"         IF WORD-IDX = NUM-WORDS
                                         MOVE "Missing WHEN condition"
                                                         TO ERROR-MSG
                                         PERFORM PARSING-ERROR-ROUTINE
                                     ELSE
                                         ADD 1 TO WORD-IDX
                                         MOVE PARSED-WORDS( WORD-IDX )
                                              TO WHEN-FLAG
                                     END-IF
                 WHEN OTHER          MOVE "Unknown flag" TO ERROR-MSG
                                     PERFORM PARSING-ERROR-ROUTINE
               END-EVALUATE
           END-PERFORM.

       START-WHEN-CONDITION.
           MOVE SPACES TO AREA-B.
           MOVE SOURCE-INDENT TO PARAM-PTR.
           STRING 'IF ', DELIMITED BY SIZE,
                  WHEN-FLAG, DELIMITED BY SPACES,
                  INTO AREA-B WITH POINTER PARAM-PTR.
           PERFORM WRITE-OUT-FILE.
           SET WHEN-ACTIVE( MENU-DEPTH ) TO TRUE.
           ADD 2 TO SOURCE-INDENT.
           MOVE SPACES TO AREA-B.

       END-WHEN-CONDITION.
           SUBTRACT 2 FROM SOURCE-INDENT.
           MOVE 'END-IF' TO AREA-B( SOURCE-INDENT : ).
           PERFORM WRITE-OUT-FILE.
           SET WHEN-ACTIVE( MENU-DEPTH ) TO FALSE.

       WRITE-MENU-HEADER.
           MOVE SPACES TO OUT-LINE.
           STRING '      * Build menu ', DELIMITED BY SIZE,
                  MENU-NAME, DELIMITED BY SPACES,
                  ' and return handle in MENU-HANDLE',
                             DELIMITED BY SIZE INTO OUT-LINE.
           PERFORM WRITE-OUT-FILE.
           ACCEPT TODAYS-DATE FROM CENTURY-DATE.
           MOVE SPACES TO OUT-LINE.
           STRING '      * Created by GENMENU on ', TODAY, '-',
                  MONTH-NAME( MONTH ), '-', YEAR, DELIMITED BY SIZE,
                  INTO OUT-LINE.
           PERFORM WRITE-OUT-FILE.
           MOVE SPACES TO OUT-LINE.
           STRING '      * Source file: "', DELIMITED BY SIZE,
                  MENU-FILE-NAME, DELIMITED BY SPACES,
                  '"', DELIMITED BY SIZE INTO OUT-LINE.
           PERFORM WRITE-OUT-FILE.
           PERFORM WRITE-BLANK-LINE.

           STRING 'BUILD-', DELIMITED BY SIZE,
                  MENU-NAME, DELIMITED BY SPACES,
                  '.', DELIMITED BY SIZE INTO AREA-A.
           PERFORM WRITE-OUT-FILE.
           MOVE SPACES TO OUT-LINE.
           STRING 'PERFORM GEN-', DELIMITED BY SIZE,
                  MENU-NAME, DELIMITED BY SPACES,
                  ' THRU ', DELIMITED BY SIZE,
                  MENU-EXIT-NAME, DELIMITED BY SPACES,
                  '.', DELIMITED BY SIZE INTO AREA-B.
           PERFORM WRITE-OUT-FILE.
           PERFORM WRITE-BLANK-LINE.
           STRING 'GEN-', DELIMITED BY SIZE,
                  MENU-NAME, DELIMITED BY SPACES,
                  '.', DELIMITED BY SIZE INTO AREA-A.
           PERFORM WRITE-OUT-FILE.

           MOVE SPACES TO OUT-LINE.
           IF POPUP-MENU
               MOVE 'CALL "W$MENU" USING WMENU-NEW-POPUP GIVING MENU-HAN
      -             'DLE' TO AREA-B
           ELSE
               MOVE 'CALL "W$MENU" USING WMENU-NEW GIVING MENU-HANDLE'
                  TO AREA-B
           END-IF
           PERFORM WRITE-OUT-FILE.
           MOVE 'IF MENU-HANDLE = ZERO' TO AREA-B.
           PERFORM WRITE-OUT-FILE.
           MOVE SPACES TO AREA-B.
           STRING '    GO TO ', DELIMITED BY SIZE,
                  MENU-EXIT-NAME, DELIMITED BY SPACES,
                  INTO AREA-B.
           PERFORM WRITE-OUT-FILE.
           MOVE 'END-IF' TO AREA-B.
           PERFORM WRITE-OUT-FILE.
           PERFORM WRITE-BLANK-LINE.

       PARSING SECTION.
       PARSE-MENU-LINE.
           PERFORM READ-NEXT-MENU-LINE.

           IF MENU-OK
               MOVE ZERO TO NUM-TOKENS, NUM-WORDS
               MOVE 1 TO SOURCE-PTR
               UNSTRING MENU-LINE DELIMITED BY QUOTES OR "'"
                        INTO LEADING-CHARS, TEXT-FIELD, TRAILING-CHARS
                        TALLYING NUM-TOKENS

               EVALUATE NUM-TOKENS
                 WHEN 3
                   SET LINE-HAS-TEXT TO TRUE
                   INSPECT TRAILING-CHARS REPLACING ALL "," BY SPACES
                                          ALL TAB-CHAR BY SPACES
                   INSPECT TRAILING-CHARS
                       TALLYING SOURCE-PTR FOR LEADING SPACES
                   UNSTRING TRAILING-CHARS DELIMITED BY ALL " "
                        INTO PARSED-WORDS(1), PARSED-WORDS(2),
                             PARSED-WORDS(3), PARSED-WORDS(4),
                             PARSED-WORDS(5), PARSED-WORDS(6)
                        POINTER SOURCE-PTR
                        TALLYING NUM-WORDS

                 WHEN 2
                   MOVE "Missing closing quote" TO ERROR-MSG
                   PERFORM PARSING-ERROR-ROUTINE

                 WHEN 1
                   SET LINE-DOES-NOT-HAVE-TEXT TO TRUE
                   INSPECT LEADING-CHARS REPLACING ALL "," BY SPACES
                                         ALL TAB-CHAR BY SPACES
                   INSPECT LEADING-CHARS
                       TALLYING SOURCE-PTR FOR LEADING SPACES
                   UNSTRING LEADING-CHARS DELIMITED BY ALL " "
                        INTO PARSED-WORDS(1), PARSED-WORDS(2),
                             PARSED-WORDS(3), PARSED-WORDS(4)
                             PARSED-WORDS(5), PARSED-WORDS(6)
                        POINTER SOURCE-PTR
                        TALLYING NUM-WORDS

               END-EVALUATE

               PERFORM VARYING WORD-IDX FROM 1 BY 1
                               UNTIL WORD-IDX > NUM-WORDS
                   INSPECT PARSED-WORDS( WORD-IDX ) CONVERTING
                           LOWER-CASE TO UPPER-CASE
               END-PERFORM
           END-IF.

       READ-NEXT-MENU-LINE.
           READ MENU-FILE.
           ADD 1 TO LINE-NUM.
           IF MENU-OK AND ( MENU-LINE = SPACES OR
                            MENU-LINE( 1 : 1 ) = "*" OR "#" )
               GO TO READ-NEXT-MENU-LINE.

       UTILITY SECTION.
       ADD-PARAM.
           IF PARAM-PTR > PARAM-OFFSET
               STRING ', ', DELIMITED BY SIZE, INTO AREA-B
                   WITH POINTER PARAM-PTR.
           MOVE ZERO TO COUNTER.
           INSPECT PARAM-VALUE TALLYING COUNTER FOR TRAILING SPACES.
           IF PARAM-PTR + MAX-PARAM-SIZE - COUNTER > 62
               PERFORM WRITE-OUT-FILE
               MOVE SPACES TO AREA-B
               MOVE PARAM-OFFSET TO PARAM-PTR.
           STRING PARAM-VALUE( 1 : MAX-PARAM-SIZE - COUNTER ),
                  DELIMITED BY SIZE INTO AREA-B
                  WITH POINTER PARAM-PTR.

       WRITE-OUT-FILE.
           WRITE OUT-LINE.
           SET LAST-LINE-BLANK TO FALSE.

       WRITE-BLANK-LINE.
           IF NOT LAST-LINE-BLANK
               MOVE SPACES TO OUT-LINE
               WRITE OUT-LINE
               SET LAST-LINE-BLANK TO TRUE.

       INITIALIZATION.
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.

       GET-FILE-NAMES.
           CALL "C$NARG" USING COUNTER.
           IF COUNTER < 1
               DISPLAY "Input menu file: ", NO ADVANCING
               ACCEPT MENU-FILE-NAME.
           IF COUNTER < 2
               DISPLAY "Output file: ", NO ADVANCING
               ACCEPT OUT-FILE-NAME.

       PARSING-ERROR-ROUTINE.
           DISPLAY ERROR-MSG, LEFT,
                   " - line ", LINE-NUM, CONVERT, LEFT,
                   " of ", QUOTE, MENU-FILE-NAME, LEFT, QUOTE.
           CLOSE MENU-FILE, OUT-FILE.
           DELETE FILE OUT-FILE.
           SET HAS-ERRORS TO TRUE.
           PERFORM SHUTDOWN.

       SHUTDOWN.
           IF HAS-GRAPHICAL-INTERFACE AND
                      ( HAS-ERRORS OR NOT QUIET-MODE )
               DISPLAY "Press return to exit: ", NO ADVANCING
               ACCEPT OMITTED, TAB.
           STOP RUN 0.

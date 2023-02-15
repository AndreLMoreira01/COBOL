       IDENTIFICATION DIVISION.
       PROGRAM-ID.  MENUBAR.
       DATE-WRITTEN.  01-Apr-90 - Drake Coker.
           26-Jun-90 - Added "T" option for timed menu input.
           10-Jun-92 - Added mouse support.

      * Copyright (c) 1990-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

       REMARKS.
           This program provides a generic menu bar processor.  It can
           support both "pop up" and static menu bars with "pop up"
           sub-menus.  It is designed to be called from any program that
           needs to use a menu bar.  It provides fairly complete menu bar
           support and contains several user-modifiable processing options.

           NOTE: the "W$MENU" library routine contained in ACUCOBOL-GT
           generally supercedes this program.  This program is provided
           for compatibility with earlier versions of ACUCOBOL, and
           because it is an interesting sample source.

           The program is called with three USING parameters: a command
           to execute, a structure describing the menu, and a variable
           to hold the menu selection return value.  The current commands
           available are:

               "D" - display a static menu bar
               "A" - accept a menu entry from the user
               "T" - same as "A" except times out
               "S" - set the global menu processing options
               "G" - get the current global menu processing options

           The menu structure is easier to use than to describe.  The
           following example shows a menu bar with two items on it.
           Each of these items contain "pop up" sub-menus.

      *01  MY-MENU.
      *    03  MENU-TYPE                       PIC X VALUE "S".
      *    03  MENU-ROW                        PIC 9(3) VALUE ZERO.
      *    03  MENU-COL                        PIC 9(3) VALUE ZERO.
      *    03  MENU-SIZE                       PIC 9(3) VALUE ZERO.
      *    03  NUM-MENU-ITEMS                  PIC 9(3) VALUE 10.

      *    03  PIC X(27) VALUE "  File".
      *    03  PIC 999 VALUE ZERO.
      *    03  PIC X(27) VALUE " >New".
      *    03  PIC 999 VALUE 101.
      *    03  PIC X(27) VALUE " >Open...".
      *    03  PIC 999 VALUE 102.
      *    03  PIC X(27) VALUE "X>Save".
      *    03  PIC 999 VALUE 103.
      *    03  PIC X(27) VALUE "X>Save As...".
      *    03  PIC 999 VALUE 104.
      *    03  PIC X(27) VALUE " |Quit".
      *    03  PIC 999 VALUE 105.

      *    03  PIC X(27) VALUE "  Modes".
      *    03  PIC 999 VALUE ZERO.
      *    03  PIC X(27) VALUE " >User Files Only".
      *    03  PIC 999 VALUE 201.
      *    03  PIC X(27) VALUE "+>All Files".
      *    03  PIC 999 VALUE 202.
      *    03  PIC X(27) VALUE " >Alphabetic List".
      *    03  PIC 999 VALUE 203.

           The MENU-TYPE field is either an "S" or a "P".  If it is an
           "S", then the menu bar is static.  It is initially displayed
           with the "display menu" command and it remains on the screen
           the entire time.  If MENU-TYPE is "P", then the menu "pops up"
           each time an entry is to be selected from it.  It is then
           removed when the selection is made.

           The MENU-ROW, MENU-COL and MENU-SIZE fields describe the size
           and location of the menu bar.  If these values are zero, then
           the menu bar will be placed along the top of the screen for the
           width of the entire screen.  The NUM-MENU-ITEMS value must be
           set to the number of entries that follow.  An entry represents
           either an item on the menu bar or an item in a sub-menu.

           Each menu item consists of two PIC X flags followed by a
           PIC X(25) legend.  As shown in the example above, you can
           combine the flags with the legend to make a single X(27)
           data item.  The legend is followed by a PIC 999 item that
           contains the value to return to the program when the
           corresponding menu item is selected.

           The first flag character is usually a space.  You can set it
           to "X" to disable that menu entry.  While disabled, the
           menu item cannot be selected by the user.  Alternately, you
           can set it to "+" to place a check mark by the menu entry.
           This is usually done with menu entries that are either "on"
           or "off" to indicate that the option is currently "on".  Only
           sub-menu entries can be checked.

           The second flag character is used to describe the menu
           structure.  If it is a space, then the menu item belongs
           on the top-level menu bar.  They show up in the order listed.
           If the flag character is a ">", then it shows up on a sub-menu
           belonging to the top-level item appearing above it.  In the
           example above, the last three menu items belong to a sub-menu
           under the menu entry "Modes".  Finally, the flag character
           can be "|".  When it is set to this, the menu item appears
           on a sub-menu (like ">"), but in addition, there is a
           separator bar appearing before it on the menu.  In the
           example above, there is a bar appearing between the sub-menu
           entries "Save As..." and "Quit".

           There are several processing options that can be set.  These
           are detailed in the MENU-OPTIONS group item below.  You can
           change the values given here to select different options.
           You can also use the "get options" and "set options" commands
           to change these at runtime.  When these commands are used,
           You pass a group-item with the same structure as MENU-OPTIONS
           as the second USING parameter.  This is copied to or from
           MENU-OPTIONS according to the command used.

           This program does not work correctly with "magic cookie"
           type terminals yet.  Also, not all combinations of the
           options have been thoroughly tested, so be careful when
           not using the default options.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CURSOR IS CUR-LOC
           CRT STATUS IS F-KEY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * The following controls several user-selectable options

       01  MENU-OPTIONS.

      * If the following value is "T", then a line is drawn between
      * the menu-bar and its sub-menus.
           03  SUB-MENU-FORMAT                 PIC X VALUE "T".
               88  USE-TOP-LINE                VALUE "T".
               88  NO-TOP-LINE                 VALUE SPACE.

      * If "A" is set, then sub-menus are entered immediately upon
      * reaching their top-level menu items.  If "L" is set, sub-menu
      * entry is done if the top-level item was reached by typing its
      * letter, otherwise you must select the top-level item to enter
      * its sub-menu.  If "S" is selected, then sub-menu entry only
      * occurs when you select the top-level item.  Note that once
      * sub-menus are entered, you automatically continue to select
      * sub-menus until a selection is made.
           03  SUB-MENU-ENTRY-MODE             PIC X VALUE "L".
               88  AUTOMATIC-SUB-MENU-ENTRY    VALUE "A".
               88  AUTOMATIC-LETTER-ENTRY      VALUE "L".
               88  SELECTION-ONLY-ENTRY        VALUE "S".

      * If "L" is set, then a menu selection can be immediately made
      * by typing its letter.  If "N" is set, then you must select
      * the current entry with the space bar or return key.  Typing a
      * letter in this case will take you to the menu item but it will
      * not select it.
           03  MENU-SELECTION-MODE             PIC X VALUE "L".
               88  AUTO-SELECT-BY-LETTER       VALUE "L".
               88  NO-AUTO-SELECTION           VALUE "N".

      * The following character is used to mark "checked" sub-menu
      * items.
           03  MARKER-CHARACTER                PIC X VALUE ">".

      * The following color values define the colors used for the
      * menu-bar, the sub-menus, the selection bar and disabled
      * menu items.  The first set are used on color terminals, the
      * second set is used on monochrome terminals.  These defaults
      * specify black on cyan for the menu bar and the sub-menus.
      * The selection bar is high-intensity white on blue.  And the
      * disabled entries are high-intensity black (a fuzzy gray) on cyan.
      * For monochrome terminals, everything is black on white except
      * for the selection bar which is the reverse of that.
           03  COLOR-TERMINAL-COLORS USAGE COMP-1.
               05  MENU-CLR                    PIC 9(4) VALUE 129.
               05  SUB-MENU-CLR                PIC 9(4) VALUE 129.
               05  SELECTION-CLR               PIC 9(4) VALUE 4168.
               05  DISABLED-CLR                PIC 9(4) VALUE 4225.
           03  MONO-TERMINAL-COLORS USAGE COMP-1.
               05  MENU-CLR                    PIC 9(4) VALUE 257.
               05  SUB-MENU-CLR                PIC 9(4) VALUE 257.
               05  SELECTION-CLR               PIC 9(4) VALUE 1024.
               05  DISABLED-CLR                PIC 9(4) VALUE 257.

       01  COLOR-TABLE USAGE COMP-1.
           03  MENU-COLOR                      PIC 9(4).
           03  SUB-MENU-COLOR                  PIC 9(4).
           03  SELECTION-COLOR                 PIC 9(4).
           03  DISABLED-COLOR                  PIC 9(4).

       01  MENU-WINDOW                         PIC X(10).
       01  SUB-MENU-WINDOW                     PIC X(10).
       01  IDX                                 PIC 9(3) COMP-1.
       01  LAST-IDX                            PIC 9(3) COMP-1.
       01  CURRENT-IDX                         PIC 9(3) COMP-1.
       01  SUB-IDX                             PIC 9(3) COMP-1.
       01  LAST-SUB-IDX                        PIC 9(3) COMP-1.
       01  TMP-COL                             PIC 9(3) COMP-1.
       01  XENTRY                              PIC X.
       01  NUM-TOP-ITEMS                       PIC 99.
       01  NUM-SUB-ITEMS                       PIC 99.
       01  WINDOW-WIDTH                        PIC 99.
       01  WINDOW-HEIGHT                       PIC 99.
       01  WINDOW-COL                          PIC 999.
       01  LINE-NO                             PIC S99.
       01  CURRENT-LINE-NO                     PIC S99.
       01  LAST-LINE-NO                        PIC 99.
       01  SUB-MENU-BASE-LINE                  PIC 9.
       01  MARKER                              PIC X.
       01  MENU-PADDING                        PIC 9.
       01  COLOR-VAL                           PIC 9(4) COMP-1.
       01  TIMEOUT-AMT                         PIC 9(5).

       01  SAVE-CURSOR-MODE                    PIC 9(1).
       01  CURSOR-OFF                          PIC X VALUE "2".

       01  CUR-LOC.
           03  CUR-ROW                         PIC 9(3).
           03  CUR-COL                         PIC 9(3).

       01  F-KEY                               PIC 9(3).
           88  LEFT-KEY                        VALUE 50.
           88  RIGHT-KEY                       VALUE 51.
           88  UP-KEY                          VALUE 52.
           88  DOWN-KEY                        VALUE 53.
           88  ESCAPE-KEY                      VALUE 27.
           88  TIMED-OUT                       VALUE 99.
           88  MOUSE-MOVED                     VALUE 100.
           88  BUTTON-PUSHED                   VALUE 101.
           88  BUTTON-RELEASED                 VALUE 102.

       01  TOP-LEVEL-TABLE.
           03  OCCURS 20 TIMES
               INDEXED BY COL-IDX, LAST-COL.
               05  TOP-COLUMN                  PIC 9(3).
               05  TOP-SIZE                    PIC 9(2).

       01  FILLER                              PIC X.
           88  SELECTION-MADE                  VALUE "Y", FALSE "N".

       01  FILLER                              PIC X.
           88  SUB-MENU-EXIT-REQUESTED         VALUE "Y", FALSE "N".

       01  FILLER                              PIC X.
           88  SUB-MENU-SELECTED               VALUE "Y", FALSE "N".

       01  FILLER                              PIC X.
           88  ALL-DISABLED                    VALUE "Y", FALSE "N".

       01  TERM-INFO.
           03  FILLER                          PIC X(15).
           03  FILLER                          PIC X.
               88  HAS-COLOR                   VALUE "Y".
           03  FILLER                          PIC X(4).
           03  SCREEN-WIDTH                    PIC 9(3).

       77  SAVE-MOUSE-FLAGS                    PIC 9(5).
       77  MOUSE-FLAGS                         PIC 9(5).

       COPY "def/acugui.def".

       LINKAGE SECTION.

       01  MENU-LAYOUT.
           03  MENU-TYPE                       PIC X.
               88  POP-UP-MENU                 VALUE "P".
               88  STATIC-MENU                 VALUE "S".
           03  MENU-ROW                        PIC 999.
           03  MENU-COL                        PIC 999.
           03  MENU-SIZE                       PIC 999.
           03  NUM-MENU-ITEMS                  PIC 999.
           03  MENU-ITEMS OCCURS 1 TO 500 TIMES
               DEPENDING ON NUM-MENU-ITEMS.
               05  MENU-ITEM-OPTION            PIC X.
                   88  MENU-ITEM-DISABLED      VALUE "X", FALSE SPACE.
                   88  MENU-ITEM-MARKED        VALUE "+", FALSE SPACE.
               05  MENU-LEVEL                  PIC X.
                   88  TOP-LEVEL-ITEM          VALUE SPACE.
                   88  POP-UP-ITEM             VALUES ">", "|".
                   88  SEPARATOR-BAR           VALUE "|".
               05  MENU-TEXT                   PIC X(25).
               05  MENU-SUB-FIELDS REDEFINES MENU-TEXT.
                   07  FILLER                  PIC X(5).
                   07  FILLER                  PIC X(5).
                       88  SCREEN-WIDTH-5      VALUE SPACES.
                   07  FILLER                  PIC X(5).
                       88  SCREEN-WIDTH-10     VALUE SPACES.
                   07  FILLER                  PIC X(5).
                       88  SCREEN-WIDTH-15     VALUE SPACES.
                   07  FILLER                  PIC X(5).
                       88  SCREEN-WIDTH-20     VALUE SPACES.
               05  MENU-VALUE                  PIC 999.

       01  PASSED-OPTIONS
           REDEFINES MENU-LAYOUT               PIC X(20).

       01  CALL-OPTION                         PIC X.
           88  DISPLAY-MENU                    VALUE "D".
           88  ACCEPT-MENU                     VALUES "A", "T".
           88  USE-TIMEOUT                     VALUE "T".
           88  SET-OPTIONS                     VALUE "S".
           88  GET-OPTIONS                     VALUE "G".

       01  SELECTION                           PIC 9(3).


       PROCEDURE DIVISION USING CALL-OPTION, MENU-LAYOUT, SELECTION.
       LEVEL-1 SECTION.
       MAIN-LOGIC.

           EVALUATE TRUE
               WHEN SET-OPTIONS
                   MOVE PASSED-OPTIONS TO MENU-OPTIONS
                   EXIT PROGRAM

               WHEN GET-OPTIONS
                   MOVE MENU-OPTIONS TO PASSED-OPTIONS
                   EXIT PROGRAM

           END-EVALUATE.

           PERFORM INITIALIZE-PGM.

           DISPLAY WINDOW LINE MENU-ROW, COLUMN MENU-COL,
               SIZE MENU-SIZE, LINES 1, POP-UP AREA MENU-WINDOW,
               NO WRAP, NO SCROLL, COLOR MENU-COLOR.

           EVALUATE TRUE
               WHEN ACCEPT-MENU
                   IF USE-TIMEOUT
                       MULTIPLY SELECTION BY 100 GIVING TIMEOUT-AMT
                   ELSE
                       MOVE ZERO TO TIMEOUT-AMT
                   END-IF
                   IF POP-UP-MENU
                       PERFORM SHOW-MAIN-MENU
                   END-IF
                   IF ALL-DISABLED
                       MOVE ZERO TO SELECTION
                   ELSE
                       PERFORM MENU-ENTRY
                   END-IF

               WHEN DISPLAY-MENU AND NOT POP-UP-MENU
                   PERFORM SHOW-MAIN-MENU

           END-EVALUATE.

       MAIN-LOGIC-EXIT.
           IF POP-UP-MENU
               CLOSE WINDOW MENU-WINDOW
           ELSE
               CLOSE WINDOW MENU-WINDOW, WITH NO DISPLAY.

           CALL "C$KEYMAP" USING "0".
           SET ENVIRONMENT "CURSOR-MODE" TO SAVE-CURSOR-MODE.
           SET ENVIRONMENT "MOUSE-FLAGS" TO SAVE-MOUSE-FLAGS.

           EXIT PROGRAM.


       LEVEL-2 SECTION.
       SHOW-MAIN-MENU.
           SET COL-IDX TO 1.
           MOVE ZERO TO NUM-TOP-ITEMS.
           SET ALL-DISABLED TO TRUE.
           DISPLAY SPACE, ERASE SCREEN, NO ADVANCING.
           MOVE 2 TO CUR-COL.
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX IS > NUM-MENU-ITEMS
               IF TOP-LEVEL-ITEM( IDX )
                   IF COL-IDX IS > 20
                       DISPLAY "TOO MANY MENU ITEMS", COLUMN 1
                       ACCEPT OMITTED
                       GO TO MAIN-LOGIC-EXIT
                   END-IF
                   MOVE CUR-COL TO TOP-COLUMN( COL-IDX )
                   IF MENU-ITEM-DISABLED( IDX )
                      MOVE DISABLED-COLOR TO COLOR-VAL
                   ELSE
                      MOVE ZERO TO COLOR-VAL
                      SET ALL-DISABLED TO FALSE
                   END-IF
                   DISPLAY " ", MENU-TEXT( IDX ), JUSTIFIED LEFT,
                           COLOR COLOR-VAL, " ", NO ADVANCING
      * The next two lines are a tricky way to compute the size of the
      * menu item less the trailing spaces.  The ACCEPT statement
      * immediately terminates but in the process it sets CUR-COL to
      * the current cursor location.
                   ACCEPT OMITTED, AUTO, NO ADVANCING
                   COMPUTE TOP-SIZE( COL-IDX ) =
                           CUR-COL - TOP-COLUMN( COL-IDX )
                   SET COL-IDX, NUM-TOP-ITEMS UP BY 1
               END-IF
           END-PERFORM.

       MENU-ENTRY.
           SET SELECTION-MADE, SUB-MENU-SELECTED TO FALSE.
           MOVE ZERO TO IDX, COL-IDX.
           PERFORM FIND-NEXT-TOP-LEVEL.

           PERFORM UNTIL SELECTION-MADE
               DISPLAY OMITTED, COLUMN TOP-COLUMN( COL-IDX ),
                       SIZE TOP-SIZE( COL-IDX ), COLOR SELECTION-COLOR
               MOVE IDX TO LAST-IDX
               MOVE COL-IDX TO LAST-COL
               IF IDX < NUM-MENU-ITEMS AND POP-UP-ITEM( IDX + 1 ) AND
                                               SUB-MENU-SELECTED
                   PERFORM HANDLE-SUB-MENU
               ELSE
                   IF TIMEOUT-AMT > ZERO
                       ACCEPT XENTRY, AUTO, UPPER, NO ECHO,
                           COLUMN TOP-COLUMN( COL-IDX ), SAME
                           BEFORE TIME TIMEOUT-AMT
                           ON EXCEPTION    PERFORM TOP-LEVEL-F-KEY
                           NOT EXCEPTION   PERFORM TOP-LEVEL-ENTRY
                       END-ACCEPT
                   ELSE
                       ACCEPT XENTRY, AUTO, UPPER, NO ECHO,
                           COLUMN TOP-COLUMN( COL-IDX ), SAME
                           ON EXCEPTION    PERFORM TOP-LEVEL-F-KEY
                           NOT EXCEPTION   PERFORM TOP-LEVEL-ENTRY
                       END-ACCEPT
                   END-IF
               END-IF
               IF IDX IS NOT = LAST-IDX OR SELECTION-MADE
                   DISPLAY OMITTED, COLUMN TOP-COLUMN( LAST-COL ),
                           SIZE TOP-SIZE( LAST-COL )
               END-IF
           END-PERFORM.

       HANDLE-SUB-MENU.
           PERFORM PAINT-SUB-MENU.
           IF NOT ALL-DISABLED
               PERFORM SUB-MENU-ENTRY.
           CLOSE WINDOW SUB-MENU-WINDOW.


       TOP-MENU-ROUTINES SECTION.
       TOP-LEVEL-F-KEY.
           EVALUATE TRUE
               WHEN RIGHT-KEY
                   PERFORM FIND-NEXT-TOP-LEVEL

               WHEN LEFT-KEY
                   PERFORM FIND-PREV-TOP-LEVEL

               WHEN DOWN-KEY
      *            SET SUB-MENU-SELECTED TO TRUE
                   MOVE ALL "9" TO SELECTION
                   SET SELECTION-MADE TO TRUE

               WHEN TIMED-OUT
               WHEN ESCAPE-KEY
                   MOVE ZERO TO SELECTION
                   SET SELECTION-MADE TO TRUE

               WHEN BUTTON-PUSHED
               WHEN MOUSE-MOVED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   IF MOUSE-ROW NOT = ZERO AND LBUTTON-DOWN
                       PERFORM FIND-TOP-MOUSE-ITEM
                   END-IF

               WHEN BUTTON-RELEASED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   IF MOUSE-ROW NOT = 0
                       IF IDX < NUM-MENU-ITEMS AND POP-UP-ITEM(IDX + 1)
                           CONTINUE
                       ELSE
                           MOVE MENU-VALUE( IDX ) TO SELECTION
                           SET SELECTION-MADE TO TRUE
                       END-IF
                   END-IF

           END-EVALUATE.

       TOP-LEVEL-ENTRY.
           IF XENTRY IS = SPACE
               IF IDX IS < NUM-MENU-ITEMS AND POP-UP-ITEM( IDX + 1 )
                   SET SUB-MENU-SELECTED TO TRUE
               ELSE
                   MOVE MENU-VALUE( IDX ) TO SELECTION
                   SET SELECTION-MADE TO TRUE
           ELSE
               MOVE IDX TO CURRENT-IDX
               PERFORM FIND-NEXT-TOP-LEVEL, WITH TEST AFTER,
                       UNTIL IDX IS = CURRENT-IDX
                          OR MENU-TEXT( IDX )( 1:1 ) IS = XENTRY
               IF IDX IS < NUM-MENU-ITEMS AND POP-UP-ITEM( IDX + 1 )
                               AND MENU-TEXT( IDX )( 1:1 ) IS = XENTRY
                   IF AUTOMATIC-LETTER-ENTRY
                       SET SUB-MENU-SELECTED TO TRUE
                   END-IF
               ELSE
                   IF AUTO-SELECT-BY-LETTER AND
                               MENU-TEXT( IDX )( 1:1 ) IS = XENTRY
                       MOVE MENU-VALUE( IDX ) TO SELECTION
                       SET SELECTION-MADE TO TRUE.


       FIND-NEXT-TOP-LEVEL.
           PERFORM, WITH TEST AFTER,
                    UNTIL IDX > NUM-MENU-ITEMS OR TOP-LEVEL-ITEM( IDX )
               SET IDX UP BY 1
           END-PERFORM.
           IF IDX > NUM-MENU-ITEMS
               MOVE 1 TO IDX, COL-IDX
           ELSE
               SET COL-IDX UP BY 1.
           IF MENU-ITEM-DISABLED( IDX )
               GO TO FIND-NEXT-TOP-LEVEL.
           IF AUTOMATIC-SUB-MENU-ENTRY
               SET SUB-MENU-SELECTED TO TRUE.

       FIND-PREV-TOP-LEVEL.
           PERFORM, WITH TEST AFTER,
                    UNTIL IDX < 1 OR TOP-LEVEL-ITEM( IDX )
               SET IDX DOWN BY 1
           END-PERFORM.
           IF IDX < 1
               COMPUTE IDX = NUM-MENU-ITEMS + 1
               COMPUTE COL-IDX = NUM-TOP-ITEMS + 1
               GO TO FIND-PREV-TOP-LEVEL
           ELSE
               SET COL-IDX DOWN BY 1.
           IF MENU-ITEM-DISABLED( IDX )
               GO TO FIND-PREV-TOP-LEVEL.
           IF AUTOMATIC-SUB-MENU-ENTRY
               SET SUB-MENU-SELECTED TO TRUE.


       FIND-TOP-MOUSE-ITEM.
           PERFORM VARYING TMP-COL FROM 1 BY 1
                   UNTIL TMP-COL > NUM-TOP-ITEMS OR
                         ( MOUSE-COL >= TOP-COLUMN( TMP-COL )
                           AND MOUSE-COL < TOP-COLUMN( TMP-COL )
                                         + TOP-SIZE( TMP-COL ) )
               CONTINUE
           END-PERFORM.
           IF TMP-COL <= NUM-TOP-ITEMS
               PERFORM FIND-NEXT-TOP-LEVEL UNTIL COL-IDX = TMP-COL
               IF IDX IS < NUM-MENU-ITEMS AND POP-UP-ITEM( IDX + 1 )
                   SET SUB-MENU-SELECTED TO TRUE
               ELSE
                   SET SUB-MENU-SELECTED TO FALSE
               END-IF
           END-IF.

       SUB-MENU-ROUTINES SECTION.
       PAINT-SUB-MENU.
           PERFORM COMPUTE-WINDOW-SIZE.
           COMPUTE WINDOW-COL = TOP-COLUMN( COL-IDX ) - 1.
           IF WINDOW-WIDTH + WINDOW-COL > MENU-SIZE
               COMPUTE WINDOW-COL = MENU-SIZE - WINDOW-WIDTH + 1.

           DISPLAY WINDOW, LINE 2, COLUMN WINDOW-COL,
               SIZE WINDOW-WIDTH, LINES WINDOW-HEIGHT,
               COLOR SUB-MENU-COLOR, NO SCROLL, NO WRAP,
               ERASE, POP-UP AREA IS SUB-MENU-WINDOW, SHADOW.

           IF USE-TOP-LINE
               DISPLAY LINE, SIZE WINDOW-WIDTH.
           DISPLAY LINE, LINES WINDOW-HEIGHT.
           DISPLAY LINE, LINE WINDOW-HEIGHT, SIZE WINDOW-WIDTH.
           DISPLAY LINE, COLUMN WINDOW-WIDTH, LINES WINDOW-HEIGHT.

           COMPUTE SUB-IDX = IDX + 1.
           MOVE SUB-MENU-BASE-LINE TO LINE-NO.
           SET ALL-DISABLED TO TRUE.
           PERFORM UNTIL SUB-IDX > NUM-MENU-ITEMS
                      OR TOP-LEVEL-ITEM( SUB-IDX )
               IF SEPARATOR-BAR( SUB-IDX )
                   DISPLAY LINE, LINE LINE-NO, SIZE WINDOW-WIDTH
                   ADD 1 TO LINE-NO
               END-IF
               DISPLAY OMITTED, LINE LINE-NO, COLUMN 2
               IF MENU-PADDING > ZERO
                   IF MENU-ITEM-MARKED( SUB-IDX )
                       DISPLAY MARKER-CHARACTER, NO ADVANCING
                   ELSE
                       DISPLAY SPACE, NO ADVANCING
                   END-IF
               END-IF
               IF MENU-ITEM-DISABLED( SUB-IDX )
                   MOVE DISABLED-COLOR TO COLOR-VAL
               ELSE
                   MOVE ZERO TO COLOR-VAL
                   SET ALL-DISABLED TO FALSE
               END-IF
               DISPLAY SPACE, MENU-TEXT( SUB-IDX ), LEFT,
                       COLOR COLOR-VAL, NO ADVANCING
               SET SUB-IDX, LINE-NO UP BY 1
           END-PERFORM.

       SUB-MENU-ENTRY.
           SUBTRACT 2 FROM WINDOW-WIDTH.
           SET SUB-MENU-EXIT-REQUESTED TO FALSE.
           COMPUTE LINE-NO = SUB-MENU-BASE-LINE - 1.
           MOVE IDX TO SUB-IDX.
           SET DOWN-KEY TO TRUE.
           PERFORM SUB-LEVEL-FKEY.

           PERFORM UNTIL SELECTION-MADE OR SUB-MENU-EXIT-REQUESTED
               DISPLAY OMITTED, LINE LINE-NO, COLUMN 2,
                       COLOR SELECTION-COLOR, SIZE WINDOW-WIDTH
               MOVE SUB-IDX TO LAST-SUB-IDX
               MOVE LINE-NO TO LAST-LINE-NO
               ACCEPT MARKER FROM SCREEN, LINE LINE-NO, COLUMN 2
               IF TIMEOUT-AMT > ZERO
                   ACCEPT XENTRY, AUTO, UPPER, LINE LINE-NO, COLUMN 2,
                       SAME, NO ECHO, BEFORE TIME TIMEOUT-AMT
                       ON EXCEPTION    PERFORM SUB-LEVEL-FKEY
                       NOT EXCEPTION   PERFORM SUB-LEVEL-ENTRY
                   END-ACCEPT
               ELSE
                   ACCEPT XENTRY, AUTO, UPPER, LINE LINE-NO, COLUMN 2,
                       SAME, NO ECHO
                       ON EXCEPTION    PERFORM SUB-LEVEL-FKEY
                       NOT EXCEPTION   PERFORM SUB-LEVEL-ENTRY
                   END-ACCEPT
               END-IF
               DISPLAY MARKER, LINE LAST-LINE-NO, COLUMN 2, SAME
               IF SUB-IDX IS NOT = LAST-SUB-IDX
                   DISPLAY OMITTED, LINE LAST-LINE-NO, COLUMN 2,
                           SIZE WINDOW-WIDTH
               END-IF
           END-PERFORM.


       COMPUTE-WINDOW-SIZE.
           MOVE ZERO TO NUM-SUB-ITEMS, MENU-PADDING.
           MOVE 5 TO WINDOW-WIDTH.
           MOVE SUB-MENU-BASE-LINE TO WINDOW-HEIGHT.
           COMPUTE SUB-IDX = IDX + 1.
           PERFORM UNTIL SUB-IDX > NUM-MENU-ITEMS
                      OR TOP-LEVEL-ITEM( SUB-IDX )
               EVALUATE TRUE
                   WHEN NOT SCREEN-WIDTH-20( SUB-IDX )
                       MOVE 25 TO WINDOW-WIDTH

                   WHEN NOT SCREEN-WIDTH-15( SUB-IDX ) AND
                            WINDOW-WIDTH < 20
                       MOVE 20 TO WINDOW-WIDTH

                   WHEN NOT SCREEN-WIDTH-10( SUB-IDX ) AND
                            WINDOW-WIDTH < 15
                       MOVE 15 TO WINDOW-WIDTH

                   WHEN NOT SCREEN-WIDTH-5( SUB-IDX ) AND
                            WINDOW-WIDTH < 10
                       MOVE 10 TO WINDOW-WIDTH
               END-EVALUATE
               IF SEPARATOR-BAR( SUB-IDX )
                   ADD 1 TO WINDOW-HEIGHT
               END-IF
               IF MENU-ITEM-MARKED( SUB-IDX )
                   MOVE 1 TO MENU-PADDING
               END-IF
               ADD 1 TO SUB-IDX, NUM-SUB-ITEMS
           END-PERFORM.
           ADD NUM-SUB-ITEMS TO WINDOW-HEIGHT.
           ADD 4, MENU-PADDING TO WINDOW-WIDTH.

       SUB-LEVEL-FKEY.
           EVALUATE TRUE
               WHEN UP-KEY
                   IF SEPARATOR-BAR( SUB-IDX )
                       SUBTRACT 1 FROM LINE-NO
                   END-IF
                   SUBTRACT 1 FROM SUB-IDX
                   IF TOP-LEVEL-ITEM( SUB-IDX )
                       ADD NUM-SUB-ITEMS TO SUB-IDX
                       COMPUTE LINE-NO = WINDOW-HEIGHT - 1
                   ELSE
                       SUBTRACT 1 FROM LINE-NO
                   END-IF
                   IF MENU-ITEM-DISABLED( SUB-IDX )
                       GO TO SUB-LEVEL-FKEY
                   END-IF

               WHEN DOWN-KEY
                   PERFORM NEXT-SUB-MENU-ITEM

               WHEN RIGHT-KEY
                   PERFORM FIND-NEXT-TOP-LEVEL
                   SET SUB-MENU-EXIT-REQUESTED TO TRUE

               WHEN LEFT-KEY
                   PERFORM FIND-PREV-TOP-LEVEL
                   SET SUB-MENU-EXIT-REQUESTED TO TRUE

               WHEN TIMED-OUT
               WHEN ESCAPE-KEY
                   MOVE ZERO TO SELECTION
                   SET SELECTION-MADE TO TRUE

               WHEN BUTTON-PUSHED
               WHEN MOUSE-MOVED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   IF LBUTTON-DOWN
                       EVALUATE MOUSE-ROW
                         WHEN ZERO
                               PERFORM CHECK-FOR-TOP-LEVEL-MOUSE
                         WHEN LINE-NO
                               CONTINUE
                         WHEN OTHER
                               MOVE LINE-NO TO CURRENT-LINE-NO
                               PERFORM NEXT-SUB-MENU-ITEM, TEST AFTER,
                                   UNTIL MOUSE-ROW = LINE-NO OR
                                         LINE-NO = CURRENT-LINE-NO
                       END-EVALUATE
                   END-IF

               WHEN BUTTON-RELEASED
                   CALL "W$MOUSE" USING GET-MOUSE-STATUS, MOUSE-INFO
                   IF MOUSE-ROW = LINE-NO
                       MOVE MENU-VALUE( SUB-IDX ) TO SELECTION
                       SET SELECTION-MADE TO TRUE
                   END-IF

           END-EVALUATE.

       SUB-LEVEL-ENTRY.
           IF XENTRY IS = SPACE
               MOVE MENU-VALUE( SUB-IDX ) TO SELECTION
               SET SELECTION-MADE TO TRUE
           ELSE
               MOVE SUB-IDX TO CURRENT-IDX
               PERFORM WITH TEST AFTER,
                       UNTIL SUB-IDX IS = CURRENT-IDX
                          OR ( MENU-TEXT( SUB-IDX )( 1:1 ) IS = XENTRY
                               AND NOT MENU-ITEM-DISABLED( SUB-IDX ) )
                   ADD 1 TO SUB-IDX, LINE-NO
                   IF SUB-IDX IS > NUM-MENU-ITEMS OR
                                   TOP-LEVEL-ITEM( SUB-IDX )
                       COMPUTE SUB-IDX = IDX + 1
                       MOVE SUB-MENU-BASE-LINE TO LINE-NO
                   END-IF
                   IF SEPARATOR-BAR( SUB-IDX )
                       ADD 1 TO LINE-NO
                   END-IF
               END-PERFORM
               IF AUTO-SELECT-BY-LETTER
                            AND MENU-TEXT( SUB-IDX )( 1:1 ) IS = XENTRY
                   MOVE MENU-VALUE( SUB-IDX ) TO SELECTION
                   SET SELECTION-MADE TO TRUE.

       NEXT-SUB-MENU-ITEM.
           ADD 1 TO SUB-IDX.
           IF SUB-IDX > NUM-MENU-ITEMS OR TOP-LEVEL-ITEM( SUB-IDX )
               COMPUTE SUB-IDX = IDX + 1
               MOVE SUB-MENU-BASE-LINE TO LINE-NO
           ELSE
               ADD 1 TO LINE-NO
               IF SEPARATOR-BAR( SUB-IDX )
                   ADD 1 TO LINE-NO
               END-IF
           END-IF
           IF MENU-ITEM-DISABLED( SUB-IDX )
               GO TO NEXT-SUB-MENU-ITEM.

       CHECK-FOR-TOP-LEVEL-MOUSE.
           CALL "W$MOUSE" USING GET-MOUSE-SCREEN-STATUS, MOUSE-INFO.
           IF MOUSE-ROW = 1
               SET CURRENT-IDX TO IDX
               PERFORM FIND-TOP-MOUSE-ITEM
               IF IDX NOT = CURRENT-IDX
                   SET SUB-MENU-EXIT-REQUESTED TO TRUE
               END-IF
           END-IF.

       INITIALIZE-PGM.
           IF USE-TOP-LINE
               MOVE 2 TO SUB-MENU-BASE-LINE
           ELSE
               MOVE 1 TO SUB-MENU-BASE-LINE.

      * Save current keyboard configuration and set return values for
      * the arrow keys.

           CALL "C$KEYMAP" USING "1".

           SET ENVIRONMENT "KEYSTROKE" TO "Exception=50 kl",
                           "KEYSTROKE" TO "Exception=51 kr",
                           "KEYSTROKE" TO "Exception=52 ku",
                           "KEYSTROKE" TO "Exception=53 kd".

      * Save the current cursor mode and make the cursor invisible.

           ACCEPT SAVE-CURSOR-MODE FROM ENVIRONMENT "CURSOR-MODE".
           SET ENVIRONMENT "CURSOR-MODE" TO CURSOR-OFF.

           ACCEPT SAVE-MOUSE-FLAGS FROM ENVIRONMENT "MOUSE-FLAGS".
           ADD ALLOW-LEFT-DOWN, ALLOW-LEFT-UP, ALLOW-MOUSE-MOVE,
                   ALLOW-ALL-SCREEN-ACTIONS GIVING MOUSE-FLAGS.
           SET ENVIRONMENT "MOUSE-FLAGS" TO MOUSE-FLAGS.

           ACCEPT TERM-INFO FROM TERMINAL-INFO.
           IF MENU-SIZE IS = ZERO
               MOVE SCREEN-WIDTH TO MENU-SIZE.
           IF HAS-COLOR
               MOVE COLOR-TERMINAL-COLORS TO COLOR-TABLE
           ELSE
               MOVE MONO-TERMINAL-COLORS TO COLOR-TABLE.

           MOVE ZEROS TO CUR-LOC.

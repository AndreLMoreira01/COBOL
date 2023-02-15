       IDENTIFICATION DIVISION.
       PROGRAM-ID.  MENUBAR2.
       DATE-WRITTEN.  20-Jun-92 - TDC.

      * Copyright (c) 1992-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

       REMARKS.
           This program provides a generic menu bar processor.  It can
           support both "pop up" and static menu bars with "pop up"
           sub-menus.  It is designed to be called from any program that
           needs to use a menu bar.  It provides fairly complete menu bar
           support and contains several user-modifiable processing options.

           NOTE: this program provides "MENUBAR.CBL" compatibility
           while using the "W$MENU" library routine.  It is intended
           to simplify the process of converting code that uses
           MENUBAR.CBL to code that uses W$MENU.  For new programs, you
           should use W$MENU directly.  See the ACUCOBOL-GT manual for
           instructions.  Also see GENMENU.CBL for an automatic code
           writer for using W$MENU.

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

           The MENU-ROW, MENU-COL and MENU-SIZE fields are provided for
           compatibility with MENUBAR.  They are not used in this program.

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
           MENU-OPTIONS according to the command used.  NOTE: the options
           have no effect in this program.  They are supported only for
           compatiblity with MENUBAR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * The following controls several user-selectable options
      * Note that MENUBAR2 does not currently support any of these options

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

       77  MENU-FLAGS                          PIC 9(4) COMP-4.
       77  TIMEOUT-AMT                         PIC S9(5).
       77  OLD-HANDLE                          PIC S9(9) COMP-4.
       77  TARGET-HANDLE                       PIC S9(9) COMP-4.
       77  ADDED-SUB-MENU                      PIC S9(9) COMP-4.

       77  FILLER                              PIC 9.
           88  ENTRY-OK                        VALUE 1, FALSE ZERO.

       01  SAVE-MENU-MODE                      PIC S9(4).
       01  SAVE-CURSOR-MODE                    PIC 9(1).
       78  CURSOR-OFF                          VALUE 2.
       78  ESCAPE-KEY                          VALUE 27.
       78  TIME-OUT                            VALUE 99.

       COPY "def/acugui.def".

       LINKAGE SECTION.

       01  MENU-LAYOUT.
           03  MENU-TYPE                       PIC X.
               88  POP-UP-MENU                 VALUE "P".
               88  STATIC-MENU                 VALUE "S".
           03  MENU-ROW                        PIC 999.
           03  MENU-COL                        PIC 999.
           03  MENU-SIZE                       PIC 999.
           03  MAKEMENU-LAYOUT.
               05  NUM-MENU-ITEMS              PIC 999.
               05  MENU-ITEMS OCCURS 1 TO 500 TIMES
                   DEPENDING ON NUM-MENU-ITEMS
                   INDEXED BY MENU-IDX.
                   07  MENU-ITEM-OPTION        PIC X.
                       88  MENU-ITEM-DISABLED  VALUE "X", FALSE SPACE.
                       88  MENU-ITEM-MARKED    VALUE "+", FALSE SPACE.
                   07  MENU-LEVEL              PIC X.
                       88  TOP-LEVEL-ITEM      VALUE SPACE.
                       88  POP-UP-ITEM         VALUES ">", "|".
                       88  SEPARATOR-BAR       VALUE "|".
                   07  MENU-TEXT               PIC X(25).
                   07  MENU-VALUE              PIC 999.

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

           MOVE ZERO TO MENU-HANDLE.

           CALL "W$MENU" USING WMENU-UNBLOCK.

           EVALUATE TRUE
               WHEN ACCEPT-MENU
                   IF USE-TIMEOUT
                       MULTIPLY SELECTION BY 100 GIVING TIMEOUT-AMT
                   ELSE
                       MOVE -1 TO TIMEOUT-AMT
                   END-IF
                   IF POP-UP-MENU
                       PERFORM SHOW-MAIN-MENU
                   END-IF
                   PERFORM MENU-ENTRY

               WHEN DISPLAY-MENU AND NOT POP-UP-MENU
                   PERFORM SHOW-MAIN-MENU

           END-EVALUATE.

       MAIN-LOGIC-EXIT.
           CALL "W$MENU" USING WMENU-BLOCK.
           EXIT PROGRAM 0.

       ERROR-EXIT.
           IF MENU-HANDLE NOT = ZERO
               CALL "W$MENU" USING WMENU-DESTROY, MENU-HANDLE.
           MOVE ZERO TO SELECTION.
           GO TO MAIN-LOGIC-EXIT.

       LEVEL-2 SECTION.
       SHOW-MAIN-MENU.
           PERFORM BUILD-MENU.

           CALL "W$MENU" USING WMENU-GET-MENU.
           MOVE RETURN-CODE TO OLD-HANDLE.

           CALL "W$MENU" USING WMENU-SHOW, MENU-HANDLE.

           IF OLD-HANDLE NOT = ZERO
               CALL "W$MENU" USING WMENU-DESTROY, OLD-HANDLE.

       MENU-ENTRY.
           ACCEPT SAVE-MENU-MODE FROM ENVIRONMENT "MENU-MODE".
           SET ENVIRONMENT "MENU-MODE" TO ZERO.
           ACCEPT SAVE-CURSOR-MODE FROM ENVIRONMENT "CURSOR-MODE".
           SET ENVIRONMENT "CURSOR-MODE" TO CURSOR-OFF.

           SET ENTRY-OK TO FALSE.
           PERFORM UNTIL ENTRY-OK
               ACCEPT OMITTED, TAB, LINE 1, BEFORE TIME TIMEOUT-AMT,
                 ON EXCEPTION
                   ACCEPT SELECTION FROM ESCAPE KEY
                   IF SELECTION = ESCAPE-KEY OR TIME-OUT
                       MOVE ZERO TO SELECTION
                       SET ENTRY-OK TO TRUE
                   ELSE
                       SET MENU-IDX TO 1
                       SEARCH MENU-ITEMS
                         WHEN MENU-VALUE( MENU-IDX ) = SELECTION AND
                                      NOT MENU-ITEM-DISABLED( MENU-IDX )
                               SET ENTRY-OK TO TRUE
                       END-SEARCH
                   END-IF
               END-ACCEPT
           END-PERFORM.

           SET ENVIRONMENT "CURSOR-MODE" TO SAVE-CURSOR-MODE.
           SET ENVIRONMENT "MENU-MODE" TO SAVE-MENU-MODE.

       MENU-BUILDING SECTION.
       BUILD-MENU.
           CALL "W$MENU" USING WMENU-NEW.
           MOVE RETURN-CODE TO MENU-HANDLE.
           IF RETURN-CODE = 0
               GO TO ERROR-EXIT.

           MOVE 1 TO MENU-IDX.
           PERFORM ADD-TOP-ITEM UNTIL MENU-IDX > NUM-MENU-ITEMS.

       ADD-TOP-ITEM.
           IF TOP-LEVEL-ITEM( MENU-IDX )
               MOVE MENU-HANDLE TO TARGET-HANDLE
               IF MENU-IDX = NUM-MENU-ITEMS OR
                           TOP-LEVEL-ITEM( MENU-IDX + 1 )
                   MOVE ZERO TO ADDED-SUB-MENU
                   PERFORM ADD-MENU-ITEM
               ELSE
                   CALL "W$MENU" USING WMENU-NEW
                   IF RETURN-CODE = 0
                       GO TO ERROR-EXIT
                   END-IF
                   MOVE RETURN-CODE TO ADDED-SUB-MENU
                   PERFORM ADD-MENU-ITEM
                   MOVE ADDED-SUB-MENU TO TARGET-HANDLE
                   MOVE ZERO TO ADDED-SUB-MENU
                   PERFORM UNTIL MENU-IDX = NUM-MENU-ITEMS
                                     OR TOP-LEVEL-ITEM( MENU-IDX + 1 )
                       ADD 1 TO MENU-IDX
                       PERFORM ADD-MENU-ITEM
                   END-PERFORM
               END-IF.

           ADD 1 TO MENU-IDX.

       ADD-MENU-ITEM.
           IF SEPARATOR-BAR( MENU-IDX )
               CALL "W$MENU" USING WMENU-ADD, TARGET-HANDLE, 0,
                                   W-SEPARATOR
               IF RETURN-CODE = ZERO
                   GO TO ERROR-EXIT.

           MOVE ZERO TO MENU-FLAGS.
           IF MENU-ITEM-DISABLED( MENU-IDX )
               ADD W-DISABLED TO MENU-FLAGS.
           IF MENU-ITEM-MARKED( MENU-IDX )
               ADD W-CHECKED TO MENU-FLAGS.
           CALL "W$MENU" USING WMENU-ADD, TARGET-HANDLE, 0,
                   MENU-FLAGS, MENU-TEXT( MENU-IDX ),
                   MENU-VALUE( MENU-IDX ), ADDED-SUB-MENU.
           IF RETURN-CODE = ZERO
               GO TO ERROR-EXIT.

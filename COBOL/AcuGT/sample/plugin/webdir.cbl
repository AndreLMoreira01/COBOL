IDENTIFICATION DIVISION.
PROGRAM-ID. WebDir IS INITIAL PROGRAM.
REMARKS.
     Presents the user with a list of websites & uses W$GETURL to load them.

ENVIRONMENT DIVISION.

INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT OPTIONAL Directory
    ASSIGN TO Directory-File-Name
    ORGANIZATION IS INDEXED ACCESS MODE IS DYNAMIC
    RECORD KEY IS Listing-ID
    LOCK MODE IS AUTOMATIC
    COMPRESSION 100
    FILE STATUS IS Directory-File-Status.

DATA DIVISION.
FILE SECTION.
FD Directory.
  01 Directory-Listing.
    03 Listing-ID                         PIC 9(6)    VALUE 0.
    03 Listing-Title                      PIC X(32)   VALUE SPACES.
    03 Listing-Text                       PIC X(1024) VALUE SPACES.
    03 Listing-URL                        PIC X(512)  VALUE SPACES.

WORKING-STORAGE SECTION.
**** modify remote-directory to point to the common data file on
**** _your_ server.
01 Remote-Directory                        pic x(40)
                       VALUE "@server:/usr/test/webdir.dat".
01 ws-file-prefix                          pic x(40).

01 Directory-Window                       HANDLE OF WINDOW.
01 Add-Listing-Window                     HANDLE OF WINDOW.

01 Directory-File-Name                    PIC X(512).
01 Directory-File-Status                  PIC X(2)    VALUE "00".
  88 Directory-File-OK                      VALUES "00" THRU "0Z".
  88 Directory-File-EOF                     VALUE  "10".
  88 Directory-File-Not-Found               VALUE  "35".
  88 Directory-File-Record-Not-Found        VALUE  "23".

01 Exc-Val IS SPECIAL-NAMES CRT STATUS    PIC 9(4) VALUE 0.
  88  User-Go                               VALUE 1001.
  88  User-Add                              VALUE 1002.
  88  User-Done                             VALUE 1003.
  88  User-About                            VALUE 1010.
  88  User-Cancel                           VALUE 2000.

01  Numeric-Scratch                       PIC 9(8)    VALUE 0.
01  Alphanum-Scratch                      PIC X(2048) VALUE SPACES.

01  URL-Target                            PIC X(32)   VALUE "_self".

01  Current-Row                           PIC 9(8)    VALUE 0.

01 file-info.
  03 file-size                            PIC X(8) COMP-X.
  03 file-date                            PIC 9(8) COMP-X.
  03 file-time                            PIC 9(8) COMP-X.
01 fileinfo-retval                        PIC 9(2) VALUE 99.
  88 file-exists                            VALUE 0.

78  newline                               value x"0A".

COPY "../def/acugui.def".
COPY "../def/acucobol.def".
COPY "../def/controls.def".
COPY "../def/crtvars.def".
SCREEN SECTION.
01 Directory-Screen.
  03  FRAME,
      LINE 1 COL 1,
      LINES 23 CELLS SIZE 80 CELLS,
      LOWERED ALTERNATE FULL-HEIGHT VERY-HEAVY.
  03  PUSH-BUTTON TITLE "&Go!",
        LINE 1.5 COL 2,
        SELF-ACT EXCEPTION-VALUE 1001.
  03  LABEL "Window:" COL PLUS 2.
  03  URL-Target-LB COMBO-BOX USING URL-Target,
        COL PLUS 2,
        3-D DROP-DOWN.
  03  PUSH-BUTTON TITLE "&Add Listing",
        COL PLUS 5,
        SIZE 14 CELLS
        SELF-ACT EXCEPTION-VALUE 1002.
  03  PUSH-BUTTON TITLE "A&bout",
        COL 72,
        SELF-ACT EXCEPTION-VALUE 1010.
  03  Listings GRID,
        LINE PLUS 2 COL 2,
        LINES 19 CELLS SIZE 78 CELLS
        3-D
        DATA-COLUMNS = (1,7,39,1063)
        COLUMN-HEADINGS CENTERED-HEADINGS TILED-HEADINGS,
        ROW-HEADINGS
        HEADING-COLOR = BCKGRND-WHITE, HEADING-DIVIDER-COLOR = BLACK,
        ADJUSTABLE-COLUMNS
        DISPLAY-COLUMNS = (1,8,32,1000)
        CURSOR-FRAME-WIDTH = 0
        EVENT PROCEDURE IS Grid-Event-Proc.

01 Add-Listing-Screen.
  03  LABEL "Add a listing:" LINE 1 COL 1.
  03  LABEL "ID: " LINE PLUS 1 COL 1.
  03  LABEL FROM Listing-ID COL PLUS 2.
  03  LABEL "Title: "
        LINE PLUS 2 COL 2.
  03  ENTRY-FIELD USING Listing-Title,
        3-D AUTO COL PLUS 2.
  03  LABEL "Text: "
        LINE PLUS 2 COL 2.
  03  ENTRY-FIELD USING Listing-Text,
        3-D AUTO COL PLUS 2.
  03  LABEL "URL: "
        LINE PLUS 2 COL 2.
  03  ENTRY-FIELD USING Listing-URL,
        3-D AUTO COL PLUS 2.
  03  PUSH-BUTTON TITLE "&Done",
        LINE PLUS 3 COL 4,
        OK-BUTTON
        SELF-ACT EXCEPTION-VALUE 1003.
  03  PUSH-BUTTON TITLE "&Cancel",
        COL PLUS 4,
        CANCEL-BUTTON,
        SELF-ACT EXCEPTION-VALUE 2000.


PROCEDURE DIVISION.
DECLARATIVES.
Directory-Error SECTION.
    USE AFTER STANDARD ERROR PROCEDURE ON Directory.
Directory-Err.
    DISPLAY MESSAGE BOX
       "File error on: ", Directory-File-Name, newline
       "Check that Acuserver is running, ", newline
       "this is a client-enabled runtime, and", newline
       "you have set up the permissions correctly.".
    STOP RUN.

END DECLARATIVES.

Main-Logic.
    PERFORM Initialize-WebDir.
    PERFORM Display-Directory.
    PERFORM Get-Action.
    PERFORM Shutdown-Directory.
    STOP RUN.

Initialize-WebDir.
    DISPLAY STANDARD WINDOW,
      LINES 22 SIZE 80,
      USER-GRAY BACKGROUND-LOW
      COLOR Black + Bckgrnd-White
      HANDLE IN Directory-Window.

    IF remote-directory(1:7)  = "@server" THEN
       ACCEPT ws-file-prefix FROM environment "FILE-PREFIX"
       IF ws-file-prefix = SPACES
           DISPLAY MESSAGE BOX
               "No remote server is set and no permision to write", newline
               "to the local drive is set in the acuauth.txt file.", newline
               "Program can't run.  Check out readme.txt."
           STOP RUN
       ELSE
           MOVE "webdir.dat" TO Directory-File-Name
       END-IF
    ELSE
       MOVE Remote-Directory TO Directory-File-Name
    END-IF.
    OPEN I-O Directory.

Shutdown-Directory.
    CLOSE Directory.
    DISPLAY MESSAGE BOX "Goodbye!".
    GOBACK.

Display-Directory.
    DISPLAY Directory-Screen UPON Directory-Window.
    MODIFY URL-Target-LB,
      RESET-LIST = 1
      ITEM-TO-ADD = "_self"
      ITEM-TO-ADD = "_new".

    PERFORM Initialize-Listings-Grid.

    SET Listing-ID TO 1.
    READ Directory WITH NO LOCK
      INVALID KEY PERFORM Seed-New-Directory
    END-READ.

    SET Listing-ID TO 1.

    PERFORM UNTIL Directory-File-EOF OR Directory-File-Not-Found
      READ Directory WITH NO LOCK
        INVALID KEY EXIT PERFORM
      END-READ
      MODIFY Listings, RECORD-TO-ADD = Directory-Listing
      ADD 1 TO Listing-ID
    END-PERFORM.

    MODIFY Listings, Y=2
            ROW-COLOR Bright-White + Bckgrnd-Blue.

Initialize-Listings-Grid.
    MODIFY Listings, RESET-GRID = 1,
        Y = 1
        X = 1 CELL-DATA = "ID"          ALIGNMENT="l"
        X = 2 CELL-DATA = "Title"       ALIGNMENT="l"
        X = 3 CELL-DATA = "Description" ALIGNMENT="l"
        X = 4 CELL-DATA = "URL"         ALIGNMENT="l".

Get-Action.
    PERFORM UNTIL 1=0
      DISPLAY Directory-Screen UPON Directory-Window
      ACCEPT Directory-Screen
        ON EXCEPTION CONTINUE
      END-ACCEPT
      EVALUATE TRUE
        WHEN User-Done        EXIT PERFORM
        WHEN User-Go          PERFORM Go-To-Listing
        WHEN User-Add         PERFORM Add-Listing
        WHEN User-About       PERFORM Display-About-Box
      END-EVALUATE
    END-PERFORM.

Add-Listing.
    INITIALIZE Directory-Listing.
    DISPLAY FLOATING WINDOW,
      LINES 15 SIZE 60
      BACKGROUND-LOW USER-GRAY
      HANDLE IN Add-Listing-Window
      TITLE "Adding a listing...".

    SET Listing-ID TO 1.
    READ Directory WITH NO LOCK.

    PERFORM UNTIL Directory-File-Record-Not-Found
      ADD 1 TO Listing-ID
      READ Directory WITH NO LOCK
        INVALID KEY EXIT PERFORM
      END-READ
    END-PERFORM.

    INITIALIZE Listing-Text, Listing-Title, Listing-URL.

    DISPLAY Add-Listing-Screen
    ACCEPT Add-Listing-Screen UNTIL User-Done OR User-Cancel
    IF User-Done AND Listing-URL NOT = SPACES
      WRITE Directory-Listing
      PERFORM Display-Directory
    END-IF

    DESTROY Add-Listing-Window.

Go-To-Listing.
    INITIALIZE Numeric-Scratch, Directory-Listing.

    INQUIRE Listings CURSOR-Y IN Numeric-Scratch.
    IF numeric-scratch = -1 THEN EXIT PARAGRAPH.

    MODIFY Listings Y=Numeric-Scratch, X=1
    INQUIRE Listings CELL-DATA IN Listing-ID.
    READ Directory WITH NO LOCK.

    INITIALIZE Alphanum-Scratch.
    STRING "WEBDIR loading "  DELIMITED BY SIZE
           Listing-Title
           " ("
           Listing-Text
           ")"                DELIMITED BY "  "
           INTO Alphanum-Scratch.

    CALL "W$GETURL" USING Listing-URL, URL-Target.
    CALL "W$STATUS" USING Alphanum-Scratch.


Grid-Event-Proc.
    EVALUATE Event-Type
      WHEN MSG-BEGIN-ENTRY
        SET EVENT-ACTION TO EVENT-ACTION-FAIL
      WHEN MSG-HEADING-CLICKED
      WHEN MSG-GOTO-CELL-DRAG
      WHEN MSG-GOTO-CELL
      WHEN MSG-GOTO-CELL-MOUSE
        IF Event-Data-2 = 1 THEN
          SET EVENT-ACTION TO EVENT-ACTION-FAIL
        ELSE
          INQUIRE Listings CURSOR-Y IN Current-Row
          MODIFY Listings,
            Y = Current-Row
            ROW-COLOR = 0
            Y = Event-Data-2
            ROW-COLOR = Bright-White + Bckgrnd-Blue
            CURSOR-X = 2, CURSOR-Y = Event-Data-2
        END-IF
    END-EVALUATE.

Seed-New-Directory.
    SET Listing-ID TO 1.
    MOVE "Acucorp" TO Listing-Title.
    MOVE "Homepage of Acucorp, Inc." TO Listing-Text.
    MOVE "http://www.acucorp.com/" TO Listing-URL.
    WRITE Directory-Listing.
    SET Listing-ID TO 2.
    MOVE "WebDir Feedback" TO Listing-Title.
    MOVE "E-Mail Acucorp Tech support about WebDir" TO Listing-Text.
    MOVE "mailto:support@acucorp.com?subject=Webdir" TO Listing-URL.
    WRITE Directory-Listing.


Display-About-Box.
    DISPLAY MESSAGE BOX
      "WebDirectory Sample Program v1.0", newline,
      "Copyright (c) 1998-2006 Acucorp, Inc.".

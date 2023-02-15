
IDENTIFICATION              DIVISION.
PROGRAM-ID. WebService.
AUTHOR. jlynch.
DATE-WRITTEN. Friday, October 03, 2003 10:37:02 AM.
REMARKS.
ENVIRONMENT                 DIVISION.
CONFIGURATION               SECTION.
SPECIAL-NAMES.
        COPY "def/WEBCLIENT2.def".
        COPY "def/acuclass.def".
        .
INPUT-OUTPUT                SECTION.
FILE-CONTROL.
DATA                        DIVISION.
FILE                        SECTION.
WORKING-STORAGE             SECTION.
        COPY "def/acugui.def".
	COPY "def/acucobol.def".
	COPY "def/crtvars.def".
	COPY "def/showmsg.def".
      
77 Quit-Mode-Flag PIC S9(5) COMP-1 VALUE 0. 
77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.

77 Form1-Handle USAGE IS HANDLE OF WINDOW.
77 SERVICE-HANDLE           USAGE HANDLE.
77 MSG-STRING               PIC X(256) VALUE SPACES.

      
SCREEN                      SECTION.
01 Form1.
    03 SERVICE-MESSAGES, List-Box, 
              COL 2.00, LINE 3.00, LINES 15.00 CELLS, SIZE 48.00 CELLS, 
              3-D, ID IS 1, MASS-UPDATE 0, UNSORTED, 
              VALUE MSG-STRING, ITEM_TO_ADD = MSG-STRING.
              
PROCEDURE DIVISION.
      
Acu-Main-Logic.
      
           PERFORM Acu-Initial-Routine
           PERFORM Acu-Form1-Routine
           PERFORM Acu-Exit-Rtn
	   .
	    
Acu-Initial-Routine.

           ACCEPT System-Information FROM System-Info
           ACCEPT Terminal-Abilities FROM Terminal-Info
           .

Acu-Exit-Rtn.

           DESTROY SERVICE-HANDLE.
           EXIT PROGRAM
           STOP RUN
           .

Acu-Form1-Routine.

           PERFORM Acu-Form1-Scrn
           PERFORM Acu-Form1-Proc
           .

Acu-Form1-Scrn.
           PERFORM Acu-Form1-Create-Win
           PERFORM Acu-Form1-Init-Data
           .
Acu-Form1-Create-Win.
      
 
              DISPLAY Standard GRAPHICAL WINDOW
                 LINES 18.00, SIZE 50.00, CELL HEIGHT 10, 
                 CELL WIDTH 10, AUTO-MINIMIZE, AUTO-RESIZE, 
                 COLOR IS 65793, ERASE, LABEL-OFFSET 0, LINK TO THREAD, 
                 MODELESS, NO SCROLL, WITH SYSTEM MENU, 
                 TITLE "Web Service Sample II", TITLE-BAR, NO WRAP, 
                 EVENT PROCEDURE Form1-Event-Proc, 
                 HANDLE IS Form1-Handle

           DISPLAY Form1 UPON Form1-Handle
           .

Acu-Form1-Init-Data.
	    
	    CREATE "WebClient2" NAMESPACE IS "WebClient2"
                     CLASS-NAME IS "WebClient2"
                     EVENT PROCEDURE ACU-SERVICE-EVENTS
                     HANDLE IS SERVICE-HANDLE.

            MODIFY SERVICE-HANDLE "TalkToService"().
           .
           
ACU-SERVICE-EVENTS.

    EVALUATE EVENT-TYPE
      WHEN MSG-NET-EVENT
        EVALUATE EVENT-DATA-2
              WHEN @WebClient2_fireCounter
                CALL "C$GETNETEVENTDATA" USING @WebClient2_fireCounter MSG-STRING
                DISPLAY SERVICE-MESSAGES                                                                                 
        END-EVALUATE
    END-EVALUATE.

Acu-Form1-Proc.

           PERFORM UNTIL Exit-Pushed
              ACCEPT Form1  
                 ON EXCEPTION PERFORM Acu-Form1-Evaluate-Func
              END-ACCEPT
           END-PERFORM
           DESTROY Form1-Handle
           INITIALIZE Key-Status
           .
           
Acu-Form1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Exit-Pushed
                 PERFORM Acu-Form1-Exit
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Form1-Exit
                 END-IF
           END-EVALUATE

           MOVE 1 TO Accept-Control
           . 

Acu-Form1-Exit.
           SET Exit-Pushed TO TRUE
           .

Acu-Form1-Event-Extra.
           EVALUATE Event-Type
           WHEN Msg-Close
              PERFORM Acu-Form1-Msg-Close
           END-EVALUATE
           .

Acu-Form1-Msg-Close.
           ACCEPT Quit-Mode-Flag FROM ENVIRONMENT "QUIT_MODE"
           IF Quit-Mode-Flag = ZERO
              PERFORM Acu-Form1-Exit
              PERFORM Acu-Exit-Rtn
           END-IF
           .

Form1-Event-Proc.
           PERFORM Acu-Form1-Event-Extra
           .

identification division.
program-id.  NetQATest1.
date-written.  22-May-03
environment division.
configuration section.
special-names.
copy "def/NetQATest1.def".
	.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 screen-1-Handle HANDLE OF WINDOW.
* 77 ctl-handle       USAGE IS HANDLE.
77 RETURN-TEXT                   pic x(30) VALUE SPACES.
77 CTOR-PARM1	    pic x(8) VALUE "YO STUFF".
77 CTOR-PARM2	    USAGE IS SIGNED-INT VALUE 1111.
77 CTOR-PARM3	    USAGE IS UNSIGNED-INT VALUE 2222.
77 CTOR-PARM4	    USAGE IS FLOAT VALUE 0.3333.
77 CTOR-PARM5	    USAGE IS DOUBLE VALUE 123456.55.
77 CTOR-PARM6       pic x VALUE 'A'.
77 CTOR-PARM7	    USAGE IS SIGNED-SHORT VALUE 4444.
77 CTOR-PARM8	    USAGE IS UNSIGNED-SHORT VALUE 5555.

77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
           88 Exit-Pushed VALUE 27.
           88 Message-Received VALUE 95.
           88 Event-Occurred VALUE 96.
           88 Screen-No-Input-Field VALUE 97.
           88 Screen-Time-Out VALUE 99.
 
COPY "def/acucobol.def".                
COPY "def/acugui.def".
COPY "def/crtvars.def".

screen section.
01  screen-1.
    03  ctl-handle "NetQATest1_CS",
        LINE 1, COL 2,
	NAMESPACE IS "NetQATest1_CS",
	CLASS-NAME IS "UserControl1",
        CONSTRUCTOR IS CONSTRUCTOR2(CTOR-PARM1, CTOR-PARM2, CTOR-PARM3, CTOR-PARM4, CTOR-PARM5, CTOR-PARM6, CTOR-PARM7, CTOR-PARM8, CTOR-PARM6),
	EVENT PROCEDURE IS USERCONTROL-EVENTS.

    03  Screen1-LOG-Field, entry-field line 20 col 3,
            value RETURN-TEXT,
            max-text 30. 
    03  push-button line 23 col 10,
        exception-value 27 title "E&xit" cancel-button self-act.
    
	    
procedure division.
main-logic.
    ACCEPT System-Information FROM System-Info.
    ACCEPT Terminal-Abilities FROM Terminal-Info.
    DISPLAY Standard graphical WINDOW
        LINES 25.00, SIZE 26.00, CELL HEIGHT 10, CELL WIDTH 10, 
        AUTO-MINIMIZE, COLOR IS 65793, LABEL-OFFSET 0,
        NO SCROLL, WITH SYSTEM MENU, AUTO-RESIZE, 
        TITLE "Test .NET Composite Control", TITLE-BAR, NO WRAP,
 	HANDLE IS screen-1-Handle.
 	
    display screen-1 UPON screen-1-Handle.
* commented out sample DISPLAY statement below is the same as screen entry 03 "NetQATest1_CS".    	
*DISPLAY "@NetQATest1_CS",
*        LINE 1, COL 2,
*	NAMESPACE IS "NetQATest1_CS",
*	CLASS-NAME IS "UserControl1",
*	EVENT PROCEDURE IS USERCONTROL-EVENTS,
*	HANDLE IS ctl-handle. 
    
    INITIALIZE Key-Status.
    
    PERFORM UNTIL Exit-Pushed
       ACCEPT screen-1
        ON EXCEPTION PERFORM Acu-Screen1-Evaluate-Func
       END-ACCEPT
    END-PERFORM.
                
Acu-Screen1-Evaluate-Func.
           EVALUATE TRUE
              WHEN Event-Occurred
                 IF Event-Type = Cmd-Close
                    PERFORM Acu-Screen1-Exit
                 END-IF
           END-EVALUATE
           MOVE 1 TO Accept-Control.

USERCONTROL-EVENTS.
    EVALUATE EVENT-TYPE
      WHEN MSG-NET-EVENT
        EVALUATE EVENT-DATA-2
              WHEN @UserControl1_raiseAnimalCar
		PERFORM display-update                                                                                          
        END-EVALUATE
    END-EVALUATE.
 
 display-update.    
    
*   CALL "C$GETNETEVENTDATA" USING EVENT-DATA-2 RETURN-TEXT.
    CALL "C$GETNETEVENTDATA" USING @UserControl1_raiseAnimalCar RETURN-TEXT.
*   CALL "C$GETNETEVENTDATA" USING EVENT-CONTROL-HANDLE RETURN-TEXT. 
    DISPLAY Screen1-LOG-Field.
 
Acu-Screen1-Exit.

    DESTROY ctl-handle.   
    DESTROY screen-1-Handle.
    exit program.
    stop run.
           
    

identification division.
program-id.  Amort.
date-written.  22-May-03
environment division.
configuration section.
special-names.
copy "def/amortcontrol.def".
	.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 screen-1-Handle HANDLE OF WINDOW.
77 RETURN-TEXT                   pic x(30) VALUE SPACES.
77 MONTH-PAY                     Pic x(12).
77 TOT-INTEREST                  Pic x(12).
77 TOT-PAYMENT                   Pic x(12).
77 WHAT-MONTHS                   Pic x(12).
77 WHAT-TOT-INTEREST             Pic x(12).
77 WHAT-TOT-PAYMENT              Pic x(12).
 
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
    03  ctl-handle, "AmortControl",
        NAMESPACE IS "AmortControl",
	CLASS-NAME IS "UserControl1",
	LINE 1, COL 2,
	EVENT PROCEDURE IS USERCONTROL-EVENTS.
    03  LABEL "Month-Amt" line 35, col 4.
    03  LABEL "Tot-Pay" line 35, col 19.
    03  LABEL "Tot-Interest" line 35, col 32.
    03  LABEL "What-Months" line 35, col 47.
    03  LABEL "What-Tot-Pay" line 35, col 62.
    03  LABEL "What-Tot-Interest", line 35, col 76.	
    03  month-amt, entry-field line 37, col 2,
	    READ-ONLY,
            value MONTH-PAY.
    03  tot-pay, entry-field line 37, col 16,
	    READ-ONLY,
            value TOT-PAYMENT.
    03  tot-int, entry-field line 37, col 30,
    	    READ-ONLY,
            value TOT-INTEREST.
    03  what-month, entry-field line 37, col 46,
    	    READ-ONLY,
            value WHAT-MONTHS.
    03  what-tot-pay, entry-field line 37, col 61,
    	    READ-ONLY,
            value WHAT-TOT-PAYMENT.
    03  what-tot-int, entry-field line 37, col 77,
    	    READ-ONLY,
            value WHAT-TOT-INTEREST.
    03  push-button line 36, col 98,
        exception-value 27 title "E&xit" cancel-button self-act.
    
	    
procedure division.
main-logic.
    ACCEPT System-Information FROM System-Info.
    ACCEPT Terminal-Abilities FROM Terminal-Info.
    DISPLAY Standard graphical WINDOW
        LINES 38.00, SIZE 108.00, 
        AUTO-MINIMIZE, COLOR IS 65793,
        WITH SYSTEM MENU, 
        TITLE "Test .NET Amortization Control", TITLE-BAR, NO WRAP,
 	HANDLE IS screen-1-Handle.
 	
    display screen-1 UPON screen-1-Handle.
    
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
              WHEN @UserControl1_FireCalc
		PERFORM display-update                                                                                          
        END-EVALUATE
    END-EVALUATE.
 
 display-update.    
   
    INQUIRE ctl-handle TotalInterest IN TOT-INTEREST.
    INQUIRE ctl-handle TotalPayment  IN TOT-PAYMENT.
    INQUIRE ctl-handle MonthPayment  IN MONTH-PAY.
    INQUIRE ctl-handle WhatIfTotalInterest IN WHAT-TOT-INTEREST.
    INQUIRE ctl-handle WhatIfTotalPayment  IN WHAT-TOT-PAYMENT.
    INQUIRE ctl-handle WhatIfMonths        IN WHAT-MONTHS.
    DISPLAY month-amt.
    DISPLAY tot-pay.
    DISPLAY tot-int.
    DISPLAY what-month.
    DISPLAY what-tot-pay.
    DISPLAY what-tot-int.
 
Acu-Screen1-Exit.

    DESTROY ctl-handle.   
    DESTROY screen-1-Handle.
    exit program.
    stop run.
           
    

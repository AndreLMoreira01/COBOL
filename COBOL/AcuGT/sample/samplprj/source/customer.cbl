       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CUSTOMER.
      * COPYRIGHT (C) 1996-2006 BY ACUCORP, INC.  USERS OF ACUCOBOL
      * MAY FREELY MODIFY AND REDISTRIBUTE THIS PROGRAM.
       REMARKS.
           THIS PROGRAM READS THRU A CUSTOMER FILE, UNTIL THE EXIT 
           BUTTON IS PRESSED.  IT WAS DEVELOPED USING SCREENS
           AND COPYFILES GENERATED BY THE ACUBENCH SCREEN PAINTER. 
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
      *{Bench}activex-def
      *{Bench}end
       INPUT-OUTPUT SECTION.   
       FILE-CONTROL.
      *{Bench}file-control
       COPY "CUSTOMER-FILE.sl".
      *{Bench}end
       DATA DIVISION.
       FILE SECTION.
      *
      *{Bench}file
       COPY "CUSTOMER-FILE.fd".
      *{Bench}end
       WORKING-STORAGE SECTION.
      *{Bench}acu-def
       COPY "acugui.def".
       COPY "acucobol.def".
       COPY "crtvars.def".
       COPY "showmsg.def".
      *{Bench}end
       COPY "FONTS.DEF".
      *
       77  MB-VALUE                            PIC 9 VALUE 0.
      *   
       COPY RESOURCE "SMPL-ARROWS.BMP".
      *
      *{Bench}copy-working
       COPY "customer.wrk".
      *{Bench}end
       LINKAGE SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN SECTION.
      *{Bench}copy-screen
       COPY "customer.scr".
      *{Bench}end
       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM INITIALIZATIONS.

           PERFORM UNTIL EXIT-BUTTON-PUSHED
             ACCEPT CUST-SCREEN 
               ON EXCEPTION CONTINUE
             END-ACCEPT
           END-PERFORM.  
           
           PERFORM Acu-Close-Files.

           STOP RUN.
      *    
       INITIALIZATIONS.    
      * DISPLAY INITIAL WINDOW     
            PERFORM Acu-Initial-Routine.
            PERFORM Acu-Cust-Screen-Scrn.

      * READ FILE AND DISPLAY SCREEN  
           PERFORM Acu-Customer-Read-Next.
      *          
       UPDATE-RECORD-FIELDS.
           MOVE WS-CUSTOMER-NAME TO CUSTOMER-NAME.
           MOVE WS-CUSTOMER-ADDR-1 TO CUSTOMER-ADDR-1.
           MOVE WS-CUSTOMER-ADDR-2 TO CUSTOMER-ADDR-2.
           MOVE WS-CUSTOMER-CITY TO CUSTOMER-CITY.
           MOVE WS-CUSTOMER-STATE TO CUSTOMER-STATE.
           MOVE WS-CUSTOMER-ZIP TO CUSTOMER-ZIP.
           MOVE WS-CUSTOMER-PHONE TO CUSTOMER-PHONE.
           MOVE WS-CUSTOMER-CONTACT TO CUSTOMER-CONTACT.       
      *
       WRITE-CURRENT-RECORD.            
           PERFORM UPDATE-RECORD-FIELDS.
           WRITE CUSTOMER-RECORD
             INVALID KEY
               REWRITE CUSTOMER-RECORD
           END-WRITE.           
      *
      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "customer.prd".
       COPY "customer.mnu".
       COPY "customer.evt".
      *{Bench}end

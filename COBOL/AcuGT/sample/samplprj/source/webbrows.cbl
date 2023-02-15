       IDENTIFICATION DIVISION.
       PROGRAM-ID.  WEBBROWS.
      * COPYRIGHT (C) 1996-2006 BY ACUCORP, INC.  USERS OF ACUCOBOL
      * MAY FREELY MODIFY AND REDISTRIBUTE THIS PROGRAM.
       REMARKS.
           THIS PROGRAM DEMONSTRATES SOME USAGES OF THE BROWSER CONTROL.
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
       COPY "fonts.def".
       COPY "showmsg.def".
      *{Bench}end
       COPY "OPENSAVE.DEF".
      *
       77  START-DIR                           PIC X(80).
       77  AVI-FILES          PIC X(80)
                VALUE "AVI FILES (*.AVI)|*.AVI".
       77  HTML-FILES           PIC X(80)
                VALUE "HTML FILES (*.HTM) |*.HTM".
      *
       77  CURRENT-SCREEN-LINES         PIC S999V99.
       77  CURRENT-SCREEN-SIZE          PIC S999V99.
      *
       77  MB-VALUE                            PIC 9 VALUE 0.
       77  WB-1-TITLE                          PIC X(100).
       COPY RESOURCE "SMPL-ARROWS.BMP".
      *
      *{Bench}copy-working
       COPY "webbrows.wrk".
      *{Bench}end
       LINKAGE SECTION.
      *{Bench}linkage
      *{Bench}end
       SCREEN SECTION.
      *
      *{Bench}copy-screen
       COPY "webbrows.scr".
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
           PERFORM Acu-CUST-Screen-Scrn.

      * UPDATE SCREEN
           PERFORM UPDATE-SCREEN.
      *      
       UPDATE-SCREEN-FIELDS.          
           MOVE CUSTOMER-NAME    TO WS-CUSTOMER-NAME.
           MOVE CUSTOMER-ADDR-1  TO WS-CUSTOMER-ADDR-1.
           MOVE CUSTOMER-ADDR-2  TO WS-CUSTOMER-ADDR-2.
           MOVE CUSTOMER-CITY    TO WS-CUSTOMER-ADDR-3.
           MOVE CUSTOMER-CONTACT TO WS-CUSTOMER-CONTACT.
           MOVE CUSTOMER-PHONE   TO WS-CUSTOMER-PHONE.           
      *     
       UPDATE-SCREEN.           
           MODIFY COMPANYNAME-EF, VALUE WS-CUSTOMER-NAME.
           MODIFY ADDR1-EF, VALUE WS-CUSTOMER-ADDR-1.
           MODIFY ADDR2-EF, VALUE WS-CUSTOMER-ADDR-2.
           MODIFY ADDR3-EF, VALUE WS-CUSTOMER-ADDR-3.
           MODIFY COMPANYCONTACT-COMBO, VALUE WS-CUSTOMER-CONTACT.
           MODIFY CUSTOMER-PHONE-EF, VALUE WS-CUSTOMER-PHONE.
      *
       UPDATE-RECORD-FIELDS.
           MOVE WS-CUSTOMER-NAME    TO CUSTOMER-NAME.
           MOVE WS-CUSTOMER-ADDR-1  TO CUSTOMER-ADDR-1.
           MOVE WS-CUSTOMER-ADDR-2  TO CUSTOMER-ADDR-2.
           MOVE WS-CUSTOMER-ADDR-3  TO CUSTOMER-CITY.
           MOVE WS-CUSTOMER-PHONE   TO CUSTOMER-PHONE.
           MOVE WS-CUSTOMER-CONTACT TO CUSTOMER-CONTACT.       
      *
       WRITE-CURRENT-RECORD.            
           PERFORM UPDATE-RECORD-FIELDS.
           WRITE CUSTOMER-RECORD
             INVALID KEY
               REWRITE CUSTOMER-RECORD
           END-WRITE.           
      *
       UPDATE-BROWSER.
           MOVE URLEF-VALUE TO WB-1-URL.
           MODIFY URL-EF, VALUE WB-1-URL.
           MODIFY WB-1 VALUE WB-1-URL    .

           |MODIFY WB-1 SELECT-ALL = 1.
           |MODIFY WB-1 COPY-SELECTION = 1.

       OPENSAVE-DIALOG.
           MOVE 1 TO OPNSAV-DEFAULT-FILTER.
           MOVE "FILE SELECTOR" TO OPNSAV-TITLE.
           MOVE START-DIR TO OPNSAV-DEFAULT-DIR.
           CALL "C$OPENSAVEBOX" USING OPENSAVE-OPEN-BOX, OPENSAVE-DATA.
      
           IF RETURN-CODE NOT = OPNSAVERR-CANCELLED
              MOVE OPNSAV-FILENAME TO URLEF-VALUE
              PERFORM UPDATE-BROWSER
           END-IF.
           
       ADJUST-CONTROLS.           
       
           COMPUTE CompNameLbl-Size = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompNameEF-Size  = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompAddrLbl-Size = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompAddrEF1-Size = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompAddrEF2-Size = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompAddrEF3-Size = (CURRENT-SCREEN-SIZE / 2) - 4.8.
           COMPUTE CompanyContactLbl-Col = 
                                      (CURRENT-SCREEN-SIZE / 2) + 1.9.
           COMPUTE CompContactLbl-Size = 
                                      (CURRENT-SCREEN-SIZE / 2) - 2.4.
           COMPUTE CompanyContactCombo-Col =
                                      (CURRENT-SCREEN-SIZE / 2) + 1.9.
           COMPUTE CompContactCombo-Size =
                                      (CURRENT-SCREEN-SIZE / 2) - 2.4.
           COMPUTE ContactNumLbl-Col =
                                      (CURRENT-SCREEN-SIZE / 2) + 1.9.
           COMPUTE ContactNumLbl-Size = 
                                      (CURRENT-SCREEN-SIZE / 2) - 2.4.
           COMPUTE CustPhone-Col =    (CURRENT-SCREEN-SIZE / 2) + 1.9.
           COMPUTE CustPhone-Size =   (CURRENT-SCREEN-SIZE / 2) - 2.4.
           COMPUTE URLLbl-Size =       CURRENT-SCREEN-SIZE - 8.2.
           COMPUTE UrlEF-Size =        CURRENT-SCREEN-SIZE - 1.8.
           COMPUTE WB1-Lines =         CURRENT-SCREEN-LINES - 2.   
           COMPUTE WB1-Size =          CURRENT-SCREEN-SIZE - 1.8.
           COMPUTE GoBackBtn-Col =     CURRENT-SCREEN-SIZE - 5.5.
           COMPUTE GoForwardBtn-Col =  CURRENT-SCREEN-SIZE - 2.9.
           COMPUTE WbStatus-Line =     CURRENT-SCREEN-LINES - 3.
           COMPUTE WbStatLbl-Size =    CURRENT-SCREEN-LINES - 1.8.
      *     
           MODIFY CompanyName-Label
              SIZE CompNameLbl-Size CELLS.
              
           MODIFY CompanyName-Ef, 
              SIZE CompNameEF-Size CELLS.
              
           MODIFY CompanyAddr-Label, 
              SIZE CompAddrLbl-Size CELLS.
              
           MODIFY Addr1-Ef, 
              SIZE CompAddrEF1-Size CELLS.
              
           MODIFY Addr2-Ef, 
              SIZE CompAddrEF2-Size CELLS.
              
           MODIFY Addr3-Ef, 
              SIZE CompAddrEF3-Size CELLS.
              
           MODIFY CompanyContact-Label, 
              COL CompanyContactLbl-Col,
              SIZE CompContactLbl-Size CELLS.
              
           MODIFY CompanyContact-Combo, 
              COL CompanyContactCombo-Col,
              SIZE CompContactCombo-Size CELLS.
              
           MODIFY ContactNum-Label, 
              COL ContactNumLbl-Col,
              SIZE ContactNumLbl-Size CELLS.
              
           MODIFY Customer-Phone-EF, 
              COL CustPhone-Col,
              SIZE CustPhone-Size CELLS.
              
           MODIFY Url-Label, 
              SIZE URLLbl-Size CELLS.
              
           MODIFY url-ef, 
              SIZE UrlEF-Size CELLS.
              
           MODIFY WB-1, 
              LINES WB1-Lines CELLS,
              SIZE WB1-Size CELLS.
              
           MODIFY GoBack-Pb, 
              COL GoBackBtn-Col.
      
           MODIFY GoForward-Pb, 
              COL GoForwardBtn-Col.
              
           MODIFY WbStatus-Label, 
              LINE WbStatus-Line,
              SIZE WbStatLbl-Size CELLS.
      *
      *{Bench}copy-procedure
       COPY "showmsg.cpy".
       COPY "webbrows.prd".
       COPY "webbrows.evt".
      *{Bench}end

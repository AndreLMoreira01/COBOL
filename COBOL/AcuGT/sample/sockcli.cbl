       IDENTIFICATION DIVISION.
       PROGRAM-ID.    SOCKCLI.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "def/socket.def".

       78  DATA-LENGTH                        VALUE 50.
       77  SOCKET-HANDLE                      USAGE HANDLE.
       77  SERVER-NAME                        PIC X(10).
       77  DATA-FROM-CLIENT                   PIC X(DATA-LENGTH).
       77  READ-AMOUNT                        PIC 99.

       PROCEDURE DIVISION.
       MAIN-PGH.
           DISPLAY WINDOW ERASE.
           DISPLAY "Connecting to server: " LINE 5 COL 5.
           MOVE "zackpc" TO SERVER-NAME.
           INSPECT SERVER-NAME REPLACING TRAILING SPACES BY LOW-VALUES.
           CALL "C$SOCKET" USING AGS-CREATE-CLIENT, 8765, SERVER-NAME
                           GIVING SOCKET-HANDLE.
           DISPLAY SOCKET-HANDLE CONVERT.
           IF SOCKET-HANDLE = NULL
               STOP RUN
           END-IF.

           PERFORM WITH TEST AFTER UNTIL READ-AMOUNT = -1
               DISPLAY "Enter data to send to server" LINE 7 COL 5
               MOVE SPACES TO DATA-FROM-CLIENT
               ACCEPT DATA-FROM-CLIENT LINE 8 COL 10 UPDATE
               IF DATA-FROM-CLIENT = SPACES
                   EXIT PERFORM
               END-IF
               CALL "C$SOCKET" USING AGS-WRITE, SOCKET-HANDLE,
                                     DATA-FROM-CLIENT, DATA-LENGTH
               CALL "C$SOCKET" USING AGS-READ, SOCKET-HANDLE,
                                     DATA-FROM-CLIENT, DATA-LENGTH

               DISPLAY "The server returned:" LINE 9 COL 5
               DISPLAY DATA-FROM-CLIENT LINE 10 COL 5
           END-PERFORM.
           CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE.
           ACCEPT OMITTED.
           STOP RUN.

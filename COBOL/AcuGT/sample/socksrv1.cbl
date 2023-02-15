       IDENTIFICATION DIVISION.
       PROGRAM-ID.    SOCKSRV1.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * This program demonstrates a single-client server.
      * A single client can connect to this server, and
      * when the client disconnects, the server shuts down.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "def/socket.def".

       78  DATA-LENGTH                        VALUE 50.
       77  SOCKET-HANDLE-1                    USAGE HANDLE.
       77  SOCKET-HANDLE-2                    USAGE HANDLE.
       77  DATA-FROM-CLIENT                   PIC X(DATA-LENGTH).
       77  READ-AMOUNT                        PIC S99.

       PROCEDURE DIVISION.
       MAIN-PGH.
           DISPLAY WINDOW ERASE.
           DISPLAY "Creating server socket: " LINE 5 COL 5.
           CALL "C$SOCKET" USING AGS-CREATE-SERVER, 8765
                           GIVING SOCKET-HANDLE-1.
           DISPLAY SOCKET-HANDLE-1 CONVERT.
           IF SOCKET-HANDLE-1 = NULL
               STOP RUN
           END-IF.

           DISPLAY "Accepting connection from client: " LINE 6 COL 5.
           CALL "C$SOCKET" USING AGS-ACCEPT, SOCKET-HANDLE-1
                           GIVING SOCKET-HANDLE-2.
           CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE-1.
           DISPLAY SOCKET-HANDLE-2 CONVERT.
           IF SOCKET-HANDLE-2 = NULL
               STOP RUN
           END-IF.

           PERFORM WITH TEST AFTER UNTIL READ-AMOUNT = -1
               DISPLAY "Reading client data" LINE 7 COL 5
               CALL "C$SOCKET" USING AGS-READ, SOCKET-HANDLE-2,
                                     DATA-FROM-CLIENT, DATA-LENGTH
                               GIVING READ-AMOUNT
               IF READ-AMOUNT = DATA-LENGTH
                   DISPLAY DATA-FROM-CLIENT LINE 8 COL 5

                   INSPECT DATA-FROM-CLIENT CONVERTING
                           "ABCDEFGHIJKLMNOPQRSTUVWXYZ" TO
                           "abcdefghijklmnopqrstuvwxyz"

                   DISPLAY "Writing lower case text to client"
                           LINE 9 COL 5
                   CALL "C$SOCKET" USING AGS-WRITE, SOCKET-HANDLE-2,
                                         DATA-FROM-CLIENT, DATA-LENGTH
               END-IF
           END-PERFORM.
           CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE-2.
           STOP RUN.

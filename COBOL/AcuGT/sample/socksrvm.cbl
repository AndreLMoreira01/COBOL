       IDENTIFICATION DIVISION.
       PROGRAM-ID.    SOCKSRVM.

      * Copyright (c) 1989-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.

      * This program demonstrates a multi-client server.
      * Any number of clients can connect to this server.
      * Currently there is no way to kill this server without
      * just killing it from the OS level.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "def/socket.def".

       78  DATA-LENGTH                        VALUE 50.
       77  SOCKET-HANDLE-1                    USAGE HANDLE.
       77  SOCKET-HANDLE-2                    USAGE HANDLE.
       77  DATA-FROM-CLIENT                   PIC X(DATA-LENGTH).
       77  READ-AMOUNT                        PIC S99.
       77  TIMEOUT                            SIGNED-INT
                                              VALUE -1.

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

           PERFORM UNTIL 1 = 0
               DISPLAY "Waiting for the next ready socket: "
                       NO ADVANCING
               CALL "C$SOCKET" USING AGS-NEXT-READ, SOCKET-HANDLE-1,
                                     TIMEOUT
               DISPLAY RETURN-CODE CONVERT
               IF RETURN-CODE = -1    |Error case
                   CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE-1
                   STOP RUN
               END-IF
               IF RETURN-CODE = 0
                   EXIT PERFORM CYCLE
               END-IF
               MOVE RETURN-CODE TO SOCKET-HANDLE-2
               IF SOCKET-HANDLE-2 = SOCKET-HANDLE-1
                   CALL "C$SOCKET" USING AGS-ACCEPT, SOCKET-HANDLE-1
                   EXIT PERFORM CYCLE
               END-IF
               CALL "C$SOCKET" USING AGS_READ, SOCKET-HANDLE-2,
                                     DATA-FROM-CLIENT, DATA-LENGTH
                               GIVING READ-AMOUNT
               IF READ-AMOUNT = DATA-LENGTH
                   DISPLAY DATA-FROM-CLIENT

                   INSPECT DATA-FROM-CLIENT CONVERTING
                           "ABCDEFGHIJKLMNOPQRSTUVWXYZ" TO
                           "abcdefghijklmnopqrstuvwxyz"

                   DISPLAY "Writing lower case text to client"
                   CALL "C$SOCKET" USING AGS-WRITE, SOCKET-HANDLE-2,
                                         DATA-FROM-CLIENT, DATA-LENGTH
               ELSE IF READ-AMOUNT = -1
                   CALL "C$SOCKET" USING AGS-CLOSE, SOCKET-HANDLE-2
               END-IF
               END-IF
           END-PERFORM.
           STOP RUN.

       IDENTIFICATION DIVISION.
       PROGRAM-ID.  MESSAGE IS INITIAL PROGRAM.
       DATE-WRITTEN.    15-Jul-90 - TDC.
           03-Oct-90 - Add color support (can change values in
               INITIALIZE-MESSAGE paragraph).
           07-Jun-92 - Added support for using the host message box
               supplied by a graphical user interface (such as Microsoft
               Windows).  This program will now translate calls into calls
               to the native message box if one is available.  If the host
               system does not support message boxes directly, then this
               routine will provide the support itself using character mode.
               Also added mouse support.
           19-Jul-96 - Removed the COBOL implementation of the message box
               since it is available in the 3.1 runtime.
           05-Sep-97 - Allow empty messages.
           03-Mar-98 - Changed PROGRAM-ID to "MESSAGE" to simplify placement
               in an object library.

      * Copyright (c) 1990-2006 by Acucorp, Inc.
      * Users of ACUCOBOL may freely use this file.


       REMARKS.
           This program provide message box support.  It can be used
           to communicate a simple message to the user and get standardized
           responses.  This routine simulates the message box style
           used by Presentation Manager and MS Windows, but uses character
           mode terminals.

           The routine is passed a message type, which can be:

               '1'    - Error message
               '2'    - Warning message
               '3'    - Informational message

           It is also passed a parameter that lists the valid responses.
           Currently supported types:

               '1'    - "Ok" only
               '2'    - "Yes" and "No"
               '3'    - "Ok" and "Cancel"
               '4'    - "Yes", "No" and "Cancel"

           You can also specify the default response by pre-pending the
           default button number to the listed types.  For example,
           type "22" allows a "Yes-No" response with a default value of
           "No".

           Finally, you can pass one to three message lines (40 characters
           each).

           The message box displays the messages and gets the user's
           response.  The response value is returned in the response-type
           parameter.  The returned values are listed in the Linkage
           Section below.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Change the following to support other languages
       01  TEXT-LITERALS.
           03  ERROR-TITLE           PIC X(6) VALUE "Error!".
           03  WARNING-TITLE         PIC X(7) VALUE "Warning".

       77  NUM-ARGS                            PIC 99 COMP-1.
       77  BOX-TITLE                           PIC X(10).

       77  GUI-MESSAGE-TEXT                    PIC X(121).
       77  GUI-TEXT-PTR                        PIC S9(4) COMP-1.
       77  GUI-MODE                            PIC S9(4) COMP-5.
       77  SIZE-1                              PIC S9(4) COMP-1.
       77  FIRST-MESSAGE                       PIC 9     VALUE 1.

       COPY "def/acugui.def".

       LINKAGE SECTION.
       01  MESSAGE-TYPE                        PIC 9.
           88  ERROR-TYPE                      VALUE 1.
           88  WARNING-TYPE                    VALUE 2.
           88  INFORMATION-TYPE                VALUE 3.

       01  RESPONSE-TYPE.
           03  DEFAULT-BUTTON                  PIC 9.
               88  DEFAULT-1                   VALUES ZERO, 1.
               88  DEFAULT-2                   VALUE 2.
               88  DEFAULT-3                   VALUE 3.
           03  BUTTON-TYPES                    PIC 9.
               88  OK-TYPE                     VALUE 1.
               88  YES-NO-TYPE                 VALUE 2.
               88  OK-CANCEL-TYPE              VALUE 3.
               88  YES-NO-CANCEL-TYPE          VALUE 4.

       01  RESPONSE REDEFINES RESPONSE-TYPE    PIC 99.
           88  RESPOND-OK                      VALUE 1.
           88  RESPOND-YES                     VALUE 1.
           88  RESPOND-NO                      VALUE 2.
           88  RESPOND-CANCEL                  VALUE 3.

       01  MESSAGE-1                           PIC X(40).
       01  MESSAGE-2                           PIC X(40).
       01  MESSAGE-3                           PIC X(40).


       PROCEDURE DIVISION USING MESSAGE-TYPE, RESPONSE-TYPE,
                                MESSAGE-1, MESSAGE-2, MESSAGE-3.
       LEVEL-1 SECTION.
       MAIN-LOGIC.
           PERFORM COUNT-MESSAGE-LINES.

           MOVE 1 TO GUI-TEXT-PTR.

           IF MESSAGE-1 IS NOT EQUAL TO SPACES
               MOVE ZERO TO SIZE-1
               INSPECT MESSAGE-1 TALLYING SIZE-1 FOR TRAILING SPACES
               STRING MESSAGE-1( 1 : 40 - SIZE-1 )
                      DELIMITED BY SIZE
                      INTO GUI-MESSAGE-TEXT,
                      POINTER GUI-TEXT-PTR
               MOVE 0 TO FIRST-MESSAGE.
           IF NUM-ARGS > 1 AND MESSAGE-2 IS NOT EQUAL TO SPACES
               IF FIRST-MESSAGE = 0
                   STRING X"0A" DELIMITED BY SIZE,
                          INTO GUI-MESSAGE-TEXT, POINTER GUI-TEXT-PTR
               END-IF
               MOVE ZERO TO SIZE-1
               INSPECT MESSAGE-2 TALLYING SIZE-1 FOR TRAILING SPACES
               STRING MESSAGE-2( 1 : 40 - SIZE-1 )
                      DELIMITED BY SIZE,
                      INTO GUI-MESSAGE-TEXT, POINTER GUI-TEXT-PTR
               MOVE 0 TO FIRST-MESSAGE.
           IF NUM-ARGS > 2 AND MESSAGE-3 IS NOT EQUAL TO SPACES
               IF FIRST-MESSAGE = 0
                   STRING X"0A" DELIMITED BY SIZE,
                          INTO GUI-MESSAGE-TEXT, POINTER GUI-TEXT-PTR
               END-IF
               MOVE ZERO TO SIZE-1
               INSPECT MESSAGE-3 TALLYING SIZE-1 FOR TRAILING SPACES
               STRING MESSAGE-3( 1 : 40 - SIZE-1 )
                      DELIMITED BY SIZE,
                      INTO GUI-MESSAGE-TEXT, POINTER GUI-TEXT-PTR.
           MOVE LOW-VALUES TO GUI-MESSAGE-TEXT( GUI-TEXT-PTR : 1 ).

           SUBTRACT 1 FROM BUTTON-TYPES GIVING GUI-MODE.
           IF ERROR-TYPE
               MOVE ERROR-TITLE TO BOX-TITLE
               ADD 512 TO GUI-MODE
           ELSE IF WARNING-TYPE
               MOVE WARNING-TITLE TO BOX-TITLE
               ADD 256 TO GUI-MODE
           ELSE
               MOVE SPACES TO BOX-TITLE.
           INSPECT BOX-TITLE REPLACING TRAILING SPACES BY LOW-VALUES.

           IF DEFAULT-2
               ADD 4096 TO GUI-MODE
           ELSE IF DEFAULT-3
               ADD 8192 TO GUI-MODE.

           CALL "W$MESSAGEBOX" USING GUI-MESSAGE-TEXT, BOX-TITLE,
                                     VALUE GUI-MODE
               NOT ON EXCEPTION
                   IF RETURN-CODE NOT = ZERO
                       MOVE RETURN-CODE TO RESPONSE
                   END-IF
               END-CALL.

           EXIT PROGRAM 0.

        COUNT-MESSAGE-LINES.
            CALL "C$NARG" USING NUM-ARGS.
            SUBTRACT 2 FROM NUM-ARGS.
            IF NUM-ARGS IS = 3 AND MESSAGE-3 IS = SPACES
                MOVE 2 TO NUM-ARGS.
            IF NUM-ARGS IS = 2 AND MESSAGE-2 IS = SPACES
                MOVE 1 TO NUM-ARGS.

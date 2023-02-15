IDENTIFICATION DIVISION.
PROGRAM-ID.    web-info.
AUTHOR.        Mike Entwistle.
remarks.       This program is meant to run with the plugin.
******************************************************************
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.

INPUT-OUTPUT SECTION.
FILE-CONTROL.
     SELECT file-name
     ASSIGN TO web-file
     organization is line sequential
     FILE STATUS IS file-status.

******************************************************************
DATA DIVISION.
FILE SECTION.
FD  file-name.
01  web-info-record.
    05  web-info-label            pic x(40).
    05  web-info-item             pic x(35).

WORKING-STORAGE SECTION.
    copy "../def/acucobol.def".
    copy "../def/crtvars.def".
    copy "../def/acugui.def".
    copy "../def/opensave.def".

01  display-browser-major-version      pic z9.
01  display-browser-minor-version      pic z9.
01  browser-recalc                     pic 9(3).
01  IS-PLUGIN-TEST                     pic x(40).
01  HAS-INDEXED-READ-PREVIOUS-TEST     pic x(3).
01  CAN-TEST-INPUT-STATUS-TEST         pic x(3).
01  IS-MULTI-TASKING-TEST              pic x(3).
01  runtime-version-string             pic x(8).

01  status-message.
    05 filler                          pic x(32)
       value "W$STATUS test. Current time is: ".
    05 current-hours                   pic 99.
    05 filler                          pic x value ":".
    05 current-minutes                 pic 99.
    05 filler                          pic x value ":".
    05 current-seconds                 pic 99.
01  current-time                       pic 9(8).

01  file-prefix-item                   pic x(40).

01  opensave-status                    pic s9.
01  web-file                           pic x(256).
01  file-status                        pic xx.
78  NEWLINE                        value H"0A".

01  Program-status                     pic 9.
    88 exit-program-selected       value 1.

*For C$CALLERR routine to get why the CALL statement Failed.
77  ERR-CODE                           pic x(2).
77  ERR-MESSAGE                        pic x(160).
*For C$RERR routine to get the extendeed file status information.
01  EXTEND-STAT.
    03 primary-error                   pic x(2).
    03 secondary-error                 pic x(10).
01  TEXT-MESSAGE                       pic x(60).
*For C$RERRNAME routine to get the last file used in an I/O statement.
77  LAST-FILENAME                      PIC X(60).

SCREEN SECTION.
01  main-screen.
    05 label
       line 2 col 2
       title "Information collected by runtime.".
    05 label
       line 4 col 2
       title   "Browser Info: ".
    05 label
       line 5 col 4
       title   "user-agent-string: ".
    05 label
       line 5 col 24
       title   user-agent-string.
    05 label
       line 6 col 4
       title   "browser-major-version: ".
    05 label
       line 6 col 23
       title   display-browser-major-version.
    05 label
       line 6 col 34
       title   "browser-minor-version: ".
    05 label
       line 6 col 57
       title   display-browser-minor-version.
    05 label
       line 8 col 2
       title   "System Info.".
    05 label
       line 9 col 4
       title   "Operating-System: ".
    05 label
       line 9 col 24
       title   OPERATING-SYSTEM.
    05 label
       line 9 col 34
       title   "USER-ID: ".
    05 label
       line 9 col 58
       title   USER-ID.
    05 label
       line 10 col 4
       title   "STATION-ID: ".
    05 label
       line 10 col 24
       title   STATION-ID.
    05 label
       line 10 col 34
       title   "RUNTIME-VERSION: ".
    05 label
       line 10 col 58
       title   runtime-version-string.
    05 label
       line 11 col 4
       title   "IS-PLUGIN?: ".
    05 label
       line 11 col 34
       title   IS-PLUGIN-TEST.
    05 label
       line 12 col 4
       title   "HAS-INDEXED-READ-PREVIOUS: ".
    05 label
       line 12 col 34
       title   HAS-INDEXED-READ-PREVIOUS-TEST.
    05 label
       line 13 col 4
       title   "CAN-TEST-INPUT-STATUS: ".
    05 label
       line 13 col 34
       title   CAN-TEST-INPUT-STATUS-TEST.
    05 label
       line 14 col 4
       title   "IS-MULTI-TASKING: ".
    05 label
       line 14 col 34
       title   IS-MULTI-TASKING-TEST.
    05 label
       line 16 col 2
       title   "Other Miscellaneous Information.".
    05 label
       line 17 col 4
       title   "FILE-PREFIX: ".
    05 label
       line 17 col 34
       title   file-prefix-item.
    05 push-button
       line 22 col 2
       value "Test W$STATUS"
       size 20
       id = 1
       event procedure push-button-pressed.
    05 push-button
       line 22 col 24  size 20
       value "Mail comments?"
       id = 2
       event procedure push-button-pressed.
    05 push-button
       line 22 col 46 size 20
       value "Save Info"
       id = 3
       event procedure push-button-pressed.
    05 push-button
       line 26 col 46 size 20
       value "E&xit"
       id = 4
       event procedure push-button-pressed.

******************************************************************
PROCEDURE DIVISION.
DECLARATIVES.
file-name-error-handling SECTION.
    use after standard error procedure on file-name.
file-name-errors.
    perform Display-File-Status-Codes.
END DECLARATIVES.
Main Section.
    display standard graphical window
       title "Plugin Sample - Display Environment Info"
       lines 28 size 70
       background-low.

****** find out about browser we are in ************************
    Call "W$BROWSERINFO" using BROWSERINFO-DATA.
    move  browser-major-version   to browser-recalc.
    subtract 48 from browser-recalc giving
             display-browser-major-version.
    move  browser-minor-version   to browser-recalc.
    subtract 48 from browser-recalc giving
             display-browser-minor-version.

****** find out about system we are running on ******************
    accept system-information from system-info.
    if IS-PLUGIN then
       move "Running via Web Browser Plugin" to IS-PLUGIN-TEST
    else
       move "Running via stand-alone runtime" to IS-PLUGIN-TEST
    end-if.
    if HAS-INDEXED-READ-PREVIOUS then
       move "yes" to HAS-INDEXED-READ-PREVIOUS-TEST
    else
       move "yes" to HAS-INDEXED-READ-PREVIOUS-TEST
    end-if.
    if CAN-TEST-INPUT-STATUS then
       move "yes" to CAN-TEST-INPUT-STATUS-TEST
    else
       move "yes" to CAN-TEST-INPUT-STATUS-TEST
    end-if.
    if IS-MULTI-TASKING then
       move "yes" to IS-MULTI-TASKING-TEST
    else
       move "yes" to IS-MULTI-TASKING-TEST
    end-if.

    string runtime-major-version
           "."
           runtime-minor-version
           ","
           runtime-release
           delimited by size
           into runtime-version-string.
*********** accept some environment variables ********************

    accept file-prefix-item from environment "file-prefix".


***************** loop until exit button pressed ******************
    perform until exit-program-selected
       display main-screen
       accept main-screen
    end-perform.

    Exit Program.
    Stop Run.

event-procedures section.
push-button-pressed.
    evaluate event-type
      when cmd-clicked
        evaluate EVENT-CONTROL-ID
          when 1
            if IS-PLUGIN   then
               accept current-time from time
               move current-time(1:2) to current-hours
               move current-time(3:2) to current-minutes
               move current-time(5:2) to current-seconds
               call "W$STATUS" using status-message
               display message box "Status bar updated with current time"
            else
               display message box
                   "Not valid when running from stand-alone runtime"
            end-if
          when 2
            if IS-PLUGIN   then
               call "W$GETURL" using "mailto:support@acucorp.com", "_self"
            else
               display message box
                   "Not valid when running from stand-alone runtime"
            end-if
          when 3
            initialize opensave-data
            move "webinfo.dat" to opnsav-filename
            move file-prefix-item to opnsav-default-dir
            call "C$OPENSAVEBOX"
               using opensave-save-box, opensave-data
            giving opensave-status
            if opensave-status = 1 then
               move opnsav-filename to web-file
               open output file-name
                   if file-status = zero
                       perform write-web-info
                       close file-name
                   end-if
            end-if
          when 4
            set exit-program-selected to true
          when other
            display message box
                "Program Error."
        end-evaluate
     end-evaluate.



write-web-info.
    move "Information collected by runtime." to web-info-label.
    write web-info-record.
    move low-values to web-info-label.
    move "Browser Info:" to web-info-record.
    write web-info-record.
    move low-values to web-info-record.
    move "user-agent-string: " to web-info-label.
    move user-agent-string to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "browser-major-version: " to web-info-label.
    move display-browser-major-version to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "browser-minor-version: " to web-info-label.
    move display-browser-minor-version to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "System Info." to web-info-label.
    write web-info-record.
    move low-values to web-info-record.
    move "Operating-System: " to web-info-label.
    move operating-system to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "user-id: " to web-info-label.
    move user-id to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "Station-id: " to web-info-label.
    move station-id to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "runtime-version: " to web-info-label.
    move  runtime-version-string to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "is-plugin: " to web-info-label.
    move is-plugin-test to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "has-indexed-read-previous:" to web-info-label.
    move has-indexed-read-previous-test to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "can-test-input-status:" to web-info-label.
    move can-test-input-status-test to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "is-multi-tasking:" to web-info-label.
    move is-multi-tasking-test to web-info-item.
    write web-info-record.
    move low-values to web-info-record.
    move "file-prefix:" to web-info-label.
    move file-prefix-item to web-info-item.
    write web-info-record.


Library-Routines Section.
* Library Routines Description
Display-Call-Err-Message.
    CALL "C$CALLERR" USING ERR-CODE, ERR-MESSAGE
    DISPLAY MESSAGE BOX
       ERR-MESSAGE,
	  TITLE IS "Call Statement Failed".

Display-Extended-File-Status.
    CALL "C$RERR" USING EXTEND-STAT, TEXT-MESSAGE.
    CALL "C$RERRNAME" USING LAST-FILENAME.
    MOVE SPACES TO ERR-MESSAGE.
    if primary-error = 37 and secondary-error = 07 then
           move "Plugin does not have permission to write to this directory."
               to text-message
    end-if.
    String "File Name :" delimited by size
           LAST-FILENAME delimited by spaces
           " Status ["   delimited by size
           primary-error delimited by size
           ","           delimited by size
           secondary-error delimited by spaces
           "] "          delimited by size
           NEWLINE       delimited by size
           TEXT-MESSAGE  delimited by size
         into ERR-MESSAGE
    End-String.
    DISPLAY MESSAGE BOX
           ERR-MESSAGE,
           TITLE IS "File Status".
Display-File-Status-Codes.
    Evaluate ERR-CODE
           When "00"
                Display Message "Operation successful."
           When "10"
                Display Message "End of file."
           When "22"
                Display Message "Duplicate key found but not allowed."
           When "23"
                Display Message "Record not found."
           When "34"
                Display Message "Disk full for sequential file or sort file."
           When "35"
                Display Message "File not found."
           When "41"
                Display Message "File is already open."
           When "42"
                Display Message "File not open."
           When "30"
           When "39"
           When other
                Perform Display-Extended-File-Status
           End-Evaluate.

identification division.
program-id.     opnsv-test.
author.         Randy Zack, Acucorp, Inc.
remarks.        This program demonstrates the file selection dialog.

data division.
working-storage section.

78  select-pressed                      value 10.

77  push-handle                         handle of push-button.
77  start-dir                           pic x(80).
77  file-name                           pic x(80).

77  key-status is SPECIAL-NAMES CRT STATUS
                                        pic 9(4) value 0.
    88  exit-button-pressed                     value 13.
    88  select-button-pressed                   value select-pressed.

copy "def/opensave.def".

screen section.
01  main-screen.
    03  label "File Selection sample" line 2 size 40 center.
    03  label "File:" line 5 column 3.
    03  entry-field value file-name size 30 column + 3.
    03  push-button "E&xit" ok-button line 10 column 10.
    03  push-button "&Select" termination-value = SELECT-PRESSED
                column + 5.

procedure division.
main-para.
    display standard window size 40 lines 15 background-low.

***   Test whether the OPEN/SAVE dialog is supported.  If not, just quit.
    call "C$OPENSAVEBOX" using opensave-supported.
    if return-code = opnsaverr-unsupported
        display label "Open/Save dialog boxes are not supported"
                line 5 column 5
        display push-button "Exit" ok-button line 10 column 15 size 10
                handle in push-handle
        accept push-handle
        stop run
    end-if.

***   The ACUCOBOL environment variable is supposed to point to the
***   top-level ACUCOBOL installation directory.  Let the user move
***   into the sample directory from there.
    accept start-dir from environment "ACUCOBOL".
    perform with test after until exit-button-pressed
        display main-screen
        accept main-screen
        if select-button-pressed
            perform opensave-dialog
        end-if
    end-perform.
    stop run.

***   Show the OPEN/SAVE dialog.  Put the returned file name into
***   our entry-field value.
opensave-dialog.
    move "COBOL source files (*.cbl)|*.cbl|COBOL copy files (*.def)|*.def|All files (*)|*" to opnsav-filters
    move 1 to opnsav-default-filter
    move "File Selector" to opnsav-title
    move start-dir to opnsav-default-dir
    call "C$OPENSAVEBOX" using opensave-open-box, opensave-data
    if return-code not = opnsaverr-cancelled
        move opnsav-filename to file-name
    end-if.

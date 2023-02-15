identification division.
program-id.  status-bar.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program demostrates the status bar.
    If the file list.dat doesn't exist, it will
    display a status bar while building the file.

environment division.
input-output section.
file-control.
    select optional data-file
    assign to disk "list.dat"
    indexed; access mode dynamic
    record key is data-key-1
    file status is file-status.

data division.
file section.
fd  data-file.
01  data-record.
    03  data-key-1                      pic x(10).
    03  data-city                       pic x(12).
    03  data-state                      pic x(3).
    03  data-amount                     pic x(6).

working-storage section.

77  frame-1             handle of frame.

77  stat-pos            pic 999.
77  tmp-pos             pic 999.

01  frame-title.
    03  status-pos-formatted    pic zz9 value "  0".
    03  filler                  pic x value "%".

77  list-data                           pic x(42).
77  file-status                         pic xx.
77  window-1                            handle of window.
77  tmp-amount                          pic 9(6) value 1000.
77  color-1                             pic 9(5).
77  color-2                             pic 9(5).

77  letter-1                            pic x.
77  letter-1-numeric redefines
    letter-1                            pic x comp-x.

77  letter-2                            pic x.
77  letter-2-numeric redefines
    letter-2                            pic x comp-x.

77  letter-3                            pic x.
77  letter-3-numeric redefines
    letter-3                            pic x comp-x.

77  key-status
       is special-names crt status         pic 9(4).
    88  ok-button-pressed               value 10.

copy "def/acugui.def".
copy "def/acucobol.def".
copy "def/palette.def".

screen section.

01  OK-screen.
    03  label "File 'list.dat' already built.",
        line 3, col 5, ccol 1, lines 1, size 36.

    03 OKButton push-button, title "&OK", size 8,
       OK-button, termination-value 27, line 6 col 13.


procedure division.
main-logic.
    perform open-data-file.

    close window window-1
    destroy window-1

    goback.

open-data-file.
    accept terminal-abilities from terminal-info.

    open input data-file.
* If the data file needs to be built, build it.
    if (file-status = "00")
       perform display-OK-screen
    else
       if (file-status = "05")
          close data-file
       end-if
       display floating window,
          lines 6, size 40
          col 4,
          boxed, erase,
          title "Processing..."
          handle in window-1
       display label "Building data file, please wait...",
          line 2, col 5

       if has-graphical-interface
           move red to color-1,
           move white to color-2
       else
           move red to color-1,
           move black to color-2
       end-if
* Initialize the status bar.
       display frame, line 4, col 5, ccol 8
          lines 1.5, clines 3, size 24 cells,
          fill-color = color-1, fill-color2 = color-2,
          fill-percent = 0, title frame-title,
          title-position = 7, background-high,
          handle frame-1, lowered

       open output data-file with mass-update

* Generate the data...

       move "A" to letter-1
       move 1 to stat-pos
       perform loop-letter-2 until letter-1 > "Z"

       close data-file
    end-if.

loop-letter-2.
    move "A" to letter-2

* This code increments the status bar.  It goes through this code
* 26 times, so I increment it by 4 and adjust the end so it doesn't
* go past 100%.

    move stat-pos to status-pos-formatted
    modify frame-1, fill-percent = stat-pos
           title = frame-title
    if (stat-pos > 96)
       subtract stat-pos from 100 giving tmp-pos
       add tmp-pos to stat-pos
    else
       add 4 to stat-pos
    end-if
    perform loop-letter-3 until letter-2 > "Z"
    add 1 to letter-1-numeric.

loop-letter-3.
    move "A" to letter-3.
* Builds and writes the data record.
    perform until letter-3 > "Z"
       add 100 to tmp-amount
       string letter-1, letter-2, letter-3, " CORP",
              delimited by size, into data-key-1
       move "San Diego" to data-city
       move "CA " to data-state
       move tmp-amount to data-amount
       inspect data-amount replacing
               leading zeros by spaces
       write data-record
       add 1 to letter-3-numeric
    end-perform
    add 1 to letter-2-numeric.

display-OK-screen.
    display floating graphical window
       handle in window-1
       size 35,
       col 20,
       lines 8,
       boxed, erase,
       title "Info Box".

    display OK-screen

    perform until key-status = 27
       accept OK-screen
    end-perform.

    close window window-1.
    destroy OK-screen.

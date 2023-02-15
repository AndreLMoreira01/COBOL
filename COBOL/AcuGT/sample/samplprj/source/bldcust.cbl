identification division.
program-id.  bldcust.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program builds the file custfile.dat
    It displays a status bar while building the file.

environment division.
input-output section.
file-control.
    select optional customer-file
    assign to disk "custfile.dat"
    indexed; access mode dynamic
    record key is customer-name
    file status is file-status.

data division.
file section.
* Customer file FD
fd  customer-file.
01  customer-record.
    03  customer-id                     pic x(10).
    03  customer-name                   pic x(30).
    03  customer-addr-1                 pic x(40).
    03  customer-addr-2                 pic x(40).
    03  customer-city                   pic x(15).
    03  customer-state                  pic x( 2).
    03  customer-zip                    pic x(10).
    03  customer-phone                  pic x(15).
    03  customer-contact                pic x(20).

working-storage section.

77  frame-1             handle of frame.

77  stat-pos            pic 999.
77  tmp-pos             pic 999.

01  frame-title.
    03  status-pos-formatted    pic zz9 value "  0".
    03  filler                  pic x value "%".

77  counter-1                          pic 9 value 1.
77  counter-2                          pic 9 value 2.
77  counter-3                          pic 9 value 3.

77  list-data                           pic x(42).
77  file-status                         pic xx.
77  window-1                            handle of window.

77  letter-1                            pic x.
77  letter-1-numeric redefines
    letter-1                            pic x comp-x.

77  letter-2                            pic x.
77  letter-2-numeric redefines
    letter-2                            pic x comp-x.

77  letter-3                            pic x.
77  letter-3-numeric redefines
    letter-3                            pic x comp-x.

copy "def/acugui.def".
copy "def/acucobol.def".
copy "def/palette.def".

procedure division.
main-logic.
    perform open-customer-file.

    close window window-1
    destroy window-1

    goback.

* Check that the file doesn't exist before building it.
open-customer-file.
    open input customer-file.
    if file-status not = "00"
       if file-status = "05"
          close customer-file
       end-if
       display floating window,
          lines 6, size 40
          boxed, erase,
          title "Processing..."
          handle in window-1
       display label "Building data file, please wait...",
          line 2, col 5

* Initialize the status bar.
       display frame, line 4, col 5,
          lines 1, size 24 cells
          fill-color = blue, fill-color2 = white,
          fill-percent = 0, title frame-title,
          title-position = 7, background-high
          handle frame-1, lowered

       open output customer-file with mass-update

       move "A" to letter-1
       move 1 to stat-pos
       perform loop-letter-2 until letter-1 > "Z"

       close customer-file
       destroy window-1
       open input customer-file
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
    add 1 to counter-1.
    add 1 to letter-1-numeric.

loop-letter-3.
    move "A" to letter-3
    perform until letter-3 > "Z"
       string letter-1, letter-2, letter-3, " CORP",
              delimited by size, into customer-name
       string letter-1, letter-2, letter-3
              delimited by size, into customer-id
       move "7950 Silverton Ave" to customer-addr-1
       string "Suite ", counter-1, counter-2, counter-3
              delimited by size, into customer-addr-2
       move "San Diego" to customer-city
       move "CA" to customer-state
       move "92126" to customer-zip
       move "(858) 689-4500" to customer-phone
       move "Drake Coker" to customer-contact
       write customer-record
       add 1 to letter-3-numeric
       add 1 to counter-3
    end-perform.
    add 1 to letter-2-numeric.
    add 1 to counter-2.

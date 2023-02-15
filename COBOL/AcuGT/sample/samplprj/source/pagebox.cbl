identification division.
program-id.  paged-box.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program demostrates the the columned paged list box.

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
78  page-size                           value 17.
78  num-records                         value 1000.

77  return-value                        pic 99.

77  list-data                           pic x(30).
77  file-status                         pic xx.
77  counter                             pic 9(5).
77  window-1                            handle of window.
77  number-reads-needed                 pic 99.

77  state-flag                          pic x.
    88  reading-forwards                value "f".
    88  reading-backwards               value "b".
    88  at-start                        value "s".
    88  at-end                          value "e".

77  key-status
    is special-names crt status         pic 9(4).
    88  ok-button-pressed               value 10.

01  screen-control
    is special-names screen control.
    03  accept-control                  pic 9.
    03  control-value                   pic 999.

01  event-status
    is special-names event status.
    03  event-type                      pic x(4) comp-x.
    03  event-window-handle             handle of window.
    03  event-control-handle            handle.
    03  event-control-id                pic xx comp-x.
    03  event-data-1                    signed-short.
    03  event-data-2                    signed-long.

01  filler                              pic x.
    88 file-found                       value "Y" false "N".

copy "def/acugui.def".


screen section.
01  main-screen.
       03  label "Paged List Box Example:", line 1, col 4.
       03  label "Corporation", line 3, size 12, col 5.
       03  label "City", line 3, size 6, col 17.5, ccol 18.
       03  label "St", line 3, size 3, col 29.6, ccol 30.
       03  label "Amount", line 3, size 8, col 37, ccol 38.

    03  list-1, list-box using list-data,
               paged, 3-d, line 4.5, col 5,
               size 40, lines page-size, upper,
               data-columns = (
			record-position of data-key-1,
			record-position of data-city,
			record-position of data-state,
			record-position of data-amount )
               display-columns = ( 1, 13, 25, 33 )
               alignment = ("L", "L", "L", "R" )
               separation = (0, 0, 0, 4)
               dividers = (2, 1, 1, 1)
               exception procedure is list-1-handler.

    03  push-button, "&OK", termination-value 10, line 23.5,
               col 22.

01  opening-screen-1.
    03  label, "Press OK to fill in paged list box.",
        line 2, col 7, ccol 2.
    03  label, "If data file has not been built, this"
        line 3, col 7, ccol 2.
    03  label, "program calls 'status', which builds "
        line 4, col 7, ccol 2.
    03  label, "the file, displaying a status bar to "
        line 5, col 7, ccol 2.
    03  label, "show progress"
        line 6, col 7, ccol 2.
    03  label, "Press Cancel to exit.",
        line 8, col 7, ccol 2.

    03 OKButton push-button, title "&OK", size 8, OK-button,
       termination-value 10, line 11, column 12, ccol 8.

    03 CancelButton push-button, title "&Cancel", size 8,
       cancel-button, termination-value 27, line 11,
       column 24, ccol 20.

01  error-screen-1.
    03  label
        "Cannot find program 'status'",
        line   3.00
        col    5.00
        ccol   1.00
        lines  1.00 cells
        size   36.50 cells
        label-offset 0
        .
    03 OKButton push-button
       title  "&OK"
       size   8.00 cells
       OK-button
       termination-value 27
       line   6.00
       column 11.50
       id     1
       permanent
       visible 1
       .

procedure division.
main-logic.
    display standard graphical window,
                   size 50, lines 25, background-low.
    display main-screen.

    display floating graphical window
       handle in window-1
       col 6,
       size   40.00
       lines  13.00
       boxed, erase,
       title "Info Box"
       .

    display opening-screen-1.

    perform until key-status = 27 or key-status = 10
       accept opening-screen-1
    end-perform.

    close window window-1.
    destroy error-screen-1.

    if (key-status = 10)
       perform open-data-file

       if (file-found)
          set reading-forwards to true
          modify list-1, mass-update = 1
          perform get-next-item page-size times
          modify list-1, mass-update = 0

          perform, with test after, until ok-button-pressed
               accept main-screen
          end-perform
       end-if
    end-if.

main-logic-exit.
    stop run.

list-1-handler.
    if key-status = w-event
       evaluate event-type
          when ntf-pl-next
             perform get-next-item

          when ntf-pl-prev
             perform get-prev-item

          when ntf-pl-nextpage
             modify list-1, mass-update = 1
             perform get-next-item page-size times
             modify list-1, mass-update = 0

          when ntf-pl-prevpage
             modify list-1, mass-update = 1
             perform get-prev-item page-size times
             modify list-1, mass-update = 0

          when ntf-pl-first
             move low-values to data-key-1
             start data-file, key not < data-key-1
                invalid key    exit paragraph
             end-start
             set reading-forwards to true
             modify list-1, mass-update = 1, reset-list = 1
             perform get-next-item page-size times
             modify list-1, mass-update = 0

          when ntf-pl-last
             move high-values to data-key-1
             start data-file, key not > data-key-1
                invalid key    exit paragraph
             end-start
             set reading-backwards to true
             modify list-1, mass-update = 1, reset-list = 1
             perform get-prev-item page-size times
             modify list-1, mass-update = 0

          when ntf-pl-search
             inquire list-1, search-text in data-key-1
             start data-file, key not < data-key-1
                invalid key    move ntf-pl-last to event-type
                               go to list-1-handler
             end-start
             set reading-forwards to true
             modify list-1, mass-update = 1
             perform get-next-item page-size times
             modify list-1, mass-update = 0
             if at-end
                move ntf-pl-last to event-type
                go to list-1-handler
             end-if
       end-evaluate
    end-if.

get-next-item.
    evaluate true
       when at-start
          move low-values to data-key-1
          start data-file, key not < data-key-1
             invalid key      exit paragraph
          end-start
          add 1 to page-size giving number-reads-needed
       when at-end
          exit paragraph
       when reading-backwards
          move page-size to number-reads-needed
       when reading-forwards
          move 1 to number-reads-needed
    end-evaluate.

    perform number-reads-needed times
       read data-file next record
          at end     set at-end to true
                     exit paragraph
       end-read
    end-perform

    modify list-1, item-to-add = data-record

    set reading-forwards to true.

get-prev-item.
    evaluate true
       when at-end
          move high-values to data-key-1
          start data-file, key not > data-key-1
             invalid key      exit paragraph
          end-start
          add 1 to page-size giving number-reads-needed
       when at-start
          exit paragraph
       when reading-forwards
          move page-size to number-reads-needed
       when reading-backwards
          move 1 to number-reads-needed
    end-evaluate.

    perform number-reads-needed times
       read data-file previous record
          at end     set at-start to true
                     exit paragraph
          end-read
    end-perform

    modify list-1,
       insertion-index = 1
       item-to-add = data-record

    set reading-backwards to true.


open-data-file.
    set file-found to true.
    open input data-file.
    if (file-status not = "00")
       close data-file
       call run "status",
          on exception
             perform do-error
             set file-found to false
          not on exception
             open input data-file
       end-call
    end-if.

do-error.
    display floating graphical window
       handle in window-1
       size   30.00
       col 10,
       lines  8.00
       boxed, erase,
       title "Program Error Box"
       .

*   Display the screen.
    display error-screen-1.

    perform until key-status = 27
       accept error-screen-1
    end-perform.

    close window window-1.
    destroy error-screen-1.

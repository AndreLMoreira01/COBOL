identification division.
program-id.  custrpt.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program demonstrates the use of threads. It reads through
    a custommer file, until the cancel button is pressed or end
    of file is reached.  It uses the "call thread" method to
    bring up the cancel program.


environment division.
        select optional customer-file
        assign to disk "custfile.dat"
        indexed; access mode dynamic
        record key is customer-name
        file status is file-status.


file section.
* Customer file FD
fd  customer-file.
01  customer-record.
    03  customer-id                     pic x(10).
    03  customer-name                   pic x(30).
    03  customer-addr-1                 pic x(40).
    03  customer-addr-2                 pic x(40).
    03  customer-city                   pic x(15).
    03  customer-state                  pic xx.
    03  customer-zip                    pic x(10).
    03  customer-phone                  pic x(15).
    03  customer-contact                pic x(20).

working-storage section.
copy "def/acugui.def".
copy "def/acucobol.def".
copy "def/crtvars.def".

77  file-status                         pic xx.
77  cancel-thread                       handle of thread, value null.
77  window-1                            handle of window.

78  exit-button-value                   value 101.
78  search-button-value                 value 102.

77  key-entered
    is special-names crt status         pic 9(5).
    88  exit-button-pushed              value exit-button-value.
    88  search-button-pushed            value search-button-value.
    88  event-occurred                  value w-event.
    88  message-received                value w-message.

01  status-item                         pic x(2).
    88  success                         value "00".

01  filler                              pic x.
    88 file-found                       value "Y", false "N".

78  cust-name-id                        value 1.
77  thread-return                       pic 9(2).

78  label-col                           value 3.
78  data-col                            value 13.
78  separation                          value 1.3.
78  button-col                          value 58.

01  filler                              pic x.
    88  done                            value "Y" false "N".

screen section.
01  cust-screen, exception procedure is cust-screen-exception.
    03  label "Sample thread program.  Press Search button "
        line 1, col label-col.
    03  label "to search through records. "
        line 1 col + 1 .
    03  label "Use cancel button in cancel box to stop the search."
        line 2, col label-col.
    03  label "The cancel box is run in a separate thread."
        line 3, col label-col.
    03  label "Name:", line 5, col label-col.
    03  cust-name-field, entry-field, value customer-name, col data-col,
        3-d, notify-change,
        id cust-name-id.
    03  label "Address:", line + separation, col label-col.
    03  entry-field, value customer-addr-1, col data-col, 3-d, notify-change.
    03  entry-field, value customer-addr-2, line + 1, col data-col, 3-d
        notify-change.
    03  label "City:", line + separation, col label-col.
    03  entry-field, value customer-city, col data-col, 3-d, notify-change.
    03  label "State:", col + 4.
    03  entry-field, value customer-state, col + 2, 3-d, notify-change.
    03  label "Zip:", col + 4.
    03  entry-field, value customer-zip, col + 2, 3-d, notify-change.
    03  label "Phone:", line + separation, col label-col.
    03  entry-field, value customer-phone, col data-col, 3-d, notify-change.
    03  label "Contact:", line + separation, col label-col.
    03  entry-field, value customer-contact, col data-col, 3-d, notify-change.
    03  search-button, push-button, "&Search Records", line,
        col button-col, size 17,
        exception-value = search-button-value.
    03  push-button, "E&xit Program", line + separation,
        col button-col, size 17,
        exception-value = exit-button-value, self-act.

01  build-screen.
    03  label, "Data file has not been built. "
        line 2, col 5, ccol 3.
    03  label, "Press OK to build file, Cancel to exit program.",
        line 3, col 5, ccol 3.

    03 OKButton push-button, title "&OK", size 8, OK-button,
       termination-value 10, line 6, column 12.

    03 CancelButton push-button, title "&Cancel", size 8,
       Cancel-button, termination-value 27, line 6,
       column 26.

01  error-screen-1.
    03  label "Cannot find program 'bldcust'",
        line 3, col 5, ccol 1, lines 1, size 36.

    03 OKButton push-button, title "&OK", size 8,
       OK-button, termination-value 27, line 6 col 13.

procedure division.
main-logic.
    perform init.

    if (file-found)
       read customer-file next record
       display cust-screen

       perform until exit-button-pushed
          accept cust-screen allowing messages from any thread
             on exception continue
          end-accept
       end-perform
       close customer-file
    end-if.
    stop run.

init.
    display standard graphical window,
        auto-resize
        background-low, lines 14
        label-offset = 15, link to thread
        cell size is entry-field font, separate.
    perform open-customer-file.

* The following paragraph executes when the search button has been
* pressed. It calls the cancel program as a thread, starts the
* record search.

cust-screen-exception.
    evaluate true
       when search-button-pushed
          move zero to thread-return
          set done to false
          call thread "cancel",
             handle cancel-thread
             returning into thread-return
          end-call
          perform search-thru-records
    end-evaluate.

* This paragraph reads through the records and displays them
* on the screen. It checks to see if the user cancelled the
* search.

search-thru-records.
    perform until done
       if (thread-return = 99)
          set done to true
       end-if
       read customer-file next record
          at end
             set done to true
             move spaces to customer-name
             start customer-file key > customer-name
             end-start
             stop thread cancel-thread
          not at end
             display cust-screen
       end-read
    end-perform.

* Find out if the customer file exists. If it doesn't call
* 'bldcust', which will build the file. If that program
* doesn't exist, issue an error.

open-customer-file.
    set file-found to true.
    open input customer-file.
    if file-status not = "00"
       if file-status = "05"
          close customer-file
       end-if
       display floating graphical window
          handle in window-1
          size 45,
          col 20,
          lines 8,
          boxed, erase,
          title "Continue Box"

       display build-screen
       perform until key-entered = 27 or key-entered = 10
          accept build-screen
       end-perform
       close window window-1
       destroy build-screen

       if (key-entered = 10)
          call run "bldcust"
             on exception
                perform do-error
                set file-found to false
             not on exception
                open input customer-file
          end-call
       else
          set file-found to false
       end-if
    end-if.

do-error.
    display floating graphical window
       handle in window-1
       size 35,
       col 20,
       lines 8,
       boxed, erase,
       title "Program Error Box".

    display error-screen-1

    perform until key-entered = 27
       accept error-screen-1
    end-perform.

    close window window-1.
    destroy error-screen-1.

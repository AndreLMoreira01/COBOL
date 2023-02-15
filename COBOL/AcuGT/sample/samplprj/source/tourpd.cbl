       identification division.
       program-id.  wtour3pd.
       date-written.  01-May-95

      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.

       remarks.
           This program demonstrates how to use the ACCEPT and
           DISPLAY verbs to manage controls individually instead of
           using the Screen Section.

           Note that this program does not handle the Tab key
           correctly with regards to the radio buttons.  It fails
           to treat the radio buttons as a logical group.   Handling
           radio buttons in a group is difficult without using the
           Screen Section (although it is possible).  For this reason,
           Acucorp suggests that you use the Screen Section to
           implement radio button groups, even if you do not otherwise
           use the Screen Section.
      *********************************************************
       data division.
       working-storage section.

       copy "def/acucobol.def".
       copy "def/acugui.def".

       77  large-font                          handle.
       77  small-font                          handle.
       77  gt-bitmap                           pic s9(9) comp-4.

      * control handles
       77  handle-1 usage is handle of entry-field.
       77  handle-2 usage is handle of entry-field.
       77  handle-3 usage is handle of check-box.
       77  handle-4 usage is handle of radio-button.
       77  handle-5 usage is handle of radio-button.
       77  handle-6 usage is handle of label.
       77  handle-7 usage is handle of combo-box.
       77  handle-8 usage is handle of push-button.

       01  combo-box-choices.
           03  pic x(20) value "Beets, Todd".
           03  pic x(20) value "McCormley, Tim".
           03  pic x(20) value "Dent, Arthur".
           03  pic x(20) value "Aardvark, Arthur A.".
           03  pic x(20) value "Coker, Drake".
           03  pic x(20) value "Madison, Dawn".
           03  pic x(20) value "Mooney, Kate".
           03  pic x(20) value "Withey, Peter".
           03  pic x(20) value "Cavanagh, Bob".
           03  pic x(20) value "Wizard, Mr.".

       78  number-of-combo-choices             value 10.

       01  combo-choice
           redefines combo-box-choices
           occurs number-of-combo-choices times
           indexed by combo-idx                pic x(20).

       77  intro-text                          pic x(200) value
           "This program demonstrates the look and feel of some of the g
      -    "raphical controls supported by ACUCOBOL-GT.  Use this progra
      -    "m as an introduction on how to program graphical controls.".

       77  check-box-data                      pic 9 value zero.
       77  radio-button-data                   pic 9 value zero.
       77  entry-data-1                        pic x(10).
       77  entry-table occurs 20 times         pic x(70).
       77  combo-data                          pic x(20).

       77  key-status
                is special-names crt status     pic 9(4).
                88  exit-button-pushed  value 13.

       77  last-key-status                     pic 9(4) value 9.

       01  event-status
                is special-names event status.
           03  event-type                       pic x(4) comp-x.
           03  event-window-handle              usage handle.
           03  event-control-handle             usage handle.
           03  event-control-id                 pic x(2) comp-x.
           03  event-data-1                     usage signed-short.
           03  event-data-2                     usage signed-long.

       01 current-control                       pic 99.
      *********************************************************
       procedure division.
       main-logic.

      *    Grab the large and small fonts
           accept large-font from standard object "large-font".
           accept small-font from standard object "small-font".

      *    Setting Tab Left termination code
           set environment "KEYSTROKE"
               to "Edit=Previous Terminate=11 kB".

      *    Setup a gray screen background
           display standard window,
               title "Windows Procedure Division Sample - tourpd.cbl"
               lines 25, size 65,
               background-low.

      *    Load the bitmap (this just fails on a character system)
           copy resource "gtanima.bmp".
           call "w$bitmap" using wbitmap-load, "gtanima.bmp",
                   giving gt-bitmap

      *    Now display the screen.  We also fill-up the list of choices
      *    for the combo-box.

           perform display-screen.
           perform varying combo-idx from 1 by 1
                            until combo-idx > number-of-combo-choices
              modify handle-7, item-to-add = combo-choice (combo-idx)
           end-perform.

      *    Now accept user input. We have to check if there was an
      *    event such as the user clicking on a certain entry field.
      *    In this case, an exception is generated with value W-EVENT.
      *    Also, we have to check if the user pressed the Tab/Backtab Key.

           move 1 to current-control.
           perform, with test after, until exit-button-pushed
               perform accept-control
               perform set-next-control
           end-perform.
           stop run.

       display-screen.
           display label "ACUCOBOL-GT for Windows",
               line 1.5, column 18, ccol 21, size 25,
               font large-font, center.

           display bitmap, bitmap-handle = gt-bitmap,
               size 39, bitmap-start = 1, bitmap-end = 15,
               bitmap-timer = 10,
               line 1.5, column 57.

           display frame, rimmed,
               line 3, column 4, size 30, lines 9.

           display label, title intro-text,
               font small-font,
               line 4, column 5, size 28, csize 30 lines 7.

           display label "&Entry field",
               line 12, cline 13, column 5.

           display entry-field, 3-D,
               ID = 1, line 12, cline 13, column 15, ccol 19,
               handle in handle-1.

           display label "&Scrolling entry box",
               line 15, column 5.

           display entry-field,
               ID = 2, line 16.5, column 8, size 50, lines 5,
               max-lines = 20, vscroll-bar, 3-d,
               no-autosel, use-return,
               handle in handle-2.

           display check-box "&Check box",
               ID = 3, line 4, column 35, ccol 39,
               handle in handle-3.

           display frame, lowered,
               line 5.5, cline 6, column 34, ccol 38,
               lines 3, size 26.

           display radio-button, "Radio &1",
               ID = 4,
               line 6.5, cline 7, column 35, ccol 39,
               group-value = 1,
               handle in handle-4.

           display radio-button, "Radio &2",
               ID = 5,
               line 6.5, cline 7, column 46, ccol 51,
               group-value = 2,
               handle in handle-5.

      * We save the handle of the label so we can destroy it
      * if the combo-box fails to be constructed.  This allows
      * the key-letter <Alt-D> to work correctly.
           display label "&Drop-down box",
               line 8.5, cline 10, column 35, ccol 39
               handle in handle-6.

           display combo-box,
               ID = 6, line 10, cline 11, column 38, ccol 42, lines 5,
               3-d, size 20, handle in handle-7.

           if handle-7 is = null then
               destroy handle-6.

           display push-button, "E&xit Program",
               ID = 7, ok-button,
               line 23, column 25, size 13,
               handle in handle-8.

      * Accept current control
       accept-control.
           evaluate current-control
               when 1
                   accept handle-1 value in entry-data-1
               when 2
                   accept handle-2 value in multiple entry-table
               when 3
                   accept handle-3 value in check-box-data
               when 4
                   accept handle-4 value in radio-button-data
               when 5
                   accept handle-5 value in radio-button-data
               when 6
                   accept handle-7 value in combo-data
               when 7
                   accept handle-8
            end-evaluate.

      * set-next-control - determines which control to visit next based
      * on the key/event used to terminate the previous control.

       set-next-control.
            evaluate key-status
      * Tab key
               when 9
                   add 1 to current-control
                   if current-control > 7
                       move 1 to current-control
                   end-if
      * Backtab key
               when 11
                   if current-control = 1
                       move 7 to current-control
                   else
                       subtract 1 from current-control
                   end-if
      * Event occurred
               when W-EVENT
                   if event-type = CMD-GOTO
                       move event-control-id to current-control
                   end-if
      * Skip this control
               when 97
                   move last-key-status to key-status
                   go to set-next-control
            end-evaluate.
            move key-status to last-key-status.

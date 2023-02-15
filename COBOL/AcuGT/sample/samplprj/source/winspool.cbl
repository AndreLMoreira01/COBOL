       program-id.  winspool.

      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.

       remarks.
           This program demonstrates how to use the WIN$PRINTER library
           routine to control the Windows print spooler.

       file-control.
           select print-file
           assign to print "-p spooler"
           line sequential.

       file section.
       fd  print-file.
       01  print-line                          pic x(150).

       working-storage section.
       77  default-font                        handle of font.
       77  printing-window                     handle of window.
       77  ctr                                 pic 999.

       77  sample-data                         pic x(150)
           value "Sample print-out data".

       01  printer-info.
           03  lines-per-page                  pic 999.
           03  columns-per-page                pic 999.
           03  current-font                    pic 9.

       78  other-font                          value 9.
       77  other-font-name                     pic x(40) value "Other".
       77  other-font-handle                   handle of font.
       77  other-font-choosen-flag             pic 9 value zero.
           88  other-font-choosen              value 1.

       77  function-key-pressed
           is special-names crt status         pic 9(4).
           88  exit-button-pushed              value 13.

       01  screen-control
           is special-names screen control.
           03  accept-control                  pic 9.
               88  goto-current-field          value 1.
           03  control-value                   pic 9(3) value zero.

      * Button termination values (pretty arbitrary)
       78  font-button-pressed                 value 101.
       78  setup-button-pressed                value 102.
       78  print-button-pressed                value 103.
       78  choose-font-button-pressed          value 104.

       copy "def/winprint.def".
       copy "def/acucobol.def".
       copy "def/fonts.def".

       screen section.
       01  main-screen.
           03  label "Sample &data",
               line 2, col 3.

           03  entry-field using sample-data, 3-d,
               col + 2, size 50.

           03  frame "&Font",
               line 5, col, 3, lines 5.5 cells, size 29,
               engraved.

           03  radio-button, "Printer default"
               using current-font,
               group-value wprtfont-default,
               notify, termination-value = font-button-pressed
               line + 1, col 4.

           03  radio-button, "Courier 12",
               using current-font,
               group-value wprtfont-courier-12,
               notify, termination-value = font-button-pressed
               line + 1, col 4.

           03  radio-button, "Compressed",
               using current-font,
               group-value wprtfont-courier-12-comp,
               notify, termination-value = font-button-pressed
               col 17.

           03  radio-button, "Courier 10",
               using current-font,
               group-value wprtfont-courier-10,
               notify, termination-value = font-button-pressed
               line + 1, col 4.

           03  radio-button, "Compressed",
               using current-font,
               group-value wprtfont-courier-10-comp,
               notify, termination-value = font-button-pressed
               col 17.

           03  radio-button, title other-font-name,
               using current-font,
               group-value other-font, size 20,
               notify, termination-value = font-button-pressed
               line + 1, col 4
               enabled = other-font-choosen-flag.

           03  frame, line 5, col 34,
               lines 4.5 cells, size 24,
               engraved.

           03  page-layout-screen.
               05  label "Lines/page",
                   line + 1, col 36.
               05  entry-field from lines-per-page
                   col 49, enabled 0, low.
               05  label "Columns/page",
                   line + 1.5, col 36.
               05  entry-field from columns-per-page
                   col 49, enabled 0, high.

           03  push-button, "&Print", size 10,
               termination-value = print-button-pressed
               line 5, col 62.

           03  push-button, "F&ont...", size 10,
               termination-value = choose-font-button-pressed
               line + 1.5, col 62.

           03  push-button, "&Setup...", size 10,
               termination-value = setup-button-pressed
               line + 1.5, col 62.

           03  push-button, "E&xit", size 10,
               ok-button,
               line + 2, col 62.


       procedure division.
       main-logic.
           perform initialization
           display main-screen
           perform until exit-button-pushed
               set goto-current-field to true
               accept main-screen
               perform check-for-button-press
           end-perform
           stop run.

       initialization.
      * Get the initial printer page layout and save the information
           move wprtfont-default to current-font.
           perform get-page-layout.

      * Build the application screen
           accept default-font from standard object "default-font".
           display standard window,
               lines 11, size 75,
               cell size = entry-field font default-font
               title "Spooler Demonstation - winspool.cbl"
               background-low.

           accept terminal-abilities from terminal-info.
           if not has-graphical-interface
               display "This program demonstrates a feature (Windows"
               display "spooler support) that only functions under"
               display "Windows.  It is provided as a code sample, but"
               display "you can only view the results under Windows."
               display space
               display "Press return to exit: ", no advancing
               accept omitted, tab
               stop run.

      * check-for-button-press - called after the screen data has
      * been entered.  This routine looks to see if any interesting
      * buttons have been pushed and acts on them if so.
       check-for-button-press.
           evaluate function-key-pressed
             when font-button-pressed
                   if current-font = other-font
                       move other-font-handle to wprtdata-font
                       call "win$printer" using winprint-set-font,
                                                winprint-data
                   else
                       move current-font to wprtdata-std-font
                       call "win$printer" using winprint-set-std-font,
                                                winprint-data
                   end-if
                   perform get-page-layout
                   display page-layout-screen
             when setup-button-pressed
                   call "win$printer" using winprint-setup
                   perform get-page-layout
                   display page-layout-screen
             when print-button-pressed
                   perform print-sample
             when choose-font-button-pressed
                   initialize wfont-data
                   set wfdevice-win-printer to true
                   call "w$font" using wfont-choose-font, null,
                                       wfont-data
                   if return-code = 1
                       if other-font-handle not = null
                           destroy other-font-handle
                       end-if
                       call "w$font" using wfont-get-font,
                                           other-font-handle,
                                           wfont-data
                       move wfont-name to other-font-name
                       set other-font-choosen to true
                       move other-font to current-font
                       display main-screen
                       move font-button-pressed to function-key-pressed
                       go to check-for-button-press
                   end-if
           end-evaluate.

      * get-page-layout - gets the current page layout information
       get-page-layout.
           call "win$printer" using winprint-get-page-layout,
                                    winprint-data.
           move wprtdata-lines-per-page to lines-per-page.
           move wprtdata-columns-per-page to columns-per-page.

      * print-sample - print a sample page.  Note that we don't attempt
      * to handle any errors here.  If things don't work, the runtime
      * will just print the default error message and shutdown.
       print-sample.
           display floating window
               title "Printing",
               lines 6, size 25
               background-high
               handle in printing-window.

           display label "Printing occurring...",
               line 3, size 25 cells, center.

           open output print-file

           perform varying ctr from 1 by 1 until ctr > lines-per-page
               string "Line #", ctr, ": ", sample-data,
                   delimited by size, into print-line
               write print-line before advancing 1 line
           end-perform

           close print-file.

           destroy printing-window.

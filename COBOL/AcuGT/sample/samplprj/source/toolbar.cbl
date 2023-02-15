       identification division.
       program-id.  toolbar-demo.

      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.

       remarks.
           This program demonstrates how to display and use a tool-bar
           containing bitmap buttons.

       data division.
       working-storage section.

       copy "def/acucobol.def".
       copy "def/acugui.def".
       copy resource "tools1.bmp".

       77  large-font                          handle of font.
       77  default-font                        handle of font.
       77  small-font                          handle of font.
       77  current-font                        handle of font.
       77  toolbar-1                           handle of window.
       77  tools-bitmap                        pic s9(9) comp-4.
       77  win-programs-enabled                pic 9 value 1.

       77  demo-text                           pic x(200) value
           "This program demonstrates how to create a toolbar that conta
      -    "ins bitmap buttons.  The first two buttons run Windows utili
      -    "ty programs.  The remaining buttons act on this text.".

       77  key-status
           is special-names crt status         pic 9(4).
           88  exit-button-pushed       value 13.

       77  label-align                         pic 9 value 1.
           88  align-left                      value 1.
           88  align-right                     value 2.
           88  align-center                    value 4.

       78  calc-button-pressed                 value 1.
       78  notepad-button-pressed              value 2.
       78  change-font-pressed                 value 3.
       78  change-alignment-left               value 4.
       78  change-alignment-center             value 5.
       78  change-alignment-right              value 6.

       screen section.
       01  screen-1.
           03  label "Toolbar Demo",
               line 2, column 14, size 30 cells,
               font large-font, center.

           03  frame, rimmed,
               line 4, column 12, size 34 cells, lines 9.

           03  demo-label, label, title demo-text,
               font current-font, style label-align,
               line + 1, column 13, size 31 cells, lines 7.

           03  push-button, "E&xit Program",
               ok-button,
               line 16, column 22, size 13.

       01  tools.
           03  push-button, "Calculator", self-act, column 2
               bitmap, bitmap-number = 1, flat
               enabled = win-programs-enabled
               termination-value = calc-button-pressed.

           03  push-button, "Notepad", self-act, overlap-left
               bitmap, bitmap-number = 2, flat
               enabled = win-programs-enabled
               termination-value = notepad-button-pressed.

           03  bar, column + 2, lines 1.4, width = 2,
               color 8, shading = ( -1, 1 ).

           03  check-box, "Alternate font", self-act, column + 2,
               bitmap, bitmap-number = 3, notify, flat
               termination-value = change-font-pressed.

           03  bar, column + 2, lines 1.4, width = 2,
               color 8, shading = ( -1, 1 ).

           03  radio-button, "Left", self-act, column + 2,
               bitmap, bitmap-number = 4, notify, value 1, flat
               termination-value = change-alignment-left.

           03  radio-button, "Center", self-act, overlap-left,
               bitmap, bitmap-number = 5, notify, flat
               termination-value = change-alignment-center.

           03  radio-button, "Right", self-act, overlap-left
               bitmap, bitmap-number = 6, notify, flat
               termination-value = change-alignment-right.

       procedure division.
       main-logic.
           perform initialization.
           display standard window,
               title "Toolbar Demo - toolbar.cbl"
               lines 19, size 56, background-low,
               cell size is label font default-font.

           accept system-information from system-info.
           if not os-is-win-family
               move 0 to win-programs-enabled
           end-if.
           accept terminal-abilities from terminal-info.
           if not has-graphical-interface
               display "This program demonstrates a feature (tool bars)"
               display "that does not function on character systems."
               display "It is provided as a code sample, but you can"
               display "only view the results on a graphical system."
               display space
               display "Press return to exit: ", no advancing
               accept omitted, tab
               stop run.

      *    Load the tool-bar bitmaps from disk into memory.
           call "w$bitmap" using wbitmap-load, "tools1.bmp",
                           giving tools-bitmap.

      *    If that fails, we just shutdown.  Not very nice, but this is
      *    just a demo.
           if tools-bitmap <= 0
               stop run.

      *    Display the tool-bar and put the buttons on it.
           display tool-bar, lines 2.5
                background-low,
                handle in toolbar-1.
           display tools upon toolbar-1

      *    Now display the application screen.
           display screen-1.

      *    Now accept the screen.  We loop until the user presses the
      *    "Exit program" button.  The body of the loop handles the
      *    various bitmap buttons on the tool-bar.  These buttons act
      *    like function keys.

           perform, with test after, until exit-button-pushed

               accept screen-1

               evaluate key-status
                 when calc-button-pressed
                   call "c$run" using "calc.exe"
                 when notepad-button-pressed
                   call "c$run" using "notepad.exe"
                 when change-font-pressed
                   if current-font = default-font
                       move small-font to current-font
                   else
                       move default-font to current-font
                   end-if
                   display demo-label
                 when change-alignment-left
                   set align-left to true
                   display demo-label
                 when change-alignment-center
                   set align-center to true
                   display demo-label
                 when change-alignment-right
                   set align-right to true
                   display demo-label
               end-evaluate

           end-perform.

           stop run.

       initialization.
           accept large-font from standard object "large-font".
           accept default-font from standard object "default-font".
           accept small-font from standard object "small-font".
           move default-font to current-font.

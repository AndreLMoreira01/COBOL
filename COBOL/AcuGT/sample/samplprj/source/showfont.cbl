       program-id.  showfont.

      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.

       remarks.
           This program demonstrates the use of the font selection
           dialog available under graphical systems.

       working-storage section.
       77  wfont-status                        pic s99.
       77  h-font                              handle of font.
       77  label-data                          pic x(50).
       77  size-formatted                      pic 99.
       77  line-num                            pic 99v9.
       77  font-size                           pic 99.
       77  face-name                           pic x(40).
       77  char-set                            pic x comp-x.
       77  char-family                         pic x comp-x.
       77  key-status
           is special-names crt status         pic 999.
           88  select-font-pressed             value 1.
           88  ok-button-pressed               value 13.

       copy "def/fonts.def".
       copy "def/acugui.def".

       screen section.
       01  screen-1.
           03  push-button, "&Select Font", line 3, col 65
                   size 12, termination-value = 1.
           03  push-button, "E&xit", line 5.5, col 65
                   size 12, termination-value = 13.

       procedure division.
       main-logic.
           display standard graphical window
               title "Show Fonts".
           call "w$font" using wfont-supported
               giving wfont-status.
           if wfont-status not = wfont-full-support
               display "This program demonstrates the font selection"
               display "box found under Windows and Windows/NT.  This"
               display "program is provided as a code sample, but you"
               display "can only view the results under Windows."
               display space
               display "Press return to exit: ", no advancing
               accept omitted, tab
               stop run.

           display label,
               "Select a font to see samples of it from 6 to 16 points."
               line 3, col 3, temporary.
           display screen-1.

           perform until ok-button-pressed
               accept screen-1
               if select-font-pressed
                   perform show-font
               end-if
           end-perform.
           stop run.

       show-font.
           initialize wfont-data.
           call "w$font" using wfont-choose-font, null, wfont-data
               giving wfont-status.
           if wfont-status = wfonterr-cancelled
               exit paragraph.
           move wfont-name to face-name.
           move wfont-char-set to char-set.
           move wfont-family to char-family.

           display subwindow erase.
           move 2 to line-num
           perform show-font-size varying font-size from 6 by 1
                   until font-size is > 16.

       show-font-size.
           initialize wfont-data.
           move face-name to wfont-name.
           move font-size to wfont-size.
           move char-set to wfont-char-set
           move char-family to wfont-family
           call "w$font" using wfont-get-font, h-font,
                   wfont-data.

           if h-font = null
               exit paragraph.

           move wfont-size to size-formatted
           move spaces to label-data
           inspect wfont-name replacing trailing spaces by low-values
           string "This is ", delimited by size, wfont-name,
               delimited by low-values, " font at ", size-formatted,
               " points", delimited by size into label-data.

           display label label-data, line line-num, col 2,
               font h-font, temporary, left.

           initialize textsize-data.
           move h-font to textsize-font
           call "w$textsize" using label-data, textsize-data
           add textsize-cells-y to line-num.

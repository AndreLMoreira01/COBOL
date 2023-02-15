program-id.  test1.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program demonstrates the bar control, which allows
    the user to draw lines on the screen.

working-storage section.

77  label-font                  handle of font.

77  ctr                         pic 999.

copy "acucobol.def".

procedure division.
main-logic.
        perform initialization.
        accept label-font from standard object "large-font".
        display standard graphical window, background-low.

        display label "Sample Lines", line 3, col 35,
                color magenta, font label-font.

* Display the magenta lines around "Sample Lines" label.
        display bar, line 3.0, col 8, size 23, width 2, color magenta.
        display bar, line 3.6, col 5, size 25, width 3, color magenta.
        display bar, line 4.2, col 8, size 23, width 2, color magenta.

        display bar, line 3.0, col 52, size 23, width 2, color magenta.
        display bar, line 3.6, col 53, size 25, width 3, color magenta.
        display bar, line 4.2, col 52, size 23, width 2, color magenta.


* Display the green "pipes".
        display bar, line 5, col 2, size 78.6, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2).

        display bar, line 2, col 2, lines 3, clines 4, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2)
                trailing-shift = ( 3, 2, 1 ).

        display bar, line 2, col 2, size 78.6, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2)
                position-shift = -1
                leading-shift = ( 0, 1, 2, 3, 4 ).

        display bar, line 2, col 80, lines 3, clines 4, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2)
                leading-shift = (4, 3, 2, 1, 0)
                trailing-shift = ( 0, 1, 2, 3, 4 ).

        display bar, line 25, col 2, size 78.6, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2).

        display bar, line 5, col 40, lines 20, clines 21, width = 5,
                color green,
                shading = (-1, 1, 0, 0, -2)
                position-shift = -1
                leading-shift = (4, 3, 2, 3, 4)
                trailing-shift = ( 0, 1, 2, 1, 0 ).

        display label "Width 1:", line 7.3, col 3,
                font label-font.

        display bar, line 8, col 14, size 20.

        display label "Width 2:", line 9.3, col 3,
                font label-font.

        display bar, line 10, col 14, size 20, width = 2.


        display label "Shaded:", line 11.3, col 3,
                font label-font.

        display bar, line 12, col 14, size 20, width = 2,
                color white, low
                shading = (-1, 1)

        display label "Width 3:", line 13.3, col 3,
                font label-font.

        display bar, line 14, col 14, size 20, width = 3.

        display label "Shaded:", line 15.3, col 3,
                font label-font.

        display bar, line 16, col 14, size 20, width = 3,
                color white, low
                shading = (-1, -2, 1)

        display label "Width 4:", line 17.3, col 3,
                font label-font.

        display bar, line 18, col 14, size 20, width = 4.

        display label "Shaded:", line 19.3, col 3,
                font label-font.

        display bar, line 20, col 14, size 20, width = 4,
                color white, low
                shading = (-1, -1, 1, 1)

        display label "Pipe:", line 21.3, col 5,
                font label-font.

        display bar, line 22, col 14, size 20, width = 5,
                color white, low
                shading = (-1, 2, 0, -1, -2 ).

        display label "Dotted:", line 7.3, col 45,
                font label-font.

        display bar, line 8, col 55, size 20, color = red, dotted.

        display label "Dashed:", line 9.3, col 45,
                font label-font.

        display bar, line 10, col 55, size 20, color = blue, dashed.

* Display the blue sideways "T".
        display bar, line 13, col 50, lines 8, width = 4,
                colors = ( 1, 12, 12, 1 ),
                position-shift = -1.
        display bar, line 16, col 43, size 7, csize 8, width = 4,
                colors = ( 1, 12, 12, 1 ).

* Display the upside down "L".
        display bar, line 13, col 53, lines 8, width = 3
                colors = ( 1, 16, 1 ).
        display bar, line 13, col 53, size 10, width = 3,
                colors = ( 1, 16, 1 ),
                leading-shift = ( 0, 1, 2 ).

* Display the backwards "L".
        display bar, line 13, col 64, lines 8, clines 9, width = 5
                color white, low
                shading = (-1, 2, 0, -1, -2).
        display bar, line 21, col 55, size 9, csize 10, width = 5,
                color white, low,
                shading = (-1, 2, 0, -1, -2 )
                position-shift = -4,
                trailing-shift = ( 1, 2, 3, 4, 5 )

* Display the thin to thick blue lines.
        perform varying ctr from 1 by 1 until ctr > 10
            display bar, line ctr + 12, col 68, size 10,
                color blue, high, width = ctr
        end-perform.

        accept omitted.
        stop run.

initialization.
        accept terminal-abilities from terminal-info.

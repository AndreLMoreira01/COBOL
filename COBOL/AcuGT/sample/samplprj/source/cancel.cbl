identification division.
program-id. cancel-print.

environment division.

configuration section.

source-computer. IBM-PC.
object-computer. IBM-PC.

data division.

working-storage section.

copy "def/acucobol.def".
copy "def/acugui.def".

77  fixed-font        handle of font.
77  traditional-font  handle of font.
77  default-font      handle of font.
77  large-font        handle of font.
77  medium-font       handle of font.
77  small-font        handle of font.

77  floating-window   handle of window.

77  key-status
    is special-names crt status pic 9(5) value zero.
    88 cancel-button-hit        value 27.

01  cancel-screen-variables.
    03  screen-area pic x(1).

screen section.

01  cancel-screen-1.
    03  label
        "Searching records... Cancel to stop"
        line   3.00
        col    5.00
        lines  1.00 cells
        size   36.50 cells
        label-offset 0
        .
    03 CancelButton push-button
       title  "&Cancel"
       size   8.80 cells
       cancel-button
       termination-value 27
       line   6.00
       column 20.00
       id     1
       permanent
       visible 1
       .

procedure division.

main-logic.

*   Set the font handles
    accept fixed-font from standard object "fixed-font".
    accept traditional-font from standard object
           "traditional-font".
    accept default-font from standard object "default-font".
    accept large-font from standard object "large-font".
    accept medium-font from standard object "medium-font".
    accept small-font from standard object "small-font".

    display floating graphical window
       bind to thread,
       handle in floating-window
       size   47.00
       lines  9.00
       boxed, erase,
       cell size = label font default-font
       control font default-font
       title "Cancel Box"
       .

*   Display the screen.
    display cancel-screen-1.

    perform until cancel-button-hit
       accept cancel-screen-1
    end-perform.

    close window floating-window.
    destroy cancel-screen-1.

    goback returning 99.

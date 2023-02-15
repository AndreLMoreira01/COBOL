identification division.
program-id.     test-mouse.

data division.
working-storage section.
copy "def/acugui.def".
01  mouse-status                pic 9.
01  exc-key                     pic 999.
01  line-no                     pic s99 value 1.
01  col-no                      pic 999 value 1.
01  dsp-char                    pic 9.

screen section.
01  mouse-screen.
    03  "mouse: row:"           line 15.
    03  from mouse-row          col 15.
    03  "col:"                  line 16 col 8.
    03  from mouse-col          col 15.
    03  "Left:"                 line 17 col 8.
    03  from lbutton-status     col 15.
    03  "Mid:"                  line 18 col 8.
    03  from mbutton-status     col 15.
    03  "Right:"                line 19 col 8.
    03  from rbutton-status     col 15.
    03  "Stat:"                 line 20 col 8.
    03  from exc-key            col 15.
procedure division.
main.
    display window erase.
    display "Mouse test - Press F1 to exit" line 1 col 1.
    set environment "mouse-flags" to 2046.
    perform until exc-key = 1
        accept omitted line line-no col col-no
          on exception exc-key
            if exc-key >= 80 and <= 89
                call "W$MOUSE" using get-mouse-status, mouse-info
                        giving mouse-status
                display mouse-screen
                move mouse-row to line-no
                move mouse-col to col-no
                move 0 to dsp-char
                if lbutton-down
                    add 4 to dsp-char
                end-if
                if mbutton-down
                    add 2 to dsp-char
                end-if
                if rbutton-down
                    add 1 to dsp-char
                end-if
                display dsp-char line line-no col col-no
            end-if
        end-accept
    end-perform.
    stop run.

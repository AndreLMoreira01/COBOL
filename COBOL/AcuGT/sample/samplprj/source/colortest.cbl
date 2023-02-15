identification division.
program-id.     colortest.
environment division.
special-names.
    screen control is screen-control.

data division.
working-storage section.
01  screen-control.
    03  accept-control                  pic 9.
    03  control-value                   pic 999.

01  color-table usage comp-1.
    03  black                           pic 9(5) value 1.
    03  blue                            pic 9(5) value 2.
    03  green                           pic 9(5) value 3.
    03  cyan                            pic 9(5) value 4.
    03  red                             pic 9(5) value 5.
    03  magenta                         pic 9(5) value 6.
    03  brown                           pic 9(5) value 7.
    03  white                           pic 9(5) value 8.
    03  backgrnd-black                  pic 9(5) value 32.
    03  backgrnd-blue                   pic 9(5) value 64.
    03  backgrnd-green                  pic 9(5) value 96.
    03  backgrnd-cyan                   pic 9(5) value 128.
    03  backgrnd-red                    pic 9(5) value 160.
    03  backgrnd-magenta                pic 9(5) value 192.
    03  backgrnd-brown                  pic 9(5) value 224.
    03  backgrnd-white                  pic 9(5) value 256.
    03  use-reverse                     pic 9(5) value 1024.
    03  use-dim                         pic 9(5) value 2048.
    03  use-bold                        pic 9(5) value 4096.
    03  use-underline                   pic 9(5) value 8192.
    03  use-blink                       pic 9(5) value 16384.

77  color-val                           pic 9(5).
77  save-color-val                      pic 9(5).
77  back-val                            pic 9(5).
77  fore-val                            pic 9(5).
77  line-no                             pic 999.
77  col-no                              pic 999.
77  test-key                            pic x.
77  description                         pic x(40).
77  exc-val                             pic 999.
    88  esc-val                                 value 27.
    88  kl-val                                  value 52.

screen section.
01  choice-screen.
    03  "Color Test Program"                            line 1 col 30.
    03  "This program displays all possible color combinations with"
                                                        line + 2 col 5.
    03  "the following extra attributes added:"         line + 1 col 5.
    03  "None"                                          line + 2 col 2.
    03  using test-key                                          col 1
        before procedure is no-extra-color-val.
    03  "Reverse"                                               col 27.
    03  using test-key                                          col 26
        before procedure is reverse-val.
    03  "Dim"                                                   col 52.
    03  using test-key                                          col 51
        before procedure is dim-val.
    03  "Bold"                                          line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is bold-val.
    03  "Underlined"                                            col 27.
    03  using test-key                                          col 26
        before procedure is ul-val.
    03  "Blinking"                                              col 52.
    03  using test-key                                          col 51
        before procedure is blinking-val.
    03  "Reverse and Dim"                               line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is reverse-dim-val.
    03  "Reverse and Bold"                                      col 27.
    03  using test-key                                          col 26
        before procedure is reverse-bold-val.
    03  "Reverse and Underlined"                                col 52.
    03  using test-key                                          col 51
        before procedure is reverse-ul-val.
    03  "Reverse and Blinking"                          line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is reverse-blinking-val.
    03  "Dim and Underlined"                                    col 27.
    03  using test-key                                          col 26
        before procedure is dim-ul-val.
    03  "Dim and Blinking"                                      col 52.
    03  using test-key                                          col 51
        before procedure is dim-blinking-val.
    03  "Bold and Underlined"                           line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is bold-ul-val.
    03  "Bold and Blinking"                                     col 27.
    03  using test-key                                          col 26
        before procedure is bold-blinking-val.
    03  "Underlined and Blinking"                               col 52.
    03  using test-key                                          col 51
        before procedure is ul-blinking-val.
    03  "Reverse, Dim and Underlined"                   line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is reverse-dim-ul-val.
    03  "Reverse, Dim and Blinking"                             col 42.
    03  using test-key                                          col 41
        before procedure is reverse-dim-blinking-val.
    03  "Reverse, Bold and Underlined"                  line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is reverse-bold-ul-val.
    03  "Reverse, Bold and Blinking"                            col 42.
    03  using test-key                                          col 41
        before procedure is reverse-bold-blinking-val.
    03  "Dim, Underlined and Blinking"                  line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is dim-ul-blinking-val.
    03  "Bold, Underlined and Blinking"                         col 42.
    03  using test-key                                          col 41
        before procedure is bold-ul-blinking-val.
    03  "Reverse, Dim, Underlined and Blinking"         line + 1 col 2.
    03  using test-key                                          col 1
        before procedure is rev-dim-ul-blinking-val.
    03  "Reverse, Bold, Underlined and Blinking"                col 42.
    03  using test-key                                          col 41
        before procedure is rev-bold-ul-blinking-val.
    03  "Press <RETURN> to execute your choice, or <ESC> to exit"
                                                        line + 2.

procedure division.
main-logic.
    display window erase.
    set environment "keystroke" to "edit=previous exception=52 kl".
    perform until esc-val
        display choice-screen
        accept choice-screen
          on exception
            accept exc-val from escape
            if kl-val
                move 1 to accept-control
                move 22 to control-value
            end-if
          not on exception
            perform display-all-colors
            move 1 to accept-control
        end-accept
    end-perform.
    stop run.

no-extra-color-val.
    move 0 to color-val.
    move "No extra color value" to description.

reverse-val.
    move use-reverse to color-val.
    move "Reverse" to description.

dim-val.
    move use-dim to color-val.
    move "Dim" to description.

bold-val.
    move use-bold to color-val.
    move "Bold" to description.

ul-val.
    move use-underline to color-val.
    move "Underlined" to description.

blinking-val.
    move use-blink to color-val.
    move "Blinking" to description.

reverse-dim-val.
    compute color-val = use-reverse + use-dim.
    move "Reverse, Dim" to description.

reverse-bold-val.
    compute color-val = use-reverse + use-bold.
    move "Reverse, Bold" to description.

reverse-ul-val.
    compute color-val = use-reverse + use-underline.
    move "Reverse, Underline" to description.

reverse-blinking-val.
    compute color-val = use-reverse + use-blink.
    move "Reverse, Blink" to description.

dim-ul-val.
    compute color-val = use-dim + use-underline.
    move "Dim, Underline" to description.

dim-blinking-val.
    compute color-val = use-dim + use-blink.
    move "Dim, Blink" to description.

bold-ul-val.
    compute color-val = use-bold + use-underline.
    move "Bold, Underline" to description.

bold-blinking-val.
    compute color-val = use-bold + use-blink.
    move "Bold, Blink" to description.

ul-blinking-val.
    compute color-val = use-underline + use-blink.
    move "Underline, Blink" to description.

reverse-dim-ul-val.
    compute color-val = use-reverse + use-dim + use-underline.
    move "Reverse, Dim, Underline" to description.

reverse-dim-blinking-val.
    compute color-val = use-reverse + use-dim + use-blink.
    move "Reverse, Dim, Blink" to description.

reverse-bold-ul-val.
    compute color-val = use-reverse + use-bold + use-underline.
    move "Reverse, Bold, Underline" to description.

reverse-bold-blinking-val.
    compute color-val = use-reverse + use-bold + use-blink.
    move "Reverse, Bold, Blink" to description.

dim-ul-blinking-val.
    compute color-val = use-dim + use-underline + use-blink.
    move "Dim, Underline, Blink" to description.

bold-ul-blinking-val.
    compute color-val = use-bold + use-underline + use-blink.
    move "Bold, Underline, Blink" to description.

rev-dim-ul-blinking-val.
    compute color-val = use-reverse + use-dim + use-underline + use-blink.
    move "Reverse, Dim, Underline, Blink" to description.

rev-bold-ul-blinking-val.
    compute color-val = use-reverse + use-bold + use-underline + use-blink.
    move "Reverse, Bold, Underline, Blink" to description.

display-all-colors.
    display window erase.
    display description line 1.
    move color-val to save-color-val.
    display "Foreground" line 4 col 35
        "Black   Blue    Green   Cyan    Red     Magenta Brown  White"
                        line 5 col 15
        "   Black"      line 6 col 2
        "B  Blue"       line 8 col 2
        "a"             line 9 col 2
        "c  Green"      line 10 col 2
        "k"             line 11 col 2
        "g  Cyan"       line 12 col 2
        "r"             line 13 col 2
        "o  Red"        line 14 col 2
        "u"             line 15 col 2
        "n  Magenta"    line 16 col 2
        "d"             line 17 col 2
        "   Brown"      line 18 col 2
        "   White"      line 20 col 2.
    move 6 to line-no.
    perform varying back-val from 32 by 32 until back-val > 256
        move 15 to col-no
        perform varying fore-val from 1 by 1 until fore-val > 8
            compute color-val = save-color-val + back-val + fore-val
            display "Test   " line line-no col col-no color color-val
            add 8 to col-no
        end-perform
        add 2 to line-no
    end-perform.
    add 2 to line-no.
    display "Press <RETURN> to go back to the menu" line line-no col 1.
    accept omitted.
    display window erase.

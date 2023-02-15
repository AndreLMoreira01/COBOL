identification division.
program-id.     colortest.
*       Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
*       may freely modify and redistribute this program.

remarks.
        This program shows all the colors, with modifiers, available
        to COBOL programmers.

data division.
working-storage section.
copy "def/acucobol.def".
copy "def/palette.def".

01  intro-text                          pic x(200) value
        "This program displays all possible color combinations with the 
-       "following extra attributes added:".

78  intensity-dim                       value 1.
78  intensity-bold                      value 2.

77  color-val                           pic 9(5).
77  large-font                          handle of font.
77  small-font                          handle of font.
77  default-font                        handle of font.
77  float-handle                        handle.
77  push-handle                         handle of push-button.
77  intensity-flag                      pic 9 value zero.
77  reverse-flag                        pic 9 value zero.
77  underlined-flag                     pic 9 value zero.
77  blinking-flag                       pic 9 value zero.

77  save-color-val                      pic 9(5).
77  back-val                            pic 9(5).
77  fore-val                            pic 9(5).
77  line-no                             pic 999.
77  col-no                              pic 999.
77  description                         pic x(40).
77  exc-val                             pic 999.
    88  esc-val                                 value 27.

screen section.
01  choice-screen.
    03  label "Color Test Program"
                line 2 col 10 size 25 font large-font center.
    03  label title intro-text
                line 4 col 5 size 40 lines 5 font small-font.
    03  radio-button "Default" using intensity-flag
                line + 3, col 15, group-value = 3.
    03  radio-button "Dim" using intensity-flag
                line + 1, col 15, group-value = intensity-dim.
    03  radio-button "Bold" using intensity-flag
                line + 1, col 15, group-value = intensity-bold.
    03  check-box "Reverse" using reverse-flag
                line + 1, col 15.
    03  check-box "Underlined" using underlined-flag
                line + 1, col 15.
    03  check-box "Blinking" using blinking-flag
                line + 1, col 15.
    03  push-button "&Draw" ok-button line + 3 col 5.
    03  push-button "&Select" exception-value 35 col + 5.
    03  push-button "E&xit" escape-button exception-value 27 col + 5.

procedure division.
main-logic.
    accept large-font from standard object "large-font".
    accept default-font from standard object "default-font".
    accept small-font from standard object "small-font".
    display standard window
        size 40
        lines 20
        background-low
        cell height is entry-field font default-font separate
        title "Color Test".
    set environment "background-intensity" to "1".

    perform until esc-val
        set environment "background-intensity" to "1"
        display choice-screen
        accept choice-screen
          on exception
            accept exc-val from escape
            evaluate exc-val
              when 35
                move 0 to wpal-flags
                move 0 to wpal-red, wpal-green, wpal-blue
                call "W$PALETTE" using WPALETTE_CHOOSE_COLOR, WPALETTE-DATA giving return-code
            end-evaluate
          not on exception
            perform display-all-colors
        end-accept
    end-perform.
    stop run.

***   Pop up a new canvas, and display all the colors in a reasonable way.
***   Keep track of what flags are set, so we can display some text
***   about what this configuration is.
display-all-colors.
    move 0 to color-val.
    move "Flags: " to description.
    move 8 to col-no.
    if reverse-flag = 1
        add color-reverse to color-val
        move "Reverse" to description (col-no:)
        add 8 to col-no
    end-if.
    if underlined-flag = 1
        add color-underline to color-val
        move "Underline" to description (col-no:)
        add 10 to col-no
    end-if.
    if blinking-flag = 1
        add color-blink to color-val
        move "Blink" to description (col-no:)
        add 6 to col-no
    end-if.
    evaluate intensity-flag
      when intensity-dim
        add frgrnd-low to color-val
        move "Dim" to description (col-no:)
        add 4 to col-no
      when intensity-bold
        add frgrnd-high to color-val
        move "Bold" to description (col-no:)
        add 5 to col-no
    end-evaluate.

    move color-val to save-color-val.
    compute color-val = black + bckgrnd-white.
    set environment "background-intensity" to "0".
    display floating window size 80 lines 24 erase
        color color-val handle in float-handle.
    display description line 1.
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
    add 1 to line-no.
    display push-button "Return to main screen" line line-no col 20
                size 30 handle in push-handle.
    accept push-handle.
    destroy push-handle.
    destroy float-handle.

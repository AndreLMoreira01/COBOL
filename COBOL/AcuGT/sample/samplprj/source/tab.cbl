program-id.  tabtest.

* Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
* may freely modify and redistribute this program.

remarks.
    This program demonstrates the use of the tab control.

working-storage section.

78  RED-ID                      value 300.
78  BLUE-ID                     value 301.
78  GREEN-ID                    value 302.
78  DEFAULT-FONT-ID             value 303.
78  SMALL-FONT-ID               value 304.
78  MEDIUM-FONT-ID              value 305.
78  LARGE-FONT-ID               value 306.

77  tab-1                       handle of tab-control.

77  main-window                 handle of window.
77  window-1                    handle of window.

77  entry-value                 pic x(10).
77  tab-value                   pic 99.
77  button-value                pic 9 value 1.
77  color-button-value          pic 9 value 1.
77  font-button-value           pic 9 value 1.


77  fixed-font                  handle of font.
77  traditional-font            handle of font.
77  default-font                handle of font.
77  large-font                  handle of font.
77  medium-font                 handle of font.
77  small-font                  handle of font.

77  key-status
    is special-names crt status pic 9(5) value zero.
    88 cancel-button-hit        value 100.
    88 save-button-hit          value 101.
    88 apply-button-hit         value 102.

77  frame-color                 pic 9(6).
77  frame-font                  handle of font.

01  user-info.
    03 user-name                pic x(20).
    03 user-address-1           pic x(20).
    03 user-address-2           pic x(20).
    03 user-telephone           pic x(20).

01  winversion-data.
    03 win-major-version        pic x comp-x.
    03 win-minor-version        pic x comp-x.
    03 win-platform             pic x comp-x.
       88 platform-win-31       value 1.
       88 platform-win-95       value 2.
       88 platform-win-nt       value 3.
    03 win-wordsize             pic x comp-x.
       88 win-wordsize-16       value 1.
       88 win-wordsize-32       value 2.

01  message-txt             pic x(240)
     value  "This program demonstrates a feature (tab-control) that only
-    " functions under 32-bit Windows using the 32-bit Windows runtime.
-    " It is provided as a code sample, but you cannot view the results wit
-    "h this runtime system.".


copy "def/acucobol.def".
copy "def/crtvars.def".
copy "def/acugui.def".

screen section.

* These are the screens that go on the various tabs.
01  settings-screen.
        03  radio-button, "Custom Settings", line 10, col 8
            group 1, group-value 1, using button-value.
        03  radio-button, "Restore Default Settings", line 12, col 8
            group 1, group-value 2, using button-value.
        03  push-button, "Change Custom Settings",
            size 22, line 9.8, col 24, ok-button.

01  app-screen.
        03  frame-1, frame, "Color", raised,
            line 6, col 9, size 15, lines 10.

        03  radio-button, "Red", line 9, color red,
            col 11 group 2, group-value 1, visible 1,
            event procedure is change-app, id RED-ID,
            using color-button-value.

        03  radio-button, "Blue", line 10.5, color blue,
            col 11 group 2, group-value 2,
            event procedure is change-app, id BLUE-ID,
            using color-button-value.

        03  radio-button, "Green", line 12, color green,
            col 11 group 2, group-value 3,
            event procedure is change-app, id GREEN-ID,
            using color-button-value.

        03  frame-2, frame, "Font", raised, line 6,
            col 25, size 20, lines 10.

        03  radio-button, "Default Font", line 8, col 27
            group 3, group-value 1, visible 1, font default-font,
            event procedure is change-app, id DEFAULT-FONT-ID,
            using font-button-value.

        03  radio-button, "Small Font", line 9.5, col 27
            group 3, group-value 2, font small-font,
            event procedure is change-app, id SMALL-FONT-ID,
            using font-button-value.

        03  radio-button, "Medium Font", line 11, col 27
            group 3, group-value 3, font medium-font,
            event procedure is change-app, id MEDIUM-FONT-ID,
            using font-button-value.

        03  radio-button, "Large Font", line 12.5, col 27
            group 3, group-value 4, font large-font,
            event procedure is change-app, id LARGE-FONT-ID,
            using font-button-value.

01  info-screen.
        03  label, "Name:", col 13, line 7.
        03  label, "Address:", col 11, line 9.
        03  label, "Phone:", col 12.5, line 13.

        03  entry-field, col 18, line  7, size 20, using user-name.
        03  entry-field, col 18, line  9, size 20, using user-address-1.
        03  entry-field, col 18, line 11, size 20, using user-address-2.
        03  entry-field, col 18, line 13, size 20, using user-telephone.

01  config-screen.
        03  check-box, "Default Configuration", line 8, col 12
            using button-value.
        03  push-button, "Change Configuration",
            size 23, line 10, col 12, ok-button.

01  quit-screen.
        03  push-button, "Save Changes",
            line 10, col 19, size 15, cancel-button.
        03  push-button, "Cancel Changes",
            line 12, col 19, size 15, cancel-button.
        03  push-button, "Apply Changes",
            line 14, col 19, size 15, cancel-button.

01 message-screen.
    03 label title message-txt center
               line 1 col 2 size 45 cells, lines 6.
    03 push-button, line 7.5, cline 8, col 20
               lines 1.5 "OK", ok-button.


procedure division.
main-logic.

     perform initialization.
*    Set the font handles
        accept fixed-font from standard object "fixed-font".
        accept traditional-font from standard object
               "traditional-font".
        accept default-font from standard object "default-font".
        accept large-font from standard object "large-font".
        accept medium-font from standard object "medium-font".
        accept small-font from standard object "small-font".

        set frame-color to red.
        move default-font to frame-font.

        display standard window, background-low,
                size 55, lines 26, handle in main-window.

        display label
           "NOTE: This program is an example of an appropriate",
            line 21, col 7.

        display label
           "use for the windows tab control. It DOES NOT change"
            line 22, col 7.

        display label
           "any system settings, or change anything outside of this"
            line 23, col 7.

        display label
           "program."
            line 24, col 7.

*  Display the tab control.
        display tab-control upon main-window, line 2, col 7,
                size 45, lines 20,
                multiline, handle tab-1.

* Add tabs to the tab control.
        modify tab-1, tab-to-add = ("&Settings", "&User Information",
                                    "&Configuration", "&Appearance", "&Exit" )

* This code handles clicking on the tabs. It displays, accepts, and
* destroys the individual screens for each tab that is clicked.

        set tab-value to 1.
        perform until key-status = 27
           inquire tab-1, value in tab-value
           evaluate tab-value
              when 1
                 display settings-screen
                 accept settings-screen
                 destroy settings-screen
              when 2
                 display info-screen
                 accept info-screen
                 destroy info-screen
              when 3
                 display config-screen
                 accept config-screen
                 destroy config-screen
              when 4
                 display app-screen
* Display the color, font that was chose on the appearance tab.
                 modify frame-1, color = frame-color
                 display frame-1
                 modify frame-2, font = frame-font
                 display frame-2
                 accept app-screen
                 destroy app-screen
              when 5
                 display quit-screen
                 accept quit-screen
                 destroy quit-screen
              when other
                 accept omitted, line 2
           end-evaluate
        end-perform.
        stop run.

initialization.
        accept terminal-abilities from terminal-info.
        if (has-graphical-interface)
           call "win$version" using winversion-data
           evaluate true
             when win-wordsize-16
                perform display-message
             when win-wordsize-32
                continue
             when other
                perform display-message
           end-evaluate
        else
           perform display-message
         end-if.

display-message.
        display floating window line 10 col 15
               size 50 lines 10
               title-bar
               title "Tab Control Requires 32-Bit Windows runtime"
               system menu
               boxed, erase,
               background-low
               handle window-1.
        display message-screen line 2 col 2.
        accept message-screen.
        stop run.


change-app.

    if event-type is equal to cmd-clicked then
    evaluate event-control-id
        when RED-ID
          set frame-color to red
          modify frame-1, color = frame-color
        when BLUE-ID
          set frame-color to blue
          modify frame-1, color = frame-color
        when GREEN-ID
          set frame-color to green
          modify frame-1, color = frame-color
        when DEFAULT-FONT-ID
           move default-font to frame-font
           modify frame-2, font = frame-font
        when SMALL-FONT-ID
           move small-font to frame-font
           modify frame-2, font = frame-font
        when MEDIUM-FONT-ID
           move medium-font to frame-font
           modify frame-2, font = frame-font
        when LARGE-FONT-ID
           move large-font to frame-font
           modify frame-2, font = frame-font
    end-evaluate
    end-if.

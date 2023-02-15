identification division.
program-id.     sample-program.

* Copyright (c) 1989-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

*
* This program demonstrates a few of the features of ACUCOBOL.
*
* To run this program, compile it with "ccbl sample.cbl".
* Then run it with "runcbl".
*

data division.

working-storage section.

01      menu-selection                  pic 9(4).
        88  info-selected               value 1.
        88  portability-selected        value 2.
        88  specs-selected              value 3.
        88  exit-selected               value 4.

01      return-window                   pic x(10).
01      selection-window                pic x(10).
01      time-window                     pic x(10).

01      current-time.
        03  current-hour                pic 99.
        03  current-minute              pic 99.
        03  current-second              pic 99.
        03  filler                      pic 99.

01      terminfo.
        03  terminal-name               pic x(10).
        03  filler                      pic x(1).
            88  has-reverse             value "Y".
        03  filler                      pic x(1).
        03  filler                      pic x(1).
            88  has-underline           value "Y".
        03  filler                      pic x(2).
        03  filler                      pic x(1).
            88  has-color               value "Y".

01      color-table usage comp-1.
        03  black                       pic 9(5) value 1.
        03  blue                        pic 9(5) value 2.
        03  green                       pic 9(5) value 3.
        03  cyan                        pic 9(5) value 4.
        03  red                         pic 9(5) value 5.
        03  magenta                     pic 9(5) value 6.
        03  brown                       pic 9(5) value 7.
        03  white                       pic 9(5) value 8.
        03  backgrnd-black              pic 9(5) value 32.
        03  backgrnd-blue               pic 9(5) value 64.
        03  backgrnd-green              pic 9(5) value 96.
        03  backgrnd-cyan               pic 9(5) value 128.
        03  backgrnd-red                pic 9(5) value 160.
        03  backgrnd-magenta            pic 9(5) value 192.
        03  backgrnd-brown              pic 9(5) value 224.
        03  backgrnd-white              pic 9(5) value 256.
        03  use-reverse                 pic 9(5) value 1024.
        03  use-dim                     pic 9(5) value 2048.
        03  use-bold                    pic 9(5) value 4096.
        03  use-underline               pic 9(5) value 8192.
        03  use-blink                   pic 9(5) value 16384.

77      return-window-color             pic 9(5) comp-1.
77      stand-out                       pic 9(5) comp-1.
77      filler                          pic 9.
        88  done                        value 1, false zero.

screen section.

01  time-fields.
        03  from current-hour.
        03  ":".
        03  from current-minute.
        03  ":".
        03  from current-second.

procedure division.

level-1 section.
main-logic.
        perform initialize-environment.

        display " ACUCOBOL-GT DEMONSTRATION ", erase screen, line 1,
                        column 26, reversed, color return-window-color.
        display window line 6, column 20, size 40, lines 12, boxed,
                                color cyan.
        display window line 6, column 20, size 40, lines 12, color green.

        display "Welcome to ACUCOBOL-GT" line 1, size 40, centered,
                                        color white.
        display "Please Select: ", line 3, column 8.
        display "F1 = General Information", line 5, column 8.
        display "F2 = Portability Issues", line 7, column 8.
        display "F3 = Specifications", line 9, column 8.
        display "F4 = Exit Demonstration", line 11, column 8.

        perform do-main-menu with test after
                until exit-selected.

        stop run.

do-main-menu.
        perform show-time.

        accept omitted, line 3, column 23, tab,
                before time 100,
                control key in menu-selection.

        if info-selected
            perform do-info
        else if portability-selected
            perform do-portability
        else if specs-selected
            perform do-specifications.

return-to-menu.
        display window line 22, column 15, size 50, lines 3,
                        color return-window-color, erase,
                        pop-up area return-window.
        display "Press enter to return to menu: ", line 2, column 11.
        perform get-return.
        close window return-window.
        close window selection-window.

get-return.
        set done to false.
        perform until done
                accept omitted, no advancing, before time 100
                        on exception    perform show-time,
                        not exception   set done to true;
                end-accept
        end-perform.

show-time.
        accept current-time from time.
        display window line 1, column 70, lines 1, size 9,
                color green + backgrnd-black,
                pop-up area is time-window.
        display time-fields.
        close window time-window, with no display.

initialize-environment.
        accept terminfo from terminal-info.
        if has-color
                add backgrnd-blue, white giving return-window-color;
        else
                add backgrnd-white, black giving return-window-color.
        if has-underline
                move use-underline to stand-out;
        else
                move use-bold to stand-out.

information section.
do-info.
        display window pop-up area is selection-window.
        display window line 3, column 2, size 43, lines 9, boxed, color cyan.
        display window line 3, column 3, size 42, lines 9.
        display "ACUCOBOL-GT", high, " is a new COBOL compiler".
        display "designed to meet the needs of the serious".
        display "applications designer.  ", "ACUCOBOL", high, " features".
        display "fast", color stand-out, " compilation and the ability to".
        display "compile the large applications needed by"
        display "today's developers.  ".
        display space.
        display "ACUCOBOL", high, " has the features to develop".
        display "applications quickly.  These include:", no advancing.

        if has-reverse
            display window line 7, column 53, size 25, lines 3, reversed,
                                        color magenta
        else
            display window line 7, column 53, size 25, lines 3, boxed,
                                        color magenta.
        display "Built-in windowing...", line 2, size 25, centered.

        if has-reverse
            display window line 16, column 5, size 30, lines 3, reversed,
                                        color red;
        else
            display window line 16, column 5, size 30, lines 3, boxed,
                                        color red.
        display "Clear error messages...", line 2, size 30, centered.

        display window line 18, column 40, size 40, lines 3, boxed,
                                        color white.
        display "...and a built-in ", line 2, column 3.
        display "source", color stand-out, " debugger.".

        perform return-to-menu.

portability section.
do-portability.
        display window line 5, column 13, lines 11, size 53, boxed,
                                title "Portability Issues", color cyan,
                                pop-up area is selection-window.
        display window line 5, column 14, lines 11, size 51, color green,
                        with no wrap.
        display "ACUCOBOL", high, " is designed to allow applications".
        display "to be developed for a wide-range of machines: from".
        display "personal computers to super-minis.  Both the".
        display "source", high, " and ", "object", high,
                                " code are portable to any".
        display "machine that runs ", "ACUCOBOL", high, ".  Furthermore".
        display "machine dependant issues such as accessing printers".
        display "and directories are isolated to a site-managed ".
        display "configuration file.  This allows the developer to".
        display "design an application on a PC with the confidence".
        display "that it will run on a VAX without modification.".
        display "Press return to continue...", reverse, no, color red.
        perform get-return.

        display "ACUCOBOL", line 1, erase screen, high,
                " is also designed to make moving".
        display space.
        display "applications written under other compilers easy.".
        display "ACUCOBOL", high, " contains two compatibility modes".
        display "matching two popular COBOL compilers: the RM/COBOL".
        display "and VAX/VMS compilers.  These modes let applications".
        display "developed using these compilers to be easily moved".
        display "to the ", "ACUCOBOL", high, " environment allowing the".
        display "developer to move applications to machines these".
        display "compilers do not support.".

        perform return-to-menu.

specifications section.
do-specifications.
        display window line 5, column 10, lines 15, size 60, boxed,
                                pop-up area is selection-window.
        display "ACUCOBOL-GT Specifications", line 1, centered,
                                reversed, size 60, color cyan.
        display "Compile Speed:", line 3, column 5,
                "6000+ lines-per-minute", column 26, high.
        display "Max Program Size:", line 5, column 5,
                "1 MB Code/1 MB Data", column 26, high.
        display "Max Run Unit Size:", line 7, column 5,
                "Limited only by machine memory", column 26, high.
        display "Special Features:", line 9, column 5,
                "Built-in windowing", column 26, high,
                "Source debugger", line 10, column 26, high,
                "Portable object code", line 11, column 26, high,
                "RM/COBOL compatibility", line 12, column 26, high,
                "VAX/COBOL compatibility", line 13, column 26, high,
           "ICOBOL compatibility", line 14, column 26, high.

        perform return-to-menu.

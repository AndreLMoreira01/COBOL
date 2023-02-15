identification division.
program-id.  dgetday.

* Copyright (c) 1996-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

remarks.
        This program takes a date (in the form MMDDYY) from the user
        and, after converting it to the form YYYYMMDD, displays
        the day of the week for that day.  This program requires the
        programs 'dayweek' and 'intdate' to run.  It is designed
        to demonstrate how to call those programs.

        See the caveats in intdate.cbl.

data division.
working-storage section.
01  day-1                       pic 9(8).
01  day-breakdown redefines day-1.
        03 day-yyyy             pic 9(4).
        03 day-mm               pic 9(2).
        03 day-dd               pic 9(2).
01  day-name                    pic x(5).

01  leap-year                   pic 9.
01  mod-rem                     pic 999.
01  tmp-div                     pic 9.

screen section.
01  date-screen.
        03  "Date (mmddyyyy): ", line 2 column 1.
        03  to day-mm, auto.
        03  "/".
        03  to day-dd, auto.
        03  "/".
        03  to day-yyyy, auto.
        03  "(enter '0' to quit)", column 30.

procedure division.
main-logic.
        perform convert-date, with test after, until day-mm = zero
        stop run.

convert-date.
        display window erase.
        display date-screen.
        accept date-screen.
        if day-mm = zero
            exit paragraph.

        if day-mm < 1 or day-mm > 12 or day-dd < 1 or day-dd > 31 or
                day-yyyy < 1601
            go to bad-date.
        if (day-mm = 9 or day-mm = 4 or day-mm = 6 or day-mm = 11) and
                day-dd > 30
            go to bad-date.
        perform leap-year-check.
        if day-mm = 2 and ((leap-year = 0 and day-dd > 28) or
                (leap-year = 1 and day-dd > 29))
            go to bad-date.

        call "dayweek" using day-1, day-name.
        display "Day of week is : ", line 4 column 1 no.
        display day-name.
        display "Press enter to continue: ", line 6.
        accept omitted.

leap-year-check.
        move 0 to leap-year
        divide day-yyyy by 4 giving tmp-div remainder mod-rem
        if mod-rem = 0
            move 1 to leap-year
            divide day-yyyy by 100 giving tmp-div remainder mod-rem
            if mod-rem = 0
                move 0 to leap-year
                divide day-yyyy by 400 giving tmp-div remainder mod-rem
                if mod-rem = 0
                    move 1 to leap-year
                end-if
            end-if
        end-if.

bad-date.
        display "invalid date entered.  Press <RETURN>",
                line 23, column 1, bold, beep
        accept omitted
        go to main-logic

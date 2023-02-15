identification division.
program-id.  intdate.

* Copyright (c) 1996-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

remarks.
        This routine simulates the new ANSI INTEGER-OF-DATE intrinsic
        function.  It converts a date in the form YYYYMMDD to an
        integer value that is the number of days since Dec 31, 1600.
        This can be used to compute the number of days between two dates.

        This program is designed to be called by another program.
        For an example, see "dayweek.cbl".

        Caveats:

        - This program doesn't agree with the output of the UNIX program
          "cal" prior to September 14, 1752.  "cal" says that 1700 was a
          leap year.  "cal" also accounts for the missing days in September
          1752.  This program merely projects the current calendar structure
          back to 1601 without regard for these historical quirks.

        - This program assumes that the data passed in represents a proper
          date.  It doesn't do any error checking on this data.

data division.
working-storage section.

01  month-table.
        03				pic 999 value 0.
        03				pic 999 value 31.
        03				pic 999 value 59.
        03				pic 999 value 90.
        03				pic 999 value 120.
        03				pic 999 value 151.
        03				pic 999 value 181.
        03				pic 999 value 212.
        03				pic 999 value 243.
        03				pic 999 value 273.
        03				pic 999 value 304.
        03				pic 999 value 334.

01  days-to-month-table redefines month-table.
        03  days-to-month
            occurs 12 times             pic 999.

01  this-year                           pic 9(4).
01  leap-days                           pic 9(4).
01  leap-4                              pic 9(4).
01  leap-100                            pic 9(4).
01  leap-400                            pic 9(4).

01  leap-year                           pic 9.
01  mod-rem                             pic 999.
01  tmp-div                             pic 9.

linkage section.
01  date-in.
        03  date-year                   pic 9(4).
        03  date-month                  pic 99.
        03  date-day                    pic 99.

01  int-out                             pic 9(8).

procedure division using date-in, int-out.
main-logic.
        move zero to int-out.

* compute # of days to passed year.
        subtract 1601 from date-year giving this-year.
        compute leap-4 = this-year / 4.
        compute leap-100 = this-year / 100.
        compute leap-400 = this-year / 400.
        compute leap-days = leap-4 - leap-100 + leap-400.
        compute int-out = this-year * 365 + leap-days.

* add in # of days in preceeding months
        add days-to-month( date-month ) to int-out.

* is this a leap year?
        perform leap-year-check.
        if leap-year = 1 and date-month > 2
            add 1 to int-out.

* add in day within month
        add date-day to int-out.
        exit program.

leap-year-check.
        move 0 to leap-year
        divide date-year by 4 giving tmp-div remainder mod-rem
        if mod-rem = 0
            move 1 to leap-year
            divide date-year by 100 giving tmp-div remainder mod-rem
            if mod-rem = 0
                move 0 to leap-year
                divide date-year by 400 giving tmp-div remainder mod-rem
                if mod-rem = 0
                    move 1 to leap-year
                end-if
            end-if
        end-if.

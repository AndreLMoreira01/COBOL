identification division.
program-id.  dateint.

* Copyright (c) 1996-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

remarks.
        This routine converts an integer value (the number
	of days since Dec 31, 1600) into a date in the form YYYYMMDD.

        The function is the inverse of intdate.cbl.  This program is
	designed to be called by another program.

        Caveats:

        - This program doesn't agree with the output of the UNIX program
          "cal" prior to September 14, 1752.  "cal" says that 1700 was a
          leap year.  "cal" also accounts for the missing days in September
          1752.  This program merely projects the current calendar structure
          back to 1601 without regard for these historical quirks.

        - The valid range for the number of days is [1, 3067671], which is
	  when the Y10K problem arises.

data division.
working-storage section.

01  month-table.
        03     				pic 99 value 31.
        03     				pic 99 value 28.
        03     				pic 99 value 31.
        03     				pic 99 value 30.
        03     				pic 99 value 31.
        03     				pic 99 value 30.
        03     				pic 99 value 31.
        03     				pic 99 value 31.
        03     				pic 99 value 30.
        03     				pic 99 value 31.
        03     				pic 99 value 30.
        03     				pic 99 value 31.

01  month-length-table redefines month-table.
        03  month-length
            occurs 12 times             pic 99.

78  days-400-years			value 146097.
78  days-100-years			value 36524.
78  days-4-years			value 1461.
78  days-1-year				value 365.

01  count-400				pic 9(8).
01  count-100				pic 9(8).
01  count-4				pic 9(8).
01  count-1				pic 9(8).

01  int-100				pic 9(8).
01  int-4				pic 9(8).
01  int-1				pic 9(8).

01  days-left				pic 9(8).

01  month				pic 99.

01  leap-year				pic 9.
01  tmp-div				pic 9.
01  mod-rem				pic 999.

linkage section.
01  int-in                              pic 9(8).

01  date-out.
        03  date-year                   pic 9(4).
        03  date-month                  pic 99.
        03  date-day                    pic 99.

procedure division using int-in, date-out.
main-logic.
* do something sensible if we get bad input
	if int-in = 0 or int-in > 3067671
	    move zeroes to date-out
	    exit program
	end-if.

* subtract out as many large chunks of days as possible
	divide int-in by days-400-years giving count-400 remainder days-left.
	divide days-left by days-100-years giving count-100 remainder days-left.
	if count-100 = 4
		move 3 to count-100
		add days-100-years to days-left
	end-if.
	divide days-left by days-4-years giving count-4 remainder days-left.
	divide days-left by days-1-year giving count-1 remainder days-left.
	if count-1 = 4
		move 3 to count-1
		add days-1-year to days-left
	end-if.

* add up all the years found above
        move 1601 to date-year.
	compute date-year = date-year + (400 * count-400) + (100 * count-100) +
			(4 * count-4) + count-1.

* roll back to end of the previous year if the remaining days = 0
	if days-left = 0
	    if date-year = 0
		move 9999 to date-year
	    else
		subtract 1 from date-year
	    end-if
	    perform leap-year-check
	    move days-1-year to days-left
	    if leap-year = 1
		add 1 to days-left
	    end-if
	else
	    perform leap-year-check
	end-if.

* February
	move 28 to month-length( 2 )
        if leap-year = 1
            add 1 to month-length( 2 )
	end-if.

* go through our table of month lengths and figure out what month we're in
	move 1 to date-month.
	perform with test after varying month from 1 by 1 until month = 12
	    if days-left > month-length( month )
		subtract month-length( month ) from days-left
		add 1 to date-month
	    else
		move 12 to month
	    end-if
	end-perform.

* return any remaining days
	move days-left to date-day.

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

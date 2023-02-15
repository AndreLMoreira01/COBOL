identification division.
program-id.  dayweek.

* Copyright (c) 1996-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

remarks.
        This program takes a date (in the form YYYYMMDD) and returns
        the day of the week.

        It assumes that the program "intdate.cbl" has been compiled with
        the object module name of "intdate".

        This program is designed to be called by another program.
        For an example, see "dgetday.cbl".

        See the caveats in intdate.cbl.

data division.
working-storage section.
01  day-1                       pic 9(8).
01  day-2                       pic 9(8).
01  day-index                   pic 9.

01  day-table.
        03  pic x(5)  value "Sun  ".
        03  pic x(5)  value "Mon  ".
        03  pic x(5)  value "Tues ".
        03  pic x(5)  value "Wed  ".
        03  pic x(5)  value "Thurs".
        03  pic x(5)  value "Fri  ".
        03  pic x(5)  value "Sat  ".

01  days-to-name-table redefines day-table.
        03  days-to-name
            occurs 7 times              pic x(5).

LINKAGE SECTION.

01  date-1                      pic x(8).
01  day-name                    pic x(5).

procedure division using date-1, day-name.
main-logic.
        call "intdate" using date-1, day-1.
        divide day-1 by 7 giving day-2 remainder day-index
        move days-to-name(day-index + 1) to day-name.
        exit program.

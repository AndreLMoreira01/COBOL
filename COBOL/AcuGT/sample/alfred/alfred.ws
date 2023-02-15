*  Linkage section definitions that are passed to "ALFRED-GET-PRINTER"

*  You can write a subroutine to get the name of a printer to open,
*  when you want to print records.  The name of the subroutine should
*  be assigned to the configuration variable "ALFRED-GET-PRINTER", and
*  should expect to be passed the following group item.

*  If the subroutine does not exist, or returns a blank printer-name,
*  then Alfred will attempt to open the printer assigned to the
*  configuration variable "ALFRED-PRINTER-NAME".  If this variable does
*  not exist or is blank, then Alfred will open the standard printer
*  "PRINTER" (or "-P SPOOLER" on Windows).  If this fails, then Alfred
*  will not print the record.

*  If the subroutine doesn't fill in the lines-per-page variable, then
*  Alfred will assume 66 lines per page.

01  alfred-get-printer-group.
    03  printer-name		pic x(80).
    03  lines-per-page		pic 999.


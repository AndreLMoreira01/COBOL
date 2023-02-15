identification division.
program-id.	books.
* Copyright (c) 2003-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

* This program displays the records in the bookfile.xml file.

* Create bookfile.sl and bookfile.fd by executing
*  xml2fd -p xml- bookfile.xml

* Note that this assumes that the bookfile.xsd file is available.
* If it is not, then the bookfile.fd generated will not allow this
* program to compile (it will have too few occurrances of some
* table elements).

* Compile this program with the flags "-Fax -Fc" (optionally use "-Gd"
* to use the debugger).

* Run it with the cblconfig configuration file.  2 records should be displayed.

environment division.
input-output section.
file-control.
    copy "bookfile.sl".

data division.
file section.
    copy "bookfile.fd".

working-storage section.
01  xml-bookfile-status                 pic xx.

screen section.
01  books-screen.
    03  lender.
        05  "Lender" line 4 col 1.
        05  from xml-name of xml-lender line 5 col 3.
        05  from xml-street of xml-lender line 6 col 3.
        05  from xml-city of xml-lender line 7 col 3.
        05  from xml-state of xml-lender line 8 col 3.
    03  borrower.
        05  "Borrower" line 4 col 41.
        05  from xml-name of xml-borrower line 5 col 43.
        05  from xml-street of xml-borrower line 6 col 43.
        05  from xml-city of xml-borrower line 7 col 43.
        05  from xml-state of xml-borrower line 8 col 43.
    03  book-info.
        05  "Title" line 10 col 1.
        05  "Pub Date" line 10 col 41.
        05  "Value" line 10 col 53.
        05  "Days" line 10 col 63.
    03  one-book occurs 10 times.
        05  from xml-booktitle line + 1 col 1.
        05  from xml-pubdate col 41.
        05  from xml-replacementvalue col 53.
        05  from xml-maxdaysout col 63.

procedure division.
main-logic.
    open input xml-bookfile.
    perform until xml-bookfile-status = "10"
	read xml-bookfile next
	  at end
            display "No more data" line 24
	  not at end
	    display books-screen
	end-read
        initialize xml-transaction
	accept omitted
    end-perform.
    close xml-bookfile.

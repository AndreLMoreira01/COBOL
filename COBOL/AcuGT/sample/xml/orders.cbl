identification division.
program-id.	orders.
* Copyright (c) 2003-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

* This program displays the records in the orderfile.xml file.

* Create orderfile.sl and orderfile.fd by executing
*  xml2fd -p test- orderfile.xml

* Compile this program with the flags "-Fax -Fc" (optionally use "-Gd"
* to use the debugger).

* Run it with the cblconfig configuration file.  2 records should be displayed.

environment division.
input-output section.
file-control.
    copy "orderfile.sl".

data division.
file section.
    copy "orderfile.fd".

working-storage section.
01  test-orderfile-status	pic xx.

screen section.
01  customer-screen.
    03  "Name" line 5 col 1.
    03  from test-first-name line 6 col 1.
    03  from test-last-name line 6 col 6.
    03  "Date" line 5 col 13.
    03  from test-date line 6 col 13.
    03  "Product" line 5 col 30.
    03  from test-product(1) line 6 col 30.
    03  from test-product(2) line 7 col 30.
    03  from test-product(3) line 8 col 30.
    03  "No." line 5 col 45.
    03  from test-number(1) line 6 col 45.
    03  from test-number(2) line 7 col 45.
    03  from test-number(3) line 8 col 45.
    03  "Price" line 5 col 50.
    03  from test-price(1) line 6 col 50.
    03  from test-price(2) line 7 col 50.
    03  from test-price(3) line 8 col 50.
    03  "Account" line 5 col 60.
    03  from test-chargeacct(1) line 6 col 60.
    03  from test-chargeacct(2) line 7 col 60.
    03  from test-chargeacct(3) line 8 col 60.

procedure division.
main-logic.
    open input test-orderfile.
    set environment "axml-exact-table-match" to 0.
    perform until test-orderfile-status = "10"
	read test-orderfile next
	  at end
	    display "No more data" line 24
	  not at end
	    display customer-screen
	end-read
        initialize test-customer
	accept omitted
    end-perform.
    close test-orderfile.

identification division.
program-id.	customer.
* Copyright (c) 2003-2006 by Acucorp, Inc.
* Users of ACUCOBOL may freely use this file.

* This program displays the records in the customer.xml file.

* Create customer.sl and customer.fd by executing
*  xml2fd -p xml- customer.xml

* Compile this program with the flags "-Fax -Fc" (optionally use "-Gd"
* to use the debugger).

* Run it with the cblconfig configuration file.  5 records should be displayed.

environment division.
input-output section.
file-control.
    copy "customer.sl".

data division.
file section.
    copy "customer.fd".

working-storage section.
01  xml-customers-status	pic xx.

screen section.
01  customer-screen.
    03  "Name" line 5 col 1.
    03  from xml-name line 5 col 30.
    03  "Customer ID" line 6 col 1.
    03  from xml-customer-id line 6 col 30.
    03  "Date" line 7 col 1.
    03  from xml-purchase-date line 7 col 30.
    03  "Department" line 8 col 1.
    03  from xml-department line 8 col 30.
    03  "Product name" line 9 col 1.
    03  from xml-product-name line 9 col 30.
    03  "Delivery date 1" line 10 col 1.
    03  from xml-date(1) line 10 col 30.
    03  "Total cost 1" line 11 col 1.
    03  from xml-total-cost(1) line 11 col 30.
    03  "Delivery date 2" line 12 col 1.
    03  from xml-date(2) line 12 col 30.
    03  "Total cost 2" line 13 col 1.
    03  from xml-total-cost(2) line 13 col 30.

procedure division.
main-logic.
    open input xml-customers.
    perform until xml-customers-status = "10"
	read xml-customers next
	  at end
	    display "No more data" line 24
	  not at end
	    display customer-screen
	end-read
        initialize xml-customer
	accept omitted
    end-perform.
    close xml-customers.

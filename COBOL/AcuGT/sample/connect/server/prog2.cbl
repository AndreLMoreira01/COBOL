IDENTIFICATION DIVISION.
PROGRAM-ID. prog2.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT customer-file
	ASSIGN TO "custfile"
	ORGANIZATION IS LINE SEQUENTIAL
	FILE STATUS IS customer-status.
DATA DIVISION.
FILE SECTION.
FD customer-file.
01 customer-record.
   05 customer-id               pic 9(3).
   05 customer-name             pic x(20).
   05 customer-age              pic xx.
WORKING-STORAGE SECTION.
01  customer-status pic xx.
	88  eof-customer-file   value "10".
LINKAGE SECTION.
01  customer-info.
	05  requested-age.
		10  low-age             pic x(2).
		10  high-age            pic x(2).
	05  age-group-count         pic 9(3).
PROCEDURE DIVISION using customer-info.
main-logic.
	perform count-customers.
	goback.

count-customers.
	move zero to age-group-count.
	open input customer-file.
	perform until eof-customer-file
		read customer-file next record
		at end
			continue
		not at end
			if customer-age >= low-age and
				customer-age <= high-age
				add 1 to age-group-count
			end-if
		end-read
	end-perform.
	close customer-file.

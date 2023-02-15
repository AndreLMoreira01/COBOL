identification division.
program-id.  JavaCallingCobol.
data division.
working-storage section.
       COPY "../def/java.def".
01 STATUS-VAL PIC S9(02) VALUE ZERO.

linkage section.
77  string-in-out	pic x(32) value spaces.
77  int-in-out		USAGE IS SIGNED-INT.			
77  byte-in-out		pic x.			
77  char-in-out		pic x.			
77  boolean-in-out	pic 9.
77  short-in-out	USAGE IS SIGNED-SHORT.			
77  longUsageSL		USAGE IS SIGNED-LONG.			
77  float-in-out	USAGE IS FLOAT.			
77  double-in-out	USAGE IS DOUBLE.			
77  longPicT2		PIC S9(18) COMP-5.			
77  longPicS918Comp5	PIC S9(18) COMP-5.			
77  intArray		USAGE IS SIGNED-INT occurs 5.			
77  byteArray		pic x occurs 5.			
77  charArray		pic x occurs 5.			
77  booleanArray	pic 9 comp occurs 5.			
77  shortArray		USAGE IS SIGNED-SHORT occurs 5.			
77  longArray		PIC S9(18) COMP-5 occurs 5.			
77  floatArray		USAGE IS FLOAT occurs 5.			
77  doubleArray		USAGE IS DOUBLE occurs 5.			

procedure division using string-in-out, int-in-out, byte-in-out,
	char-in-out, boolean-in-out, short-in-out, longUsageSL,
	float-in-out, double-in-out, longPicT2, longPicS918Comp5,
	intArray, byteArray, charArray, booleanArray, shortArray,
	longArray, floatArray, doubleArray.
main-logic.

       CALL "C$JAVA" USING CJAVA-LOGMESSAGE, "COBOL LOG --> Entered JavaCallingCobol" GIVING STATUS-VAL.
       move "********************************************" to string-in-out.
       move 9999 to  int-in-out.
       move 'z' to byte-in-out.
       move 'y' to char-in-out.
       move 1 to boolean-in-out.
       move 5555 to short-in-out.
       move 4444444 to longUsageSL.
       move 8.88888 to float-in-out.
       move 7.77777 to double-in-out.
       move 111111111111111111 to longPicT2.
       move 222222222222222222 to longPicS918Comp5.
       move 1 to intArray(1).
       move 2 to intArray(2).
       move 3 to intArray(3).
       move 4 to intArray(4).
       move 5 to intArray(5).
       move 'A' to byteArray(1).
       move 'B' to byteArray(2).
       move 'C' to byteArray(3).
       move 'D' to byteArray(4).
       move 'E' to byteArray(5).
       move 'A' to charArray(1).
       move 'B' to charArray(2).
       move 'C' to charArray(3).
       move 'D' to charArray(4).
       move 'E' to charArray(5).
       move 0 to booleanArray(1).
       move 0 to booleanArray(2).
       move 0 to booleanArray(3).
       move 0 to booleanArray(4).
       move 0 to booleanArray(5).
       move 1 to shortArray(1).
       move 2 to shortArray(2).
       move 3 to shortArray(3).
       move 4 to shortArray(4).
       move 5 to shortArray(5).
       move 1 to longArray(1).
       move 2 to longArray(2).
       move 3 to longArray(3).
       move 4 to longArray(4).
       move 5 to longArray(5).
       move 1111.1111 to floatArray(1).
       move 2222.2222 to floatArray(2).
       move 3333.3333 to floatArray(3).
       move 4444.4444 to floatArray(4).
       move 555.555 to floatArray(5).
       move 11111.11111 to doubleArray(1).
       move 22222.22222 to doubleArray(2).
       move 33333.33333 to doubleArray(3).
       move 44444.44444 to doubleArray(4).
       move 55555.55555 to doubleArray(5).
       CALL "C$JAVA" USING CJAVA-LOGMESSAGE, "COBOL LOG --> Exiting JavaCallingCobol" GIVING STATUS-VAL.
       exit program.


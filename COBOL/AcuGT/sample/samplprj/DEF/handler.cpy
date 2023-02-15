      *
      * handler.cpy: COBOL linkage definitions for use with
      *              C$REDIRECT I/O handlers
      *

      * $Id: handler.cpy 33034 2002-12-12 15:25:47Z mark $

      * Notes:
      * - Depends on sample/def/filesys.def for MAX-KEYS and
      *   MAX-RECORD-SIZE.
      * - Everything is prefixed with HANDLER- to create our own
      *   namespace.

       01  HANDLER-INFO.
           03  HANDLER-TYPE                         PIC 9.
               88  HANDLER-TYPE-PRE                 VALUE ZERO.
               88  HANDLER-TYPE-REPLACE             VALUE 1.
               88  HANDLER-TYPE-POST                VALUE 2.
           03  HANDLER-OPERATION                    PIC 99.
               88  HANDLER-OP-OPEN                  VALUE ZERO.
               88  HANDLER-OP-CLOSE                 VALUE 1.
               88  HANDLER-OP-READ                  VALUE 2.
               88  HANDLER-OP-READ-LOCK             VALUE 3.
               88  HANDLER-OP-NEXT                  VALUE 4.
               88  HANDLER-OP-NEXT-LOCK             VALUE 5.
               88  HANDLER-OP-PREVIOUS              VALUE 6.
               88  HANDLER-OP-PREVIOUS-LOCK         VALUE 7.
               88  HANDLER-OP-START                 VALUE 8.
               88  HANDLER-OP-WRITE                 VALUE 9.
               88  HANDLER-OP-REWRITE               VALUE 10.
               88  HANDLER-OP-DELETE                VALUE 11.
               88  HANDLER-OP-UNLOCK                VALUE 12.
               88  HANDLER-OP-UNLOCK-ALL            VALUE 13.
               88  HANDLER-OP-REMOVE                VALUE 14.
               88  HANDLER-OP-START-TRANSACTION     VALUE 15.
               88  HANDLER-OP-COMMIT-TRANSACTION    VALUE 16.
               88  HANDLER-OP-ROLLBACK-TRANSACTION  VALUE 17.
           03  HANDLER-CALLING-PROGRAM              PIC X(64).

      *
      * The structure below represents the latest version (2) of the
      * data item returned by the C$REDIRECT file handler.
      *
      * You may select which version of this data item you want
      * returned by your file handler by setting HANDLER-VERSION
      * (in def/filesys.def) before passing it to C$REDIRECT.
      *
      * Changes from previous versions are:
      *
      * Version 1:
      * !      05  HANDLER-PRE-ALLOCATE-AMOUNT      PIC 9(5).
      * !      05  HANDLER-EXTENSION-AMOUNT         PIC 9(5).
      *
      * !      05  HANDLER-MAX-LREC-SIZE            PIC 9(5).
      * !      05  HANDLER-MIN-LREC-SIZE            PIC 9(5).
      *
      * !          07  HANDLER-SEGMENT-OFFSET       PIC 9(5).
      *
      * +  03  HANDLER-ADVANCE-AMT                  SIGNED-INT.
      *
      * !  03  HANDLER-RECORD-SIZE                  SIGNED-SHORT.
      *
      *
       01  HANDLER-FILE-INFO.
           03  HANDLER-FILE-HANDLE                  USAGE POINTER.
           03  HANDLER-FILE-NAME                    PIC X(256).
           03  HANDLER-FILE-ORGANIZATION            PIC 99.
               88 HANDLER-ORGANIZATION-INDEXED      VALUE 1.
               88 HANDLER-ORGANIZATION-SEQUENTIAL   VALUE 2.
               88 HANDLER-ORGANIZATION-RELATIVE     VALUE 3.
           03  HANDLER-PHYSICAL-PARAMS.
               05  HANDLER-BLOCK-MULTIPLE           PIC 99.
               05  HANDLER-P-COMMA-1                PIC X.
               05  HANDLER-PRE-ALLOCATE-AMOUNT      PIC 9(7).
               05  HANDLER-P-COMMA-2                PIC X.
               05  HANDLER-EXTENSION-AMOUNT         PIC 9(7).
               05  HANDLER-P-COMMA-3                PIC X.
               05  HANDLER-COMPRESSION-FACTOR       PIC 999.
               05  HANDLER-P-COMMA-4                PIC X.
               05  HANDLER-ENCRYPTION-FLAG          PIC 9.
                   88  HANDLER-IS-NOT-ENCRYPTED     VALUE ZERO.
                   88  HANDLER-IS-ENCRYPTED         VALUE 1.
               05  HANDLER-P-NULL-1                 PIC X.
           03  HANDLER-LOGICAL-PARAMS.
               05  HANDLER-MAX-LREC-SIZE            PIC 9(10).
               05  HANDLER-L-COMMA-1                PIC X.
               05  HANDLER-MIN-LREC-SIZE            PIC 9(10).
               05  HANDLER-L-COMMA-2                PIC X.
               05  HANDLER-NUMBER-KEYS              PIC 999.
               05  HANDLER-L-NULL-1                 PIC X.
           03  HANDLER-TRANSLATION-TABLE            PIC X(256).
           03  HANDLER-FILE-COMMENT                 PIC X(30).
           03  HANDLER-KEY-INFO OCCURS 1 TO MAX-KEYS TIMES
                   DEPENDING ON HANDLER-NUMBER-KEYS.
               05  HANDLER-KEYDESC.
                   07  HANDLER-NUMBER-SEGMENTS      PIC 9(2).
                   07  HANDLER-K-COMMA-1            PIC X.
                   07  HANDLER-DUPS-ALLOWED-FLAG    PIC 9.
                       88  HANDLER-DUPS-NOT-ALLOWED VALUE ZERO.
                       88  HANDLER-DUPS-ALLOWED     VALUE 1.
               05  HANDLER-SEGDESC OCCURS MAX-SEGS TIMES.
                   07  HANDLER-S-COMMA-1            PIC X.
                   07  HANDLER-SEGMENT-SIZE         PIC 999.
                   07  HANDLER-S-COMMA-2            PIC X.
                   07  HANDLER-SEGMENT-OFFSET       PIC 9(10).

       01  HANDLER-STATE-INFO.
           03  HANDLER-OPEN-MODE                    UNSIGNED-INT.
           03  HANDLER-ADVANCE-AMT                  SIGNED-INT.
           03  HANDLER-KEY-NUMBER                   SIGNED-SHORT.
           03  HANDLER-START-MODE                   SIGNED-SHORT.
               88  HANDLER-START-EQUAL              VALUE ZERO.
               88  HANDLER-START-NOT-LESS           VALUE 1.
               88  HANDLER-START-GREATER            VALUE 2.
               88  HANDLER-START-LESS               VALUE 3.
               88  HANDLER-START-NOT-GREATER        VALUE 4.
           03  HANDLER-START-KEY-SIZE               SIGNED-SHORT.
           03  FILLER                               PIC X(2).
           03  HANDLER-RECORD-SIZE                  UNSIGNED-INT.
           03  HANDLER-RECORD-AREA.
               05  HANDLER-RECORD-BYTES OCCURS 1 TO MAX-RECORD-SIZE
                       TIMES DEPENDING ON HANDLER-MAX-LREC-SIZE PIC X.

       01  HANDLER-RETURN-STATUS.
           03  HANDLER-STATUS-CODE                  PIC XX.

      * End of sample/handler.cpy

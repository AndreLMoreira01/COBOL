      * CUSTOMER FILE SELECT
       SELECT OPTIONAL CUSTOMER-FILE
           ASSIGN       TO DISK "CUSTFILE.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           FILE STATUS  IS FILE-STATUS
           RECORD KEY   IS CUSTOMER-NAME.

       SELECT Salesdata
           ASSIGN       TO  "Sales.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           FILE STATUS  IS salesdata-status
           RECORD KEY   IS Sales-Key.

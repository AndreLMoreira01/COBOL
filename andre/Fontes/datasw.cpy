       01  CAMPOS-CRITICA-DATA-W.
           03 W-DATA-CRIT                 PIC 9(08).
           03 FILLER REDEFINES W-DATA-CRIT.
              05 W-DIA-CRIT               PIC 9(02).
              05 W-MES-CRIT               PIC 9(02).
              05 W-ANO-CRIT               PIC 9(04).

           03  W-RESTDIV-400              PIC 9(05) VALUE 0.
           03  W-RESTDIV-100              PIC 9(05) VALUE 0.
           03  W-RESTDIV-4                PIC 9(05) VALUE 0.

           03  FILLER                     PIC X(01) VALUE ' '.
               88 DATA-OK                 VALUE 'S' FALSE ' '.

      *    03 W-TAB-DIAS-MES-W.
      *       05 FILLER PIC X(11) VALUE '31JANEIRO'.
      *       05 FILLER PIC X(11) VALUE '28FEVEREIRO'.
      *       05 FILLER PIC X(11) VALUE '31MARCO'.
      *       05 FILLER PIC X(11) VALUE '30ABRIL'.
      *       05 FILLER PIC X(11) VALUE '31MAIO'.
      *       05 FILLER PIC X(11) VALUE '30JUNHO'.
      *       05 FILLER PIC X(11) VALUE '31JULHO'.
      *       05 FILLER PIC X(11) VALUE '31AGOSTO'.
      *       05 FILLER PIC X(11) VALUE '30SETEMBRO'.  
      *       05 FILLER PIC X(11) VALUE '31OUTUBRO'.
      *       05 FILLER PIC X(11) VALUE '30NOVEMBRO'.
      *       05 FILLER PIC X(11) VALUE '31DEZEMBRO'.
      *    03 W-TAB-DIAS-MES-T REDEFINES W-TAB-DIAS-MES-W OCCURS 12.
      *       05 W-DIAS-MES-T     PIC 9(02).
      *       05 W-MES-EXT-T      PIC X(09).

           03 W-TAB-DIAS-MES-W.
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '28'.
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '30'.
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '30'.
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '30'.  
              05 FILLER PIC X(02) VALUE '31'.
              05 FILLER PIC X(02) VALUE '30'.
              05 FILLER PIC X(02) VALUE '31'.
           03 W-TAB-DIAS-MES-T REDEFINES W-TAB-DIAS-MES-W OCCURS 12.
              05 W-DIAS-MES-T     PIC 9(02).

      *    03 W-TAB-DIAS-MES-W    PIC X(24) 
      *                           VALUE '312831303130313130313031'.
      *    03 W-TAB-DIAS-MES-T REDEFINES W-TAB-DIAS-MES-W OCCURS 12.
      *       05 W-DIAS-MES-T     PIC 9(02).


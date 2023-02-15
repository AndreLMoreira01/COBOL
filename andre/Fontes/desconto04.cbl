       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     DESCONTO04.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT TABDESC ASSIGN TO 'TABDESC.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TABDESC.
       
       
       DATA DIVISION.
       FILE SECTION.

       FD  TABDESC  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-1.
           03  TDES-RECORDK-1.
               05 TDES-CODITAB-1          PIC  9(03).
           03  TDES-NOMETAB-1             PIC  X(60).
           03  TDES-PERCDSC-1             PIC  9(03)V99.
           03  TDES-PERCCMS-1             PIC  9(03)V99.

       WORKING-STORAGE SECTION.
       01  CAMPOS-W.
           03  STAT-TABDESC                PIC  X(02).
               88 VALID-TABDESC            VALUE '00' THRU '09'.

       01  WORK-GERAL.
           03  W-OPCAO              PIC  9(01).
	   03  PRECO                PIC  9(006)V99.
	   03  PERCDSC              PIC  9(003)V99.
           03  PERCCMS              PIC  9(003)V99.
	   03  VALDESC              PIC  9(006)V99.
           03  VALCMS               PIC  9(006)V99.
	   03  VALCMS-F             PIC  ZZZ.ZZ9,99.
	   03  VALDESC-F            PIC  ZZZ.ZZ9,99.
	   03  PRECO-LIQ            PIC  9(006)V99.
	   03  PRECO-LIQ-F          PIC  ZZZ.ZZ9,99.
	   03  TABELA               PIC  9(001).
	   03  IND                  PIC  9(002).
	   03  TABDESC              OCCURS 10 TIMES.
               05 DESCONTO          PIC  9(003)V99.
               05 COMISSAO          PIC  9(003)V99.
       
       PROCEDURE DIVISION.
       INICIO.
           OPEN I-O TABDESC
           DISPLAY WINDOW AT 0101 LINES 50 SIZE 100
                                  BACKGROUND-COLOR 0
                                  FOREGROUND-COLOR 10
                                  ERASE


	   PERFORM TEST AFTER UNTIL W-OPCAO = 0

	      DISPLAY "0 = SAIR"       AT 0305
              DISPLAY "1 = CALCULAR"   AT 0405
              DISPLAY "OPCAO :         (0=finalizar)" AT 0705
              ACCEPT W-OPCAO AT 0713 WITH UPDATE
              EVALUATE W-OPCAO
                 WHEN 0
                      CONTINUE

                 WHEN 1
                      DISPLAY "INSIRA O PRECO:   " AT 1005

                      DISPLAY "INFORME A TABELA: " AT 1305
		      ACCEPT PRECO AT 1105 WITH UPDATE
                      ACCEPT TABELA AT 1405 WITH UPDATE
                      IF TABELA <1 OR> 10
                         DISPLAY "TABELA INVALIDA" AT 2005
                      ELSE
                         PERFORM CALCULA-TABELA

                         COMPUTE VALDESC ROUNDED = PRECO *
                                                   PERCDSC / 100
                         MOVE VALDESC TO VALDESC-F
                         DISPLAY "VALOR DO DESCONTO" AT 2005
                         DISPLAY VALDESC-F AT 2030

                         COMPUTE PRECO-LIQ ROUNDED = PRECO -
                                                     VALDESC
                         MOVE PRECO-LIQ TO PRECO-LIQ-F
                         DISPLAY "PRECO LIQUIDO" AT 2105
                         DISPLAY PRECO-LIQ-F AT 2130

                         COMPUTE VALCMS ROUNDED = PRECO-LIQ *
                                                  PERCCMS / 100
                         MOVE VALCMS TO VALCMS-F
                         DISPLAY "VALOR DA COMISSAO" AT 2205
                         DISPLAY VALCMS-F AT 2230

		      END-IF
                 WHEN OTHER
                      DISPLAY "OPCAO INVALIDA        " AT 1005
              END-EVALUATE
           END-PERFORM.

           CLOSE TABDESC.

           EXIT PROGRAM.
           STOP RUN.

        CALCULA-TABELA.
            INITIALIZE TDES-REGISTR-1.
            MOVE TABELA TO TDES-CODITAB-1.
            READ TABDESC
            IF VALID-TABDESC
               MOVE TDES-PERCDSC-1 TO PERCDSC
               MOVE TDES-PERCCMS-1 TO PERCCMS
            END-IF.
            
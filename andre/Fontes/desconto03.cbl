       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     DESCONTO.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
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
           DISPLAY WINDOW AT 0101 LINES 50 SIZE 100
                                  BACKGROUND-COLOR 0
                                  FOREGROUND-COLOR 10
                                  ERASE

           MOVE 5 TO PERCDSC.
           MOVE 20 TO PERCCMS.
           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 10
              MOVE PERCDSC TO DESCONTO(IND)
              MOVE PERCCMS TO COMISSAO(IND)

              SUBTRACT 2 FROM PERCCMS
              ADD 5 TO PERCDSC
           END-PERFORM.


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
                      DISPLAY "10% DE DESCONTO = 1" AT 1305
                      DISPLAY "20% DE DESCONTO = 2" AT 1405
                      DISPLAY "30% DE DESCONTO = 3" AT 1505
                      DISPLAY "40% DE DESCONTO = 4" AT 1605
                      DISPLAY "50% DE DESCONTO = 5" AT 1705
                      DISPLAY "INFORME O DESCONTE: " AT 1805
		      ACCEPT PRECO AT 1105 WITH UPDATE
                      ACCEPT TABELA AT 1905 WITH UPDATE
                      IF TABELA <1 OR> 5
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

           EXIT PROGRAM.
           STOP RUN.

        CALCULA-TABELA.
            PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 10
               IF IND = TABELA
		  MOVE DESCONTO(IND) TO PERCDSC
                  MOVE COMISSAO(IND) TO PERCCMS
               END-IF
            END-PERFORM

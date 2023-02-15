       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     DESCONTO.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WORK-GERAL.
           03  W-OPCAO            PIC  9(01).
	   03  PRECO              PIC 9(006)V99.
           03  PERCENTUAL         PIC 9(003)V99.
           03  VALORD             PIC 9(006)V99.
           03  VALORD-F           PIC ZZZ.ZZ9,99.
           03  PRECO-LIQ          PIC ZZZ.ZZ9,99.
	
       PROCEDURE DIVISION.
       INICIO.
	INITIALIZE WORK-GERAL.
           DISPLAY WINDOW AT 0101 LINES 20 SIZE 50
                                  BACKGROUND-COLOR 7
                                  FOREGROUND-COLOR 1
                                  ERASE

           PERFORM TEST AFTER UNTIL W-OPCAO = 0
              DISPLAY "0 = SAIR" AT LINE 03 COLUMN 05
              DISPLAY "1 = CALCULAR"   AT LINE 04 COLUMN 05
              DISPLAY "OPCAO :         (O=finalizar)" AT 0705
              ACCEPT W-OPCAO AT 0713 WITH UPDATE
              EVALUATE W-OPCAO
                 WHEN 0
                      CONTINUE
                 WHEN 1
                 DISPLAY "INFORME O PRECO: " AT 1005
                 DISPLAY "INFORME O PERCENTUAL: " AT 1105				
		 ACCEPT PRECO AT 1030 WITH UPDATE
		 ACCEPT PERCENTUAL AT 1130 WITH UPDATE
		 IF PERCENTUAL > 100
                    DISPLAY "PERCENTUAL INVALIDO" AT 1705
                 ELSE 
                     COMPUTE VALORD ROUNDED = PRECO * PERCENTUAL / 100
                     
                     MOVE VALORD TO VALORD-F
                     DISPLAY "VALORD DO DESCONTO" AT 1505
		     DISPLAY VALORD-F AT 1530

                     COMPUTE PRECO-LIQ ROUNDED = PRECO - VALORD
                     DISPLAY "PRECO LIQUIDO" AT 1605
                     DISPLAY PRECO-LIQ AT 1630

                      END-IF
		WHEN OTHER
                DISPLAY "OPCAO INVALIDA" AT 1005
              
		END-EVALUATE
           END-PERFORM.

           EXIT PROGRAM.
           STOP RUN.

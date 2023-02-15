       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     DESCONTAB.
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
           03  TABELA             PIC 9(001).
           03  IND                PIC 9(002).
           03  TABDESC            PIC 9(003)V99 OCCURS 5 TIMES.
          
              
	
       PROCEDURE DIVISION.
       INICIO.
	INITIALIZE WORK-GERAL.
           DISPLAY WINDOW AT 0101 LINES 20 SIZE 50
                                  BACKGROUND-COLOR 7
                                  FOREGROUND-COLOR 1
                                  ERASE

                MOVE 10 TO TABDESC(1).
                MOVE 20 TO TABDESC(2).
                MOVE 30 TO TABDESC(3).
                MOVE 40 TO TABDESC(4).
                MOVE 50 TO TABDESC(5).
                          
              PERFORM TEST AFTER UNTIL W-OPCAO = 0
              DISPLAY "1 = 10%" AT LINE 02 COLUMN 05
              DISPLAY "2 = 20%" AT LINE 03 COLUMN 05
              DISPLAY "3 = 30%" AT LINE 04 COLUMN 05
              DISPLAY "4 = 40%" AT LINE 05 COLUMN 05
              DISPLAY "5 = 50%" AT LINE 06 COLUMN 05
              DISPLAY "OPCAO :         (0=finalizar)" AT 0705
              ACCEPT W-OPCAO AT 0713 WITH UPDATE
              EVALUATE W-OPCAO
                 WHEN 0
                      CONTINUE
                 WHEN 1
                 DISPLAY "INFORME O PRECO: " AT 1005
                 DISPLAY "INFORME A TABELA: " AT 1105				
		 ACCEPT PRECO AT 1030 WITH UPDATE
		 ACCEPT TABELA AT 1130 WITH UPDATE
		 IF TABELA < 1 OR > 5  
                    DISPLAY "TABELA INVALIDO" AT 1705
                 ELSE 
                     PERFORM CACLULA-TABELA

                     COMPUTE VALORD ROUNDED = PRECO * PERCENTUAL / 100
                     
                     MOVE VALORD TO VALORD-F 
                     DISPLAY "PRECO LIQUIDO" AT 1605
                     DISPLAY PRECO-LIQ AT 1630

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

       CACLULA-TABELA.
              PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
               IF IND = TABELA
                 MOVE TABDESC(IND) TO PERCENTUAL
                  END-IF
                 END-PERFORM.
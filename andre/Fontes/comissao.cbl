       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG04.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WORK-GERAL.
           03  OPC-TAB            PIC  9(01).
           03  OPC-FIM            PIC  9(01).
           03  IND	          PIC  9(01).	
           03  VALOR-PROD	  PIC  9(006)V99.
           03  PERC-DESC          PIC  9(003)V99.
           03  PERC-COMI          PIC  9(003)V99.
           03  VAL-COMI 	  PIC  9(006)V99.
           03  VAL-DESC 	  PIC  9(006)V99.
           03  VALOR-DESC	  PIC  ZZZ.ZZ9,99.
           03  VALOR-COMI	  PIC  ZZZ.ZZ9,99.
           03  PRECO-LIQ	  PIC  ZZZ.ZZ9,99.
           03  TABELA		  OCCURS 5 TIMES.
               05 DESCONTO        PIC 9(006)V99.
               05 COMISSAO        PIC 9(006)V99.
       
       PROCEDURE DIVISION.
       INICIO.
           DISPLAY WINDOW AT 0101 LINES 30 SIZE 120
                                  BACKGROUND-COLOR 5
                                  FOREGROUND-COLOR 15
                                  ERASE

           MOVE 5 TO PERC-DESC.
           MOVE 2 TO PERC-COMI.
           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 10
              MOVE PERC-DESC TO DESCONTO(IND)
              MOVE PERC-COMI TO COMISSAO(IND)
              COMPUTE PERC-DESC = PERC-DESC + 5
              COMPUTE PERC-COMI = PERC-COMI - 2
           END-PERFORM
           PERFORM TEST AFTER UNTIL OPC-FIM = 0
              DISPLAY "1 = CALCULAR DESCONTO" AT LINE 03 COLUMN 05
              DISPLAY "OPCAO :" AT 0405
              ACCEPT OPC-FIM AT 0430 WITH UPDATE
              EVALUATE OPC-FIM
                 WHEN 0
                      CONTINUE
                 WHEN 1
                        DISPLAY "DIGITE O VALOR DO PRODUTO:" AT 0605
                        ACCEPT VALOR-PROD AT 0630 WITH UPDATE
                        DISPLAY "ESCOLHA A TABELA DE DESCONTO" 
                               AT LINE 08 COLUMN 05
                        ACCEPT OPC-TAB AT 0830 WITH UPDATE
                        IF OPC-TAB < 1 OR > 10
                           DISPLAY "OPCAO INVALIDA"
                        ELSE
                           PERFORM CALCULA
                           COMPUTE VAL-DESC ROUNDED = VALOR-PROD * 
                                   PERC-DESC / 100
                           MOVE VAL-DESC TO VALOR-DESC
                           DISPLAY "FOI RECIDO UM DESCONTO DE: " AT 1005
                           DISPLAY VALOR-DESC AT 1030
                           COMPUTE PRECO-LIQ ROUNDED = VALOR-PROD - VAL-DESC
                           DISPLAY "O VALOR LIQUIDO E DE:" AT 1105
                           DISPLAY PRECO-LIQ AT 1130
                           COMPUTE VAL-COMI ROUNDED = PRECO-LIQ * 
                             PERC-COMI / 100
                           MOVE VAL-COMI TO VALOR-COMI
                           DISPLAY "O VALOR DE COMISSÃO RECEBIDO É:" AT 1305
                           DISPLAY VALOR-COMI 1330
                        END-IF
                 WHEN OTHER
                      DISPLAY "OPCAO INVALIDA        " AT 1005
              END-EVALUATE
           END-PERFORM.
           EXIT PROGRAM.
           STOP RUN.
           CALCULA.
                 PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 10
                   IF IND = OPC-TAB
                       MOVE DESCONTO(IND) TO PERC-DESC
                       MOVE COMISSAO(IND) TO PERC-COMI
                   END-IF
                 END-PERFORM.

       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG04.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WORK-GERAL.
           03  W-OPCAO            PIC  9(01).
       
       PROCEDURE DIVISION.
       INICIO.
           DISPLAY WINDOW AT 0101 LINES 20 SIZE 50
                                  BACKGROUND-COLOR 7
                                  FOREGROUND-COLOR 1
                                  ERASE

           PERFORM TEST AFTER UNTIL W-OPCAO = 0
              DISPLAY "1 = MANUTENCAO" AT LINE 03 COLUMN 05
              DISPLAY "2 = CONSULTA"   AT LINE 04 COLUMN 05
              DISPLAY "3 = RELATORIO"  AT LINE 05 COLUMN 05
              DISPLAY "OPCAO :         (O=finalizar)" AT 0705
              ACCEPT W-OPCAO AT 0713 WITH UPDATE
              EVALUATE W-OPCAO
                 WHEN 0
                      CONTINUE
                 WHEN 1
                      DISPLAY "VOCE DIGITOU A OPCAO 1" AT 1005
                 WHEN 2
                      DISPLAY "VOCE DIGITOU A OPCAO 2" AT 1005
                 WHEN 3
                      DISPLAY "VOCE DIGITOU A OPCAO 3" AT 1005
                 WHEN OTHER
                      DISPLAY "OPCAO INVALIDA        " AT 1005
              END-EVALUATE
           END-PERFORM.

           EXIT PROGRAM.
           STOP RUN.

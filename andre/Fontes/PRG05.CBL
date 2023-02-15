       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG05.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WORK-GERAL.
           03  W-VALOR            PIC  ZZ.ZZZ.ZZZ.ZZ9,99-.
           03  W-CODIGO           PIC  ZZZ.ZZ9.
           03  W-AUX              PIC  X.
       
       PROCEDURE DIVISION.
       INICIO.
           DISPLAY WINDOW AT 0101 LINES 20 SIZE 50
                                  BACKGROUND-COLOR 7
                                  FOREGROUND-COLOR 1
                                  ERASE

           DISPLAY "INFORME O VALOR  : " AT 0305
           DISPLAY "INFORME O CODIGO : " AT 0405
           ACCEPT W-VALOR  AT LINE 03 COL 24 WITH UPDATE
           ACCEPT W-CODIGO AT LINE 04 COL 24 WITH UPDATE

           DISPLAY "TECLE ENTER PARA FINALIZAR" AT 2001
           ACCEPT W-AUX AT 2001.

           EXIT PROGRAM.
           STOP RUN.

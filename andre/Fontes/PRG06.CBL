       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG06.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WORK-GERAL.
           03  W-VALOR            PIC  S9(11)V99.
           03  W-CODIGO           PIC  9(06).
           03  W-AUX              PIC  X.

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LINE 03 COL 05
              VALUE "Informe o valor".
           03 LINE 04 COL 05
              VALUE "Informe o código".

           03 VALOR-D USING W-VALOR
                      PIC ZZ.ZZZ.ZZZ.ZZ9,99-
                      LINE 03 COL 24
                      AUTO.

           03 CODIGO-D USING W-CODIGO
                       PIC ZZZ.ZZ9
                       LINE 04 COL 24
                       AUTO.
           
       PROCEDURE DIVISION.
       INICIO.
           DISPLAY WINDOW AT 0101 LINES 20 SIZE 50
                                  BACKGROUND-COLOR 7
                                  FOREGROUND-COLOR 1
                                  ERASE

           DISPLAY TELA-PRINCIPAL.
           ACCEPT TELA-PRINCIPAL.

           DISPLAY "TECLE ENTER PARA FINALIZAR" AT 2001
           ACCEPT W-AUX AT 2001.

           EXIT PROGRAM.
           STOP RUN.

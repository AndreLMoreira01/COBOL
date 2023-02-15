       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG07.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  SMALL-FONT             HANDLE.

       01  WORK-GERAL.
           03  W-VALOR            PIC  S9(11)V99.
           03  W-CODIGO           PIC  9(06).
           03  W-AUX              PIC  X.

           03  HANDLE-DA-JANELA   HANDLE.
       
       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL LINE 03 COL 05
                    TITLE "Informe o valor"
                    TRANSPARENT.
           03 LABEL LINE 05 COL 05
                    TITLE "Informe o código"
                    TRANSPARENT.

           03 ENTRY-VALOR ENTRY-FIELD
              USING W-VALOR
              PIC ZZ.ZZZ.ZZZ.ZZ9,99-
              LINE 03 COL 24 BOXED
              AUTO
              FONT SMALL-FONT.

           03 ENTRY-CODIGO ENTRY-FIELD
              USING W-CODIGO
              PIC ZZZ.ZZ9
              LINE 05 COL 24 BOXED
              AUTO
              FONT SMALL-FONT.
           
       PROCEDURE DIVISION.
       INICIO.
           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".

           DISPLAY INITIAL GRAPHICAL WINDOW
                           SIZE 80 LINES 25
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Programa PRG07"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           AUTO-MINIMIZE
                           BACKGROUND-LOW
                           USER-COLORS
                           HANDLE HANDLE-DA-JANELA.

           DISPLAY TELA-PRINCIPAL.
           ACCEPT TELA-PRINCIPAL.

           CLOSE WINDOW HANDLE-DA-JANELA.

           EXIT PROGRAM.
           STOP RUN.

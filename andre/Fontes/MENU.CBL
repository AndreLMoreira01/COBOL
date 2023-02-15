       IDENTIFICATION DIVISION.
       PROGRAM-ID.    MENU.
       AUTHOR.        EDILSON.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       77  JANELA-INTERNA                 PIC X(10).
       77  LINHAS-DA-JANELA               PIC 9(5).
       77  COLUNAS-DA-JANELA              PIC 9(5).

       01  CAMPOS-CONTROLE-TELA-GRAFICA.
           03  EVENT-STATUS IS SPECIAL-NAMES EVENT STATUS.
               05 EVENT-TYPE              PIC X(4) COMP-X.
                  88 CA-CMD-CLOSE         VALUE 1.
                  88 CA-CMD-TABCHANGED    VALUE 7.
               05 EVENT-WINDOW-HANDLE     HANDLE OF WINDOW.
               05 EVENT-CONTROL-HANDLE    HANDLE.
               05 EVENT-CONTROL-ID        PIC XX COMP-X.
               05 EVENT-DATA-1            SIGNED-SHORT.
               05 EVENT-DATA-2            SIGNED-LONG.
               05 EVENT-ACTION            PIC X COMP-X.

           03  TECLA-ESCAPE IS SPECIAL-NAMES CRT STATUS
                                          PIC 9(4) VALUE 0.
               88 TECLOU-ESC              VALUE 27.

           03  CA-SCREEN-CONTROL IS SPECIAL-NAMES SCREEN CONTROL.
               05 W-ACCEPT-CONTROL        PIC 9.
               05 W-CONTROL-VALUE         PIC 999.
               05 W-CONTROL-HANDLE        USAGE HANDLE.
               05 W-CONTROL-ID            PIC X(2) COMP-X.

       01  JANELA-PRINCIPAL               PIC X(10) EXTERNAL.

           COPY "MAINRTN.MSG".
           COPY "ACUCOBOL.DEF".
           COPY "ACUGUI.DEF".

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 PUSH-BUTTON TITLE 'Chamar o programa PRG08'
                          LINE 04
                          COL 05
                          SIZE 30
                          ID 1
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG08.

           03 PUSH-BUTTON TITLE 'Chamar o programa PRG08B'
                          LINE 06
                          COL 05
                          SIZE 30
                          ID 2
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG08B.

           03 PUSH-BUTTON TITLE 'Chamar o programa PRG09'
                          LINE 08
                          COL 05
                          SIZE 30
                          ID 3
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG09.

           03 PUSH-BUTTON TITLE 'Chamar o programa PRG09B'
                          LINE 10
                          COL 05
                          SIZE 30
                          ID 4
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG09B.

           03 PUSH-BUTTON TITLE 'Chamar o programa PRG09C'
                          LINE 12
                          COL 05
                          SIZE 30
                          ID 5
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG09C.

           03 PUSH-BUTTON TITLE 'Chamar o programa PRG10'
                          LINE 14
                          COL 05
                          SIZE 30
                          ID 6
                          EVENT PROCEDURE EVENTO-BTN-CHAMAR-PRG10.

       PROCEDURE DIVISION.
       INICIO.
           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".

           |* Recurso utilizado para desenhar uma janela que ocupe
           |* toda a área útil da tela:

           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO.
           MOVE SMALL-FONT TO TEXTSIZE-FONT
           CALL "W$TEXTSIZE" USING "0", TEXTSIZE-DATA.
           COMPUTE COLUNAS-DA-JANELA =
               USABLE-SCREEN-WIDTH / TEXTSIZE-BASE-X - 1
           COMPUTE LINHAS-DA-JANELA =
               USABLE-SCREEN-HEIGHT / TEXTSIZE-BASE-Y - 6.

           DISPLAY INITIAL WINDOW
               TITLE "MENU"
               LINES LINHAS-DA-JANELA
               SIZE COLUNAS-DA-JANELA,
               COLOR 257
               SYSTEM MENU
               AUTO-MINIMIZE
               BACKGROUND-LOW
               POP-UP AREA JANELA-PRINCIPAL.

           |* Mostra uma janela do tipo FLOATING dentro da janela principal,
           |* para que ela fique centralizada :

           DISPLAY FLOATING GRAPHICAL WINDOW
                            TITLE "Opções do Menu"
                            LINES 18
                            SIZE 39
                            SYSTEM MENU
                            POP-UP AREA JANELA-INTERNA.

           DISPLAY TELA-PRINCIPAL.

           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE WINDOW JANELA-INTERNA.
           CLOSE WINDOW JANELA-PRINCIPAL.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE.

      *    EVALUATE TECLA-ESCAPE
      *      WHEN ...
      *           ...
      *      WHEN ...
      *           ...
      *    END-EVALUATE.

       EVENTO-BTN-CHAMAR-PRG08.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG08'
           CANCEL 'PRG08'.

       EVENTO-BTN-CHAMAR-PRG08B.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG08B'
           CANCEL 'PRG08B'.

       EVENTO-BTN-CHAMAR-PRG09.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG09'
           CANCEL 'PRG09'.

       EVENTO-BTN-CHAMAR-PRG09B.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG09B'
           CANCEL 'PRG09B'.

       EVENTO-BTN-CHAMAR-PRG09C.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG09C'
           CANCEL 'PRG09C'.

       EVENTO-BTN-CHAMAR-PRG10.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           CALL 'PRG10'
           CANCEL 'PRG10'.

       MOSTRA-MSG-ERRO.
           MOVE 1 TO CA-MESSAGE-TYPE CA-MESSAGE-RESP
           CALL "CAMESSAG"
           CANCEL "CAMESSAG".

       MOSTRA-MSG-ATENCAO.
           MOVE 2 TO CA-MESSAGE-TYPE
           MOVE 1 TO CA-MESSAGE-RESP
           CALL "CAMESSAG"
           CANCEL "CAMESSAG".

       MOSTRA-MSG-MENSAGEM.
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 1 TO CA-MESSAGE-RESP
           CALL "CAMESSAG"
           CANCEL "CAMESSAG".

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG10.
       AUTHOR.        EDILSON.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-EXECUTAR1            VALUE 02.
       78  EXCEPTION-EXECUTAR2             VALUE 03.

       01  CAMPOS-W.
           03  CAMPOS-TELA-W.
               05 W-LINHA-DETALHE         PIC  X(80).
               05 W-STRING-ORIGEM         PIC  X(150).
               05 W-TAB-AUX.
                  07 AUX-T                PIC  X(50) OCCURS 10.
               05 IND                     PIC  9(02).
               05 TAM-STR                 PIC  9(05).
               05 PTR                     PIC  9(05).
               05 CONT                    PIC  9(03).
               05 QTD-SEPARACOES          PIC  9(03).
               03 X-100                   PIC  X(100).

               03 OPCAO-TELA              PIC  9(01).
                  88 OPC-VALIDA           VALUE 2 THRU 5 FALSE 6.

       01  CAMPOS-ERRO-ARQUIVO-W.
           03  WS-EXTEND-STATUS           PIC  X(10).
           03  W-FSTATUS                  PIC  X(02).
           03  W-EXTSTAT                  PIC  X(08).
           03  W-ARQUIVO                  PIC  X(150).

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

       01  JANELA-PROGRAMA                PIC X(10).

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 01,5 COL 03
                          TITLE "Resultado do comando UNSTRING"
                          ID 1
                          TRANSPARENT.

           03 LST-BOX-RESULTADO LIST-BOX
                                LINE 03
                                COL 02
                                SIZE 69,5
                                LINES 16
                                3-D
                                ID 2
                                FONT SMALL-FONT
                                UNSORTED.

           03 LABEL       LINE 21 COL 03
                          TITLE "String a ser separada"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-STRING-ORIGEM
                          SIZE 52,5 | tamanho do campo na tela
                          MAX-TEXT 150 | tamanho maximo de caracteres na tela
                          LINE 21      
                          COL 21
                          3-D | efeito de caixa
                          BOXED | contornar como caixa
                          AUTO | ???
                          ID 4
                          FONT SMALL-FONT.

           03 PUSH-BUTTON TITLE "&Executar (1)"
                          LINE 24
                          COL 02
                          SIZE 12
                          ID 5
                          EXCEPTION-VALUE EXCEPTION-EXECUTAR1.

           03 PUSH-BUTTON TITLE "&Executar (2)"
                          LINE 24
                          COL 17
                          SIZE 12
                          ID 5
                          EXCEPTION-VALUE EXCEPTION-EXECUTAR2.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 24
                          COL 32
                          SIZE 13
                          SELF-ACT
                          ID 6
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           SET OPC-VALIDA TO TRUE.
           SET OPC-VALIDA TO FALSE.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 75 LINES 25,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Teste de UNSTRING"
                            NO SCROLL
                            SYSTEM MENU
                            AUTO-RESIZE
                            BACKGROUND-LOW
                            HANDLE JANELA-PROGRAMA.

           DISPLAY TELA-PRINCIPAL.

           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE WINDOW JANELA-PROGRAMA.


           EXIT PROGRAM
           STOP RUN.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-EXECUTAR1
                  MODIFY LST-BOX-RESULTADO, RESET-LIST = 1
                  MOVE SPACES TO W-TAB-AUX
                  UNSTRING W-STRING-ORIGEM DELIMITED ALL SPACES
                           INTO AUX-T(1)
                                AUX-T(2)
                                AUX-T(3)
                                AUX-T(4)
                                AUX-T(5)
                                AUX-T(6)
                                AUX-T(7)
                                AUX-T(8)
                                AUX-T(9)
                                AUX-T(10)
                  PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 10
                     MOVE SPACES TO W-LINHA-DETALHE
                     STRING 'Conte?do do campo AUX-T(' 
                            IND
                            ') = '
                            AUX-T(IND)
                       DELIMITED SIZE INTO W-LINHA-DETALHE
                     MODIFY LST-BOX-RESULTADO,
                            ITEM-TO-ADD = W-LINHA-DETALHE
                  END-PERFORM
             WHEN EXCEPTION-EXECUTAR2
                  MODIFY LST-BOX-RESULTADO, RESET-LIST = 1
                  INITIALIZE QTD-SEPARACOES
                  SET TAM-STR TO SIZE OF W-STRING-ORIGEM
                  MOVE 1 TO PTR
                  PERFORM UNTIL 1 = 2
                     UNSTRING W-STRING-ORIGEM DELIMITED BY ALL SPACES
                              INTO         X-100 COUNT CONT
                              POINTER      PTR
                              TALLYING QTD-SEPARACOES
                              ON OVERFLOW
                                 IF PTR > TAM-STR
                                    EXIT PERFORM
                                 END-IF
                     END-UNSTRING
                     IF X-100 <> SPACES
                        MOVE SPACES TO W-LINHA-DETALHE
                        STRING 'Qtd. caracteres = ' CONT
                               ' - String separada = ' X-100
                          DELIMITED SIZE INTO W-LINHA-DETALHE
                        MODIFY LST-BOX-RESULTADO,
                               ITEM-TO-ADD = W-LINHA-DETALHE
                     END-IF
                  END-PERFORM
                  MOVE SPACES TO W-LINHA-DETALHE
                  STRING 'Qtd. de separa??es feitas = ' QTD-SEPARACOES
                     DELIMITED SIZE INTO W-LINHA-DETALHE
                  MODIFY LST-BOX-RESULTADO,
                         ITEM-TO-ADD = W-LINHA-DETALHE
           END-EVALUATE.

       ERRO-ARQUIVO.
           CALL "C$RERR" USING WS-EXTEND-STATUS
           MOVE WS-EXTEND-STATUS(1:2) TO W-FSTATUS
           MOVE WS-EXTEND-STATUS(3:)  TO W-EXTSTAT
           CALL "C$RERRNAME" USING W-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE W-FSTATUS TO CA-MESSAGE-ID CONVERT
           MOVE W-ARQUIVO TO CA-ERR-FILE
           MOVE SPACES    TO CA-ERR-BUF
           MOVE 1 TO CA-MESSAGE-TYPE CA-MESSAGE-RESP
           CALL "CAMESSAG"
           CANCEL "CAMESSAG".

           PERFORM FIM.

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

       PERGUNTA-INICIALIZA.
           CALL "C$RERRNAME" USING W-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 'Deseja inicializar o arquivo' TO CA-MESSAGE-1
           MOVE W-ARQUIVO TO CA-MESSAGE-2
           MOVE 2 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 2
              PERFORM ERRO-ARQUIVO.
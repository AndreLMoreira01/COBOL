       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG09.
       AUTHOR.        EDILSON.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT CADFUN ASSIGN TO 'FUNCIONARIO.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   DFUN-RECORDK-1
                  ALTERNATE RECORD KEY DFUN-NOMEFUN-1
                                       WITH DUPLICATES
                  ALTERNATE RECORD KEY DFUN-CHAVALT-1 = DFUN-EMPRESA-1
                                                        DFUN-CENTCUS-1
                                                        DFUN-CODFUNC-1
                  FILE STATUS  IS STAT-CADFUN.

           SELECT SORTER ASSIGN TO 'SORTER.ARQ'
                  FILE STATUS   IS STAT-SORTER.

       DATA DIVISION.
       FILE SECTION.

       FD  CADFUN  LABEL RECORD IS STANDARD.

       01  DFUN-REGISTR-1.
           03  DFUN-RECORDK-1.
               05 DFUN-EMPRESA-1          PIC  9(03).
               05 DFUN-CODFUNC-1          PIC  9(06).
           03  DFUN-NOMEFUN-1             PIC  X(60).
           03  DFUN-CENTCUS-1             PIC  9(06).
           03  DFUN-DATADMI-1             PIC  9(08).
           03  DFUN-SALARIO-1             PIC  9(11)V99.

       SD  SORTER.

       01  SORT-REGISTR-1.
           03  SORT-EMPRESA-1             PIC  9(03).
           03  SORT-CODFUNC-1             PIC  9(06).
           03  SORT-NOMEFUN-1             PIC  X(60).

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-CLASSIFICAR          VALUE 02.

       01  CAMPOS-W.
           03  STAT-CADFUN                PIC  X(02).
               88 VALID-CADFUN            VALUE '00' THRU '09'.
           03  STAT-SORTER                PIC  X(02).
               88 VALID-SORTER            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-LINHA-DETALHE         PIC  X(80).
               05 W-OPC-CLASSIFICACAO     PIC  9(02) VALUE 0.

               05 W-CAMPO-NOME            PIC  X(05) VALUE ' '.
               05 W-CAMPO-CODIGO          PIC  X(05) VALUE ' '.

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

           03  W-SCREEN-CONTROL IS SPECIAL-NAMES SCREEN CONTROL.
               05 W-ACCEPT-CONTROL        PIC 9.
               05 W-CONTROL-VALUE         PIC 999.
               05 W-CONTROL-HANDLE        USAGE HANDLE.
               05 W-CONTROL-ID            PIC X(2) COMP-X.

       01  JANELA-PROGRAMA                PIC X(10).

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LST-BOX-CLASSIFICACAO LIST-BOX
                       LINE 03
                       COL 02
                       SIZE 70
                       LINES 19
                       3-D
                       ID 1
                       FONT SMALL-FONT
                       UNSORTED.

           03 FRAME    LINE 02,75
                       COL 79
                       LINES 05
                       SIZE 22
                       TITLE "Ordem de classificação"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "&Nome"
                       LINE 04
                       COL 80
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-OPC-CLASSIFICACAO
                       ID 2
                       FONT SMALL-FONT
                       NOTIFY
                       EXCEPTION PROCEDURE EXCEPTION-RADIO
                       .

           03 RADIO-BUTTON
                       TITLE "&Código"
                       LINE 06
                       COL 80
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-CLASSIFICACAO
                       ID 3
                       FONT SMALL-FONT
                       NOTIFY
                       EXCEPTION PROCEDURE EXCEPTION-RADIO
                       .

           03 CAMPO-NOME-TELA  ENTRY-FIELD USING W-CAMPO-NOME
                          LINE 08
                          COL 80
                          3-D
                          BOXED
                          AUTO
                          FONT SMALL-FONT.
           03 CAMPO-CODIGO-TELA  ENTRY-FIELD USING W-CAMPO-CODIGO
                          LINE 10
                          COL 80
                          3-D
                          BOXED
                          AUTO
                          FONT SMALL-FONT.

           03 PUSH-BUTTON TITLE "C&lassificar"
                          LINE 24
                          COL 02
                          SIZE 12
                          ID 4
                          EXCEPTION-VALUE EXCEPTION-CLASSIFICAR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 24
                          COL 17
                          SIZE 13
                          SELF-ACT
                          ID 5
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN INPUT CADFUN
           IF NOT VALID-CADFUN
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 105 LINES 25,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Teste de SORT"
                            NO SCROLL
                            SYSTEM MENU
                            AUTO-RESIZE
                            BACKGROUND-LOW
                            HANDLE JANELA-PROGRAMA.

           MOVE '11111' TO W-CAMPO-NOME
           MOVE '22222' TO W-CAMPO-CODIGO

           DISPLAY TELA-PRINCIPAL.

           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE CADFUN.

           CLOSE WINDOW JANELA-PROGRAMA.

           CANCEL SORT.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-CLASSIFICAR
                  PERFORM EXECUTA-CLASSIFICACAO
           END-EVALUATE.

       EXECUTA-CLASSIFICACAO.
            MODIFY LST-BOX-CLASSIFICACAO, RESET-LIST = 1
            INITIALIZE DFUN-REGISTR-1
            START CADFUN KEY >= DFUN-RECORDK-1
            IF VALID-CADFUN
               IF W-OPC-CLASSIFICACAO = 1
                  SORT SORTER ASCENDING KEY SORT-EMPRESA-1
                                            SORT-NOMEFUN-1
                                            SORT-CODFUNC-1
                       INPUT  PROCEDURE INPUTPROCE
                       OUTPUT PROCEDURE OUTPUTPROC
               ELSE
                  SORT SORTER ASCENDING KEY SORT-EMPRESA-1
                                            SORT-CODFUNC-1
                                            SORT-NOMEFUN-1
                       INPUT  PROCEDURE INPUTPROCE
                       OUTPUT PROCEDURE OUTPUTPROC
               END-IF
            END-IF.

       INPUTPROCE.
           PERFORM UNTIL NOT VALID-CADFUN
              READ CADFUN NEXT AT END
                               EXIT PERFORM
              END-READ
              IF NOT VALID-CADFUN
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE             SORT-REGISTR-1
              MOVE DFUN-EMPRESA-1 TO SORT-EMPRESA-1
              MOVE DFUN-CODFUNC-1 TO SORT-CODFUNC-1
              MOVE DFUN-NOMEFUN-1 TO SORT-NOMEFUN-1
              RELEASE SORT-REGISTR-1
           END-PERFORM.

       OUTPUTPROC.
           PERFORM UNTIL 1 = 2
              RETURN SORTER AT END
                             EXIT PERFORM
              END-RETURN
              MOVE SPACES TO W-LINHA-DETALHE
              STRING SORT-EMPRESA-1 ' '
                     SORT-CODFUNC-1 ' '
                     SORT-NOMEFUN-1
                DELIMITED SIZE INTO W-LINHA-DETALHE
              MODIFY LST-BOX-CLASSIFICACAO,
                         ITEM-TO-ADD = W-LINHA-DETALHE
           END-PERFORM.
           
       EXCEPTION-RADIO.
           IF W-OPC-CLASSIFICACAO = 1
              MODIFY CAMPO-NOME-TELA, ENABLED = TRUE
              MODIFY CAMPO-CODIGO-TELA, ENABLED = FALSE
              INITIALIZE W-CAMPO-CODIGO
              DISPLAY TELA-PRINCIPAL
           ELSE
              MODIFY CAMPO-NOME-TELA, ENABLED = FALSE
              MODIFY CAMPO-CODIGO-TELA, ENABLED = TRUE
              INITIALIZE W-CAMPO-NOME
              DISPLAY TELA-PRINCIPAL
           END-IF.

           PERFORM EXECUTA-CLASSIFICACAO.

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
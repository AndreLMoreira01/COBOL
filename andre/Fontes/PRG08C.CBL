       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG08D.
       AUTHOR.        EDILSON.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT CCUSTO ASSIGN TO 'CCUSTO.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TBCC-CENTCUS-1
                  ALTERNATE RECORD KEY TBCC-NOMECUS-1
                                       WITH DUPLICATES
                  FILE STATUS  IS STAT-CCUSTO.

       DATA DIVISION.
       FILE SECTION.

       FD  CCUSTO  LABEL RECORD IS STANDARD.

       01  TBCC-REGISTR-1.
           03  TBCC-CENTCUS-1             PIC  9(06).
           03  TBCC-NOMECUS-1             PIC  X(60).

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-CCUSTO                PIC  X(02).
               88 VALID-CCUSTO            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CENTCUS-EDIT          PIC  99.99.99.
               05 W-NOMECUS               PIC  X(60).

               05 W-CENTCUS               PIC  9(06).

               05 FILLER                  PIC  X(01) VALUE ' '.
                  88 VALIDACAO-OK         VALUE 'S' FALSE ' '.

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
               88 SETA-CIMA               VALUE 52.
               88 SETA-BAIXO              VALUE 53.
               88 OCORREU-EVENTO          VALUE 96.

           03  W-SCREEN-CONTROL IS SPECIAL-NAMES SCREEN CONTROL.
               05 W-ACCEPT-CONTROL        PIC 9.
               05 W-CONTROL-VALUE         PIC 999.
               05 W-CONTROL-HANDLE        USAGE HANDLE.
               05 W-CONTROL-ID            PIC X(2) COMP-X.

       01  JANELA-PROGRAMA                PIC X(10).

       01  W-FLAG-HABILITADO              PIC 9(01) VALUE 1.

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "Código do c.custo"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CENTCUS-EDIT
                          LINE 02
                          COL 21
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT
                          AFTER PROCEDURE AFTER-PROC-CENTCUS.

           03 LABEL       LINE 04 COL 05
                          TITLE "Descrição"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOMECUS
                          SIZE 60
                          LINE 04
                          COL 21
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT
                          AFTER PROCEDURE AFTER-PROC-NOMECUS.

           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 07,5
                          COL 05
                          SIZE 12
                          ID 5
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 07,5
                          COL 20
                          SIZE 12
                          ID 6
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 07,5
                          COL 35
                          SIZE 13
                          SELF-ACT
                          ID 7
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN I-O CCUSTO
           IF STAT-CCUSTO = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CCUSTO
              CLOSE CCUSTO
              OPEN I-O CCUSTO.
           IF NOT VALID-CCUSTO
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 85 LINES 9
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Cadastro de Centros de Custo"
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
           CLOSE CCUSTO.

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       AFTER-PROC-CENTCUS.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-CENTCUS.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH.

           INITIALIZE             TBCC-REGISTR-1
           MOVE W-CENTCUS-EDIT TO TBCC-CENTCUS-1
           READ CCUSTO
           IF STAT-CCUSTO = '99'
              PERFORM ERRO-ARQUIVO
              |INITIALIZE CA-MESSAGE-LINK
              |MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              |PERFORM MOSTRA-MSG-ATENCAO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.
           IF (NOT VALID-CCUSTO) AND (STAT-CCUSTO <> '23')
              PERFORM ERRO-ARQUIVO.

           MOVE TBCC-NOMECUS-1 TO W-NOMECUS

           DISPLAY TELA-PRINCIPAL.

       AFTER-PROC-NOMECUS.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-NOMECUS
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-GRAVAR
                  PERFORM ROTINA-GRAVAR
             WHEN EXCEPTION-EXCLUIR
                  PERFORM ROTINA-EXCLUIR
           END-EVALUATE.

       ROTINA-GRAVAR.
           PERFORM VALIDA-CENTCUS.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH.

           PERFORM VALIDA-NOMECUS.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH.

           INITIALIZE             TBCC-REGISTR-1
           MOVE W-CENTCUS-EDIT TO TBCC-CENTCUS-1
           READ CCUSTO
           IF STAT-CCUSTO = '23'
              INITIALIZE             TBCC-REGISTR-1
              MOVE W-CENTCUS-EDIT TO TBCC-CENTCUS-1
           ELSE
              IF NOT VALID-CCUSTO
                 PERFORM ERRO-ARQUIVO.

           MOVE W-NOMECUS      TO TBCC-NOMECUS-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-CCUSTO = '23'
              WRITE TBCC-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE TBCC-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-CCUSTO
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       VALIDA-CENTCUS.
           SET VALIDACAO-OK TO TRUE.

           MOVE W-CENTCUS-EDIT TO W-CENTCUS
           IF W-CENTCUS = ZEROS
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Código do C.Custo inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-NOMECUS.
           SET VALIDACAO-OK TO TRUE.

           IF W-NOMECUS = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Descrição do c.custo inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       ROTINA-EXCLUIR.
           INITIALIZE             TBCC-REGISTR-1
           MOVE W-CENTCUS-EDIT TO TBCC-CENTCUS-1
           READ CCUSTO
           IF STAT-CCUSTO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Centro de Custo não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-CCUSTO
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE CCUSTO
              IF NOT VALID-CCUSTO
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro excluído.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.

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

           IF W-FSTATUS <> '99'
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
           
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG08B.
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

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-CADFUN                PIC  X(02).
               88 VALID-CADFUN            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-EMPRESA-EDIT          PIC  ZZ9.
               05 W-CODFUNC-EDIT          PIC  ZZZ.ZZ9.
               05 W-NOMEFUN               PIC  X(60).
               05 W-CENTCUS-EDIT          PIC  99.99.99.
               05 W-DATADMI-EDIT          PIC  99/99/9999.
               05 W-SALARIO-EDIT          PIC  ZZ.ZZZ.ZZZ.ZZ9,99.

               05 W-EMPRESA               PIC  9(03).
               05 W-CODFUNC               PIC  9(06).

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
           03 LABEL       LINE 02 COL 05
                          TITLE "Código da empresa"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-EMPRESA-EDIT
                          LINE 02
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 04 COL 05
                          TITLE "Matrícula do funcionário"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CODFUNC-EDIT
                          LINE 04
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT
                          AFTER PROCEDURE AFTER-PROC-CODFUNC.
           
           03 LABEL       LINE 06 COL 05
                          TITLE "Nome do funcionário"
                          ID 5
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOMEFUN
                          SIZE 60
                          LINE 06
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 6
                          FONT SMALL-FONT.

           03 LABEL       LINE 08 COL 05
                          TITLE "Centro de custo"
                          ID 7
                          TRANSPARENT.
           
           03 ENTRY-FIELD USING W-CENTCUS-EDIT
                          LINE 08
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT.

           03 LABEL       LINE 10 COL 05
                          TITLE "Data de admissão"
                          ID 9
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATADMI-EDIT
                          LINE 10
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 10
                          FONT SMALL-FONT.

           03 LABEL       LINE 12 COL 05
                          TITLE "Salário"
                          ID 11
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-SALARIO-EDIT
                          LINE 12
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 12
                          FONT SMALL-FONT.

           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 15,5
                          COL 05
                          SIZE 12
                          ID 13
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 15,5
                          COL 20
                          SIZE 12
                          ID 14
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 15,5
                          COL 35
                          SIZE 13
                          SELF-ACT
                          ID 15
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN I-O CADFUN
           IF STAT-CADFUN = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CADFUN
              CLOSE CADFUN
              OPEN I-O CADFUN.
           IF NOT VALID-CADFUN
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Manutenção de Funcionários"
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
           CLOSE CADFUN.

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       AFTER-PROC-CODFUNC.
           IF TECLOU-ESC
              EXIT PARAGRAPH.

           INITIALIZE             DFUN-REGISTR-1
           MOVE W-EMPRESA-EDIT TO DFUN-EMPRESA-1
           MOVE W-CODFUNC-EDIT TO DFUN-CODFUNC-1
           READ CADFUN
           IF STAT-CADFUN = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF (NOT VALID-CADFUN) AND (STAT-CADFUN <> '23')
              PERFORM ERRO-ARQUIVO.

           MOVE DFUN-NOMEFUN-1 TO W-NOMEFUN
           MOVE DFUN-CENTCUS-1 TO W-CENTCUS-EDIT
           MOVE DFUN-DATADMI-1 TO W-DATADMI-EDIT
           MOVE DFUN-SALARIO-1 TO W-SALARIO-EDIT

           DISPLAY TELA-PRINCIPAL.

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
           MOVE W-EMPRESA-EDIT TO W-EMPRESA
           IF W-EMPRESA = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Empresa inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           MOVE W-CODFUNC-EDIT TO W-CODFUNC
           IF W-CODFUNC = ZEROS
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Matrícula do funcionário inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           IF W-NOMEFUN = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Nome do funcionário inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 6 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             DFUN-REGISTR-1
           MOVE W-EMPRESA-EDIT TO DFUN-EMPRESA-1
           MOVE W-CODFUNC-EDIT TO DFUN-CODFUNC-1
           READ CADFUN
           IF STAT-CADFUN = '23'
              INITIALIZE             DFUN-REGISTR-1
              MOVE W-EMPRESA-EDIT TO DFUN-EMPRESA-1
              MOVE W-CODFUNC-EDIT TO DFUN-CODFUNC-1
           ELSE
              IF NOT VALID-CADFUN
                 PERFORM ERRO-ARQUIVO.

           MOVE W-NOMEFUN      TO DFUN-NOMEFUN-1
           MOVE W-CENTCUS-EDIT TO DFUN-CENTCUS-1
           MOVE W-DATADMI-EDIT TO DFUN-DATADMI-1
           MOVE W-SALARIO-EDIT TO DFUN-SALARIO-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-CADFUN = '23'
              WRITE DFUN-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE DFUN-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-CADFUN
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       ROTINA-EXCLUIR.
           INITIALIZE             DFUN-REGISTR-1
           MOVE W-EMPRESA-EDIT TO DFUN-EMPRESA-1
           MOVE W-CODFUNC-EDIT TO DFUN-CODFUNC-1
           READ CADFUN
           IF STAT-CADFUN = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Funcionário não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-CADFUN
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE CADFUN
              IF NOT VALID-CADFUN
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
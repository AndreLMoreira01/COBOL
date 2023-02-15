,       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG09c.
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

           SELECT PRINTF ASSIGN TO PRINTER
                  FILE STATUS IS STAT-PRINTF.

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


       FD  PRINTF LABEL RECORD OMITTED.
 
       01  PRINTF-R                       PIC X(255).

       
       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       77  FIXED-FONT                     HANDLE.
       78  EXCEPTION-CLASSIFICAR          VALUE 02.
       78  EXCEPTION-IMPRIMIR             VALUE 03.

       01  CAMPOS-W.
           03  STAT-CADFUN                PIC  X(02).
               88 VALID-CADFUN            VALUE '00' THRU '09'.
           03  STAT-PRINTF                PIC  X(02).
               88 VALID-PRINTF            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-LINHA-DETALHE.
                  07 W-EMPRESA-DET        PIC  ZZ9B(2).
                  07 W-CODFUNC-DET        PIC  ZZZ.ZZ9B.
                  07 W-CENTCUS-DET        PIC  99.99.99B.
                  07 W-NOMEFUN-DET        PIC  X(30)B.
                  07 W-DATADMI-DET        PIC  99/99/9999.
               05 W-OPC-CLASSIFICACAO     PIC  9(02) VALUE 1.

           03  LINHA-LIST-BOX             PIC  9(05).

           03  W-FONTE-LIST-BOX           HANDLE OF FONT.

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
               88 OCORREU-EVENTO          VALUE 96.

       01  JANELA-PROGRAMA             PIC X(10).

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".
           COPY "FONTS.DEF".
           COPY "ACUCOBOL.DEF".

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LST-BOX-CLASSIFICACAO LIST-BOX
                       LINE 03
                       COL 02
                       SIZE 61
                       LINES 17
                       3-D
                       ID 1
                       FONT W-FONTE-LIST-BOX
                       UNSORTED
                       NOTIFY-DBLCLICK
                       FOREGROUND-COLOR CYAN
                       EXCEPTION PROCEDURE EXCEPTION-LIST-BOX.

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
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&Código"
                       LINE 06
                       COL 80
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-CLASSIFICACAO
                       ID 3
                       FONT SMALL-FONT
                       NOTIFY.

           03 PUSH-BUTTON TITLE "Mostrar na Te&la"
                          LINE 24
                          COL 02
                          SIZE 14
                          ID 4
                          EXCEPTION-VALUE EXCEPTION-CLASSIFICAR.

           03 PUSH-BUTTON TITLE "&Imprimir"
                          LINE 24
                          COL 19
                          SIZE 12
                          ID 5
                          EXCEPTION-VALUE EXCEPTION-IMPRIMIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 24
                          COL 34
                          SIZE 13
                          SELF-ACT
                          ID 6
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN INPUT CADFUN
           IF NOT VALID-CADFUN
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           ACCEPT FIXED-FONT FROM STANDARD OBJECT "FIXED-FONT".

           INITIALIZE WFONT-DATA.
           MOVE "Courier New" TO WFONT-NAME
           MOVE  8   TO WFONT-SIZE
           CALL "W$FONT" USING WFONT-GET-FONT,
                         W-FONTE-LIST-BOX
                         WFONT-DATA.

           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 105 LINES 25,5
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Teste de Leitura pela Chave Alternada"
                           NO SCROLL
                           SYSTEM MENU
                           |AUTO-RESIZE
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

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-CLASSIFICAR
             WHEN EXCEPTION-IMPRIMIR
                  IF TECLA-ESCAPE = EXCEPTION-CLASSIFICAR
                     MODIFY LST-BOX-CLASSIFICACAO, RESET-LIST = 1
                  ELSE
                     OPEN OUTPUT PRINTF
                  END-IF
                  INITIALIZE DFUN-REGISTR-1
                  IF W-OPC-CLASSIFICACAO = 1
                     |* faz o start pela chave alternada de nome
                     START CADFUN KEY >= DFUN-NOMEFUN-1
                  ELSE
                     |* faz o start pela chave primaria (codigo)
                     START CADFUN KEY >= DFUN-RECORDK-1
                  END-IF
                  IF VALID-CADFUN
                     PERFORM LOOP-LEITURA
                  END-IF
                  IF TECLA-ESCAPE = EXCEPTION-IMPRIMIR
                     CLOSE PRINTF
                  END-IF
           END-EVALUATE.

       LOOP-LEITURA.
           PERFORM UNTIL NOT VALID-CADFUN
              READ CADFUN NEXT AT END
                               EXIT PERFORM
              END-READ
              IF NOT VALID-CADFUN
                 PERFORM ERRO-ARQUIVO
              END-IF
              MOVE DFUN-EMPRESA-1 TO W-EMPRESA-DET
              MOVE DFUN-CODFUNC-1 TO W-CODFUNC-DET
              MOVE DFUN-NOMEFUN-1 TO W-NOMEFUN-DET
              MOVE DFUN-CENTCUS-1 TO W-CENTCUS-DET
              MOVE DFUN-DATADMI-1 TO W-DATADMI-DET
              IF TECLA-ESCAPE = EXCEPTION-CLASSIFICAR
                 MODIFY LST-BOX-CLASSIFICACAO,
                            ITEM-TO-ADD = W-LINHA-DETALHE
              ELSE
                 MOVE W-LINHA-DETALHE TO PRINTF-R
                 WRITE PRINTF-R AFTER 1
              END-IF
           END-PERFORM.

       EXCEPTION-LIST-BOX.
           IF OCORREU-EVENTO
              IF EVENT-TYPE = CMD-DBLCLICK
                 |* verifica em qual linha do list box foi dado o clique duplo
                 |* e armazena na variavel LINHA-LIST-BOX
                 INQUIRE LST-BOX-CLASSIFICACAO,
                         SELECTION-INDEX IN LINHA-LIST-BOX
                 |* indica para o Cobol qual linha do list-box desejo retornar
                 |* o resultado:
                 MODIFY LST-BOX-CLASSIFICACAO,
                        QUERY-INDEX = LINHA-LIST-BOX
                 |* pega o conteudo a linha do list-box setada no comando MODIFY
                 |* da linha anterior, e armazena no campo W-LINHA-DETALHE
                 INQUIRE LST-BOX-CLASSIFICACAO,
                         ITEM-VALUE IN W-LINHA-DETALHE
                 INITIALIZE CA-MESSAGE-LINK
                 STRING 'Linha do list-box selecionada : '
                        LINHA-LIST-BOX
                   DELIMITED SIZE INTO CA-MESSAGE-1
                 MOVE 'Conteúdo da linha : ' TO CA-MESSAGE-2
                 MOVE W-LINHA-DETALHE TO CA-MESSAGE-3
                 PERFORM MOSTRA-MSG-MENSAGEM
              END-IF
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

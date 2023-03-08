       IDENTIFICATION DIVISION.
       PROGRAM-ID.    TABGAB.
       AUTHOR.        GABRIEL.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           COPY "sintab01.sl".

       DATA DIVISION.
       FILE SECTION.

           COPY "sintab01.fd".

       WORKING-STORAGE SECTION.
           COPY "SINWRK.CPY".
           COPY "SINRELW.CPY".

       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.
       78  EXCEPTION-LER                  VALUE 04.
       78  EXCEPTION-CONTAR               VALUE 05.
       78  EXCEPTION-CONTAR02             VALUE 06.

       01  CAMPOS-W.
           03  STAT-SINTAB01                PIC  X(02).
               88 VALID-SINTAB01            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CODMUNI-EDIT          PIC  9(005).
               05 W-NOMEMUN-EDIT          PIC  X(030).
               05 W-CODIBGE-EDIT          PIC  9(007).
               05 W-SIGLEST-EDIT          PIC  X(002).

               05 CONT                    PIC  9(05).

       01  CAMPOS-903-00-ERROARQUIV-W.
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

       LINKAGE SECTION.

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 05
                          COL 05
                          TITLE "Código do Município"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CODMUNI-EDIT
                          LINE 05
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
			                 SIZE 16
                          FONT SMALL-FONT.
           
           03 PUSH-BUTTON TITLE "&Ler o arquivo"
                          LINE 05
                          COL 50
                          SIZE 12
                          ID 3
                          EXCEPTION-VALUE EXCEPTION-LER.

           03 LABEL       LINE 07
                          COL 05
                          TITLE "Nome do Município"
                          ID 4
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOMEMUN-EDIT
                          SIZE 16
                          LINE 07
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 5
                          FONT SMALL-FONT.

           03 LABEL       LINE 9
                          COL 05
                          TITLE "Código do IBGE"
                          ID 6
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CODIBGE-EDIT
                          SIZE 16
                          LINE 9
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 7
                          FONT SMALL-FONT.

           03 LABEL       LINE 11
                          COL 05
                          TITLE "Estado"
                          ID 8
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-SIGLEST-EDIT
                          LINE 11
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 9
			                 SIZE 16
                          FONT SMALL-FONT.
           
           03 PUSH-BUTTON TITLE "&Contar cidades SQL"
                          LINE 11
                          COL 50
                          SIZE 20
                          ID 10
                          EXCEPTION-VALUE EXCEPTION-CONTAR.
           
           03 PUSH-BUTTON TITLE "&Contar cidades COBOL"
                          LINE 11
                          COL 75
                          SIZE 20
                          ID 10
                          EXCEPTION-VALUE EXCEPTION-CONTAR02.
     
           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 14,5
                          COL 05
                          SIZE 12
                          ID 11
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 14,5
                          COL 20
                          SIZE 12
                          ID 12
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 14,5
                          COL 35
                          SIZE 12
                          SELF-ACT
                          ID 13
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
           COPY "MAINRTN.DCL".

       INICIO.
           OPEN I-O SINTAB01
           IF STAT-SINTAB01 = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT SINTAB01
              CLOSE SINTAB01
              OPEN I-O SINTAB01.
           IF NOT VALID-SINTAB01
              PERFORM 903-00-ERROARQUIV.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Manutenção de Municípios"
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

       FECHA-TUDO.
           CLOSE SINTAB01.
           CLOSE WINDOW JANELA-PROGRAMA.
           COPY "FINALIZA.CPY".

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-GRAVAR
                  PERFORM ROTINA-GRAVAR
             WHEN EXCEPTION-EXCLUIR
                  PERFORM ROTINA-EXCLUIR
             WHEN EXCEPTION-LER
                  PERFORM ROTINA-LER
             WHEN EXCEPTION-CONTAR
                  PERFORM ROTINA-CONTAR
             WHEN EXCEPTION-CONTAR02
                  PERFORM ROTINA-CONTAR02
           END-EVALUATE.

       ROTINA-GRAVAR.
           IF W-CODMUNI-EDIT = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Código do Município inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID
              EXIT PARAGRAPH.

           IF W-NOMEMUN-EDIT = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'O nome da Município é obrigatório.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 5 TO W-CONTROL-ID
              EXIT PARAGRAPH.

           INITIALIZE             NTAB-REGISTR-1
           MOVE W-CODMUNI-EDIT TO NTAB-CODMUNI-1
           READ SINTAB01
           IF STAT-SINTAB01 = '23'
              INITIALIZE             NTAB-REGISTR-1
              MOVE W-CODMUNI-EDIT TO NTAB-CODMUNI-1
           ELSE
              IF NOT VALID-SINTAB01
                 PERFORM 903-00-ERROARQUIV.

           MOVE W-NOMEMUN-EDIT TO NTAB-NOMEMUN-1
           MOVE W-CODIBGE-EDIT TO NTAB-CODIBGE-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-SINTAB01 = '23'
              WRITE NTAB-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE NTAB-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-SINTAB01
              PERFORM 903-00-ERROARQUIV.

           PERFORM MOSTRA-MSG-MENSAGEM.

       ROTINA-EXCLUIR.
           INITIALIZE             NTAB-REGISTR-1
           MOVE W-CODMUNI-EDIT TO NTAB-CODMUNI-1
           READ SINTAB01
           IF STAT-SINTAB01 = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Município não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-SINTAB01
                 PERFORM 903-00-ERROARQUIV.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1

              UNLOCK SINTAB01
              INITIALIZE WSIN-IFXSSQL-G
              STRING 'DELETE FROM sintab '
                     'WHERE ntab_codmuni_1 = '  NTAB-CODIMUNI-1
                DELIMITED BY SIZE INTO WSIN-IFXSSQL-G
              END-STRING
              PERFORM IFX-EXECSQL

              IF NOT VALID-SINTAB01
                 PERFORM 903-00-ERROARQUIV
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro excluído.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.

       ROTINA-LER.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        NTAB-REGISTR-1
           MOVE W-CODMUNI-EDIT TO NTAB-CODMUNI-1
           READ SINTAB01
           IF STAT-SINTAB01 = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF STAT-SINTAB01 = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Município não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-SINTAB01
                 PERFORM 903-00-ERROARQUIV.

           MOVE NTAB-NOMEMUN-1 TO W-NOMEMUN-EDIT
           MOVE NTAB-CODIBGE-1 TO W-CODIBGE-EDIT

           DISPLAY TELA-PRINCIPAL.

       ROTINA-CONTAR
           INITIALIZE WSIN-IFXSSQL-G
           STRING "SELECT COUNT(*) AS QTDMUNI"
                  " FROM SINTAB01"
                  " WHERE NTAB-SIGLEST-1 = '"
                  W-SIGLEST-EDIT "'"
               DELIMITED SIZE INTO WSIN-IFXSSQL-G
           END-STRING.
           PERFORM IFX-QUERY.
           IF VALID-IFXQUER
              MOVE 'QTDMUNI' TO WSIN-IFXFNAM-G
              PERFORM IFX-FIELDBYNAME
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Qtd de municípios SQL: '
                     WSIN-X256
                 DELIMITED BY '  '
                 INTO CA-MESSAGE-1
              END-STRING
              PERFORM MOSTRA-MSG-ATENCAO
           END-IF.
           PERFORM IFX-CLOSEQUERY.

       ROTINA-CONTAR02
           CALL 'SINTERM' USING 1, 'Aguarde...',
                                'SINTAB01.ARQ', 'REGISTROS'.
           INITIALIZE NTAB-REGISTR-1 CONT.

           INITIALIZE WSIN-IFXSSQL-G.
           MOVE 'SINTAB01' TO WSIN-IFXFILE-G.
           STRING "NTAB_SIGLEST_1 = '" W-SIGLEST-EDIT "'"
              DELIMITED BY SIZE INTO WSIN-IFXSSQL-G
           END-STRING.
           PERFORM IFX-SETSTARTRANGE.

           START SINTAB01 KEY >= NTAB-CODMUNI-1.
           PERFORM UNTIL NOT VALID-SINTAB01
             READ SINTAB01 NEXT WITH NO LOCK AT END
                  EXIT PERFORM
             END-READ

             ADD 1 TO WTER-EVOLUCA-G
             CALL 'SINTERM' USING 2

             IF W-SIGLEST-EDIT = NTAB-SIGLEST-1
                ADD 1 TO CONT
             END-IF
           END-PERFORM.
           CALL 'SINTERM' USING 3.
           CANCEL 'SITERM'.
           STRING 'Qtd de municípios COBOL: '
                  CONT
               DELIMITED BY SIZE
               INTO CA-MESSAGE-1
           END-STRING.
           PERFORM MOSTRA-MSG-ATENCAO.
           

       903-00-ERROARQUIV.
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

           PERFORM FECHA-TUDO.

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
              PERFORM 903-00-ERROARQUIV.

       ROTINAS-FINAIS
           COPY "SINFIM.CPY".
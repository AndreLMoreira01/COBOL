       IDENTIFICATION DIVISION.
       PROGRAM-ID.    VENDAS.
       AUTHOR.        ANDRE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT TAVV ASSIGN TO 'TAVV.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TAVV.

       DATA DIVISION.
       FILE SECTION.

       FD  TAVV  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-1.
           03  TDES-RECORDK-1.
               05 TDES-CODITAB-1          PIC  9(03).
           03  TDES-VENDEDOR-1             PIC  9(03).
           03  TDES-CLIENTE-1             PIC  9(11).
           03  TDES-PRODUTO-1             PIC  X(10).
           03  TDES-QUANT-1             PIC  9(06).
           03  TDES-VUNIT-1             PIC  9(09)V99.
           03  TDES-DESC-1             PIC  9(03)V99.
           03  TDES-TOTAL-1             PIC  9(09)V99.

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-TAVV               PIC  X(02).
               88 VALID-TAVV           VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CODITAB-EDIT          PIC  ZZ9.
               05 W-VENDEDOR-EDIT         PIC  ZZ9,99.
               05 W-CLIENTE-EDIT          PIC  ZZ9,99.
               05 W-PRODUTO-EDIT        PIC  ZZ9,99.
               05 W-QUANT-EDIT           PIC  ZZ9,99.
               05 W-VUNIT-EDIT            PIC  ZZ9,99.
               05 W-DESC-EDIT           PIC  ZZ9,99.
               05 W-TOTAL-EDIT            PIC  ZZ9,99.
               
               05 W-CODITAB               PIC  9(03).
	       05 W-NOMECLI               PIC  X(50).

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
                          TITLE "Vendedor: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-VENDEDOR-EDIT
                          SIZE 05
                          LINE 02
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 04 COL 05
                          TITLE "Cliente: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CLIENTE-EDIT
                          SIZE 05
                          LINE 04
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.
			  AFTER MOSTRA-NOMECLI.

	   03 ENTRY-FIELD USING W-NOMECLI
                          LINE 05 COL 40 READ-ONLY
	                  3-D BOXED AUTO ID 3
			  FONT SMALL-FONT.

           03 LABEL       LINE 06 COL 05
                          TITLE "Produto: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-PRODUTO-EDIT
                          SIZE 05
                          LINE 06
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.


           03 LABEL       LINE 08 COL 05
                          TITLE "Quantidade: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-QUANT-EDIT
                          SIZE 05
                          LINE 08
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.


           03 LABEL       LINE 10 COL 05
                          TITLE "Valor Unitário: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-VUNIT-EDIT
                          SIZE 05
                          LINE 10
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

                          
           03 LABEL       LINE 12 COL 05
                          TITLE "Desconto:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DESC-EDIT
                          SIZE 05
                          LINE 12
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.
                      
           03 LABEL       LINE 14 COL 05
                          TITLE "Total: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-TOTAL-EDIT
                          SIZE 05
                          LINE 14
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 PUSH-BUTTON TITLE "Gravar"
                          LINE 02
                          COL 45
                          SIZE 12
                          ID 14
                          EVENT PROCEDURE EVENTO-BTN-GRAVAR.


           03 PUSH-BUTTON TITLE "Gravar Vendedor"
                          LINE 04
                          COL 45
                          SIZE 12
                          ID 14
                          EVENT PROCEDURE EVENTO-BTN-VENDEDOR.
          
           03 PUSH-BUTTON TITLE "Gravar Cliente"
                          LINE 06
                          COL 45
                          SIZE 12
                          ID 14
                          EVENT PROCEDURE EVENTO-BTN-CLIENTE.

           03 PUSH-BUTTON TITLE "Gravar Produto"
                          LINE 08
                          COL 45
                          SIZE 13
                          SELF-ACT
                          ID 16
                          EVENT PROCEDURE EVENTO-BTN-PRODUTO.

       PROCEDURE DIVISION.
       INICIO.
           OPEN I-O TAVV
           IF STAT-TAVV = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT TAVV
              CLOSE TAVV
              OPEN I-O TAVV.
           IF NOT VALID-TAVV
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Manutenção de Tabela"
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
           CLOSE TAVV.

           CLOSE WINDOW JANELA-PROGRAMA.

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
           END-EVALUATE.

       MOSTRA-NOMECLI.
           INITIALIZE CLIE-REGISTR-1.
	   MOVE W-CODCLIE-EDIT TO CLIE-CODCLIE-1.
	   READ CLIENTE.
	   IF VALID-CLIENTE
	      MOVE CLIE-NOMECLI-1 TO W-NOMECLI
	   END-IF.

       ROTINA-GRAVAR.
           MOVE W-CODITAB-EDIT TO W-CODITAB
           IF W-CODITAB = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             TDES-REGISTR-1
           MOVE W-CODITAB-EDIT TO TDES-CODITAB-1
           READ TAVV
           IF STAT-TAVV = '23'
              INITIALIZE             TDES-REGISTR-1
              MOVE W-CODITAB-EDIT TO TDES-CODITAB-1
           ELSE
              IF NOT VALID-TAVV
                 PERFORM ERRO-ARQUIVO.


           INITIALIZE CA-MESSAGE-LINK

           IF STAT-TAVV = '23'
              WRITE TDES-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE TDES-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-TAVV
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       ROTINA-EXCLUIR.
           INITIALIZE             TDES-REGISTR-1
           MOVE W-CODITAB-EDIT TO TDES-CODITAB-1
           READ TAVV
           IF STAT-TAVV = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-TAVV
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE TAVV
              IF NOT VALID-TAVV
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro excluído.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.

       EVENTO-BTN-CALCULAR.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        TDES-REGISTR-1
           MOVE W-CODITAB-EDIT TO TDES-CODITAB-1
           READ TAVV
           IF STAT-TAVV = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-TAVV
                 PERFORM ERRO-ARQUIVO.

                  
 
         

      

           DISPLAY TELA-PRINCIPAL.

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

       EVENTO-BTN-GRAVAR
         CALL 'TPRG08' USING W-CODITAB-EDIT
            ON OVERFLOW
         INITIALIZE CA-MESSAGE-LINK
            MOVE 'Programa nao encontrado' TO CA-MESSAGE-1
         PERFORM MOSTRA-MSG-MENSAGEM
            END-CALL.
         CANCEL 'TPRG08'.

       EVENTO-BTN-VENDEDOR
         CALL 'VENDEDOR' USING W-CODITAB-EDIT
            ON OVERFLOW
         INITIALIZE CA-MESSAGE-LINK
            MOVE 'Programa nao encontrado' TO CA-MESSAGE-1
         PERFORM MOSTRA-MSG-MENSAGEM
            END-CALL.
         CANCEL 'VENDEDOR'.

       EVENTO-BTN-PRODUTO
         CALL 'PRODUTO' USING W-CODITAB-EDIT
            ON OVERFLOW
         INITIALIZE CA-MESSAGE-LINK
            MOVE 'Programa nao encontrado' TO CA-MESSAGE-1
         PERFORM MOSTRA-MSG-MENSAGEM
            END-CALL.
         CANCEL 'PRODUTO'.

       EVENTO-BTN-CLIENTE
         CALL 'CLIENTE' USING W-CODITAB-EDIT
            ON OVERFLOW
         INITIALIZE CA-MESSAGE-LINK
            MOVE 'Programa nao encontrado' TO CA-MESSAGE-1
         PERFORM MOSTRA-MSG-MENSAGEM
            END-CALL.
         CANCEL 'CLIENTE'.

     
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    VENDAS.
       AUTHOR.        ANDRE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT TAVVENDAS ASSIGN TO 'TAVVENDAS.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TAVVENDAS.
		  
           SELECT TAV ASSIGN TO 'TAV.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TAV.

           SELECT TABPR ASSIGN TO 'TABPR.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TABPR.

           SELECT TABCLI ASSIGN TO 'TABCLI.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TABCLI.

       DATA DIVISION.
       FILE SECTION.

       FD  TAVVENDAS  LABEL RECORD IS STANDARD.

      01  TDES-REGISTR-1.
           03  TDES-RECORDK-1.
	       05 TDES-VENDEDOR-1         PIC  9(03).
	       05 TDES-CLIENTE-1          PIC  9(11).
               05 TDES-PRODUTO-1          PIC  X(10).
           03  TDES-QUANTIDADE-1          PIC  9(6).
           03  TDES-VALORUNI-1            PIC  9(09)V99.
	   03  TDES-DESCONTO-1            PIC  9(03)V99.
           03  TDES-TOTAL-1               PIC  9(09)V99.

       FD  TAV  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-2.
           03  TDES-RECORDK-2.
               05 TDES-CODIGO-2           PIC  9(03).
           03  TDES-NOME-2             PIC  X(50).
           03  TDES-TOTALVENDAS-2      PIC  9(09)V99.

       FD  TABCLI  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-3.
           03  TDES-RECORDK-3.
               05 TDES-CPF-3            PIC  9(11).
           03  TDES-NOME-3                 PIC  X(50).
           03  TDES-LIMITE-3               PIC  9(09)V99.
           03  TDES-DATANASC-3             PIC  9(08).
       
       FD  TABPR  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-4.
           03  TDES-RECORDK-4.
               05 TDES-CODIGO-4           PIC  X(10).
           03  TDES-DESCRICAO-4           PIC  X(50).
           03  TDES-PRECO-4               PIC  9(06)V99.
	   03  TDES-DESCONTOMAX-4         PIC  9(06)V99.
           03  TDES-ESTOQUE-4             PIC  9(06).

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-TABVEND                PIC  X(02).
               88 VALID-TABVEND            VALUE '00' THRU '09'.

	   03  STAT-TABVENDS               PIC  X(02).
               88 VALID-TABVENDS           VALUE '00' THRU '09'.
	   
	   03  STAT-TABCLIE                PIC  X(02).
               88 VALID-TABCLIE            VALUE '00' THRU '09'.

           03  STAT-TABPROD                PIC  X(02).
               88 VALID-TABPROD            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
	       05 W-VENDEDOR-EDIT        PIC  9(03).
	       05 W-CLIENTE-EDIT         PIC  9(11).
               05 W-PRODUTO-EDIT         PIC  X(10).
               05 W-QUANTIDADE-EDIT      PIC  ZZ9,99.
               05 W-VALORUNI-EDIT        PIC  ZZ9,99.
	       05 W-DESCONTO-EDIT        PIC  ZZ9,99.
               05 W-TOTAL-EDIT           PIC  ZZ9,99.

               05 W-VENDEDOR              PIC  9(03).
	       05 W-CLIENTE               PIC  9(03).
               05 W-PRODUTO               PIC  X(10).

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

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-TAVVENDAS               PIC  X(02).
               88 VALID-TAVVENDAS           VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CODITAB-EDIT          PIC  9(03).
               05 W-VENDEDOR-EDIT         PIC  9(03).
               05 W-CLIENTE-EDIT          PIC  9(03).
               05 W-PRODUTO-EDIT        PIC  9(03).
               05 W-QUANT-EDIT           PIC  9(03).
               05 W-VUNIT-EDIT            PIC  9(03).
               05 W-DESC-EDIT           PIC  9(03).
               05 W-TOTAL-EDIT            PIC  9(03).
               
               05 W-CODITAB               PIC  9(03).	  

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
                          TITLE "Valor Unit�rio: "
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
           OPEN I-O TABVEND
           IF STAT-TABVEND = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT TABVEND
              CLOSE TABVEND
              OPEN I-O TABVEND.
           IF NOT VALID-TABVEND
              PERFORM ERRO-ARQUIVO.

	       OPEN I-O TABVENDS.

           OPEN I-O TABCLIE.
           
           OPEN I-O TABPROD.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Manuten��o de Funcion�rios"
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
           CLOSE TABVEND.

           CLOSE TABVENDS.

	       CLOSE TABCLIE.

	       CLOSE TABPROD.

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


       ROTINA-GRAVAR.
           INITIALIZE TDES-REGISTR-2
           MOVE W-VENDEDOR-EDIT TO TDES-CODIGO-2
           READ TABVENDS
           IF NOT VALID-TABVENDS
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Vendedor ' TDES-CODIGO-2 ' n�o cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE TDES-REGISTR-3
           MOVE W-CLIENTE-EDIT TO TDES-CPF-3
           READ TABCLIE
           IF NOT VALID-TABCLIE
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Cliente ' TDES-CPF-3 ' n�o cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE TDES-REGISTR-4
           MOVE W-PRODUTO-EDIT TO TDES-CODIGO-4
           READ TABPROD
           IF NOT VALID-TABPROD
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Produto ' TDES-CODIGO-4 ' n�o cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             TDES-REGISTR-1
           MOVE W-PRODUTO-EDIT TO TDES-PRODUTO-1
	       MOVE W-CLIENTE-EDIT TO TDES-CLIENTE-1
	       MOVE W-VENDEDOR-EDIT TO TDES-VENDEDOR-1
           READ TABVEND
           IF STAT-TABVEND = '23'
              INITIALIZE             TDES-REGISTR-1
              MOVE W-PRODUTO-EDIT TO TDES-PRODUTO-1
	      MOVE W-CLIENTE-EDIT TO TDES-CLIENTE-1
	      MOVE W-VENDEDOR-EDIT TO TDES-VENDEDOR-1
           ELSE
              IF NOT VALID-TABVEND
                 PERFORM ERRO-ARQUIVO.

           MOVE W-QUANTIDADE-EDIT TO TDES-QUANTIDADE-1
           MOVE W-VALORUNI-EDIT TO TDES-VALORUNI-1
           MOVE W-DESCONTO-EDIT TO TDES-DESCONTO-1
           MOVE W-TOTAL-EDIT TO TDES-TOTAL-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-TABVEND = '23'
              WRITE TDES-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE TDES-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-TABVEND
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       ROTINA-EXCLUIR.
           INITIALIZE             TDES-REGISTR-1
           MOVE W-PRODUTO-EDIT TO TDES-PRODUTO-1
           READ TABVEND
           IF STAT-TABVEND = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela n�o cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-TABVEND
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE TABVEND
              IF NOT VALID-TABVEND
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro exclu�do.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.
       
       CADASTRAR-VENDEDOR.
           CALL 'CADASTRO_VENDEDORES' USING W-VENDEDOR-EDIT
		       ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa TABELA n�o encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'VENDAS'.

       CADASTRAR-CLIENTE.
           CALL 'CADASTRO_CLIENTES' USING W-CLIENTE-EDIT
               ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa TABELA n�o encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'VENDAS'.
       
       CADASTRAR-PRODUTO.
           CALL 'CADASTRO_PRODUTOS' USING W-PRODUTO-EDIT
		       ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa TABELA n�o encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'VENDAS'.
       
       EVENTO-BTN-LER-ARQUIVO.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        TDES-REGISTR-1
           MOVE W-PRODUTO-EDIT TO TDES-PRODUTO-1
	   MOVE W-CLIENTE-EDIT TO TDES-CLIENTE-1
	   MOVE W-VENDEDOR-EDIT TO TDES-VENDEDOR-1
           READ TABVEND
           IF STAT-TABVEND = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF STAT-TABVEND = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela n�o cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-TABVEND
                 PERFORM ERRO-ARQUIVO.

           MOVE TDES-QUANTIDADE-1 TO W-QUANTIDADE-EDIT
           MOVE TDES-TOTAL-1 TO W-TOTAL-EDIT
           MOVE TDES-VALORUNI-1 TO W-VALORUNI-EDIT
	   MOVE W-DESCONTO-EDIT TO TDES-DESCONTO-1

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
	

     
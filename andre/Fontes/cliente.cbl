       IDENTIFICATION DIVISION.
       PROGRAM-ID.    CLIENTE.
       AUTHOR.        ANDRE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT TABCLI ASSIGN TO 'TABCLI.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TABCLI.

       DATA DIVISION.
       FILE SECTION.

       FD  TABCLI  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-1.
           03  TDES-RECORDK-1.
               05 TDES-CPF-1          PIC  9(11).
           03  TDES-NOME-1             PIC  X(50).
           03  TDES-DNAC-1             PIC  9(08).
	   03  TDES-LIMITE-1             PIC  9(09)V99.
          

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.
       
       01 FLAG-DATA                       PIC 9(01).
       01 DATA-AUX.          
	  03 DIA             PIC 9(02).
	  03 MES             PIC 9(02).
	  03 ANO             PIC 9(02).

       01  CAMPOS-W.
           03  STAT-TABCLI                PIC  X(02).
               88 VALID-TABCLI            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CPF-EDIT          PIC  ZZ9.
               05 W-NOME-EDIT          PIC  x(60).
               05 W-LIMITE-EDIT          PIC  ZZ9,99.
               05 W-DNAC-EDIT          PIC  99/99/9999.
              

               05 W-CPF          PIC  X(10).
	       05 W-DNAC          PIC  9(08).
            
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

           LINKAGE SECTION.
            01 CODIGO-L PIC 9(003).

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "CPF: "
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CPF-EDIT
                          LINE 02
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 06 COL 05
                          TITLE "Nome: "
                          ID 6
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOME-EDIT
                          SIZE 60
                          LINE 06
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 7
                          FONT SMALL-FONT.

           03 LABEL       LINE 08 COL 05
                          TITLE "Limite:"
                          ID 8
                          TRANSPARENT.
           
           03 ENTRY-FIELD USING W-LIMITE-EDIT
                          LINE 09
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 9
                          FONT SMALL-FONT.

           03 LABEL       LINE 10 COL 05
                          TITLE "Data Nascimento: "
                          ID 10
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DNAC-EDIT
                          LINE 11
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 11
                          FONT SMALL-FONT.

            03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 15,5
                          COL 05
                          SIZE 12
                          ID 14
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.


       PROCEDURE DIVISION USING CODIGO-L.
       INICIO.
           OPEN I-O TABCLI
           IF STAT-TABCLI = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT TABCLI
              CLOSE TABCLI
              OPEN I-O TABCLI.
           IF NOT VALID-TABCLI
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Manuten��o dE Tabela"
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
           CLOSE TABCLI.

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
	   MOVE W-DNAC-EDIT TO W-DNAC.
	   PERFORM VALIDAR-DATA.
	   IF FLAG-DATA NOT = 0
	     INITIALIZE CA-MESSAGE-LINK
	     MOVE 'Data de nascimento inv�lida' TO 
	     CA-MESSAGE-1
            PERFORM MOSTRA-MSG-ERRO
	    MOVE 4 TO W-ACCEPT-CONTROL
	    MOVE 6 TO W-CONTROL-ID
	    EXIT PARAGRAPH
	  END-IF.


           MOVE W-CPF-EDIT TO W-CPF
           IF W-CPF = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela inv�lida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             TDES-REGISTR-1
           MOVE W-CPF-EDIT TO TDES-CPF-1
           READ TABCLI
           IF STAT-TABCLI = '23'
              INITIALIZE             TDES-REGISTR-1
              MOVE W-CPF-EDIT TO TDES-CPF-1
           ELSE
              IF NOT VALID-TABCLI
                 PERFORM ERRO-ARQUIVO.

           MOVE W-NOME-EDIT      TO TDES-NOME-1
           MOVE W-LIMITE-EDIT TO TDES-LIMITE-1
           MOVE W-DNAC-EDIT TO TDES-DNAC-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-TABCLI = '23'
              WRITE TDES-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE TDES-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-TABCLI
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.
       
       VALIDAR-DATA.
	    INITIALIZE FLAG-DATA.
	    MOVE W-DNAC TO DATA-AUX.
	    IF W-DNAC = ZEROS
	       MOVE 1 TO FLAG-DATA
	       EXIT PARAGRAPH
	    END-IF 

	    IF MES < 0 OR MES > 12 OR ANO = 0 OR 
	        DIA = 0 OR DIA > 31
		MOVE 1 TO FLAG-DATA
		EXIT PARAGRAPH
	    END-IF.

       ROTINA-EXCLUIR.
           INITIALIZE             TDES-REGISTR-1
           MOVE W-CPF-EDIT TO TDES-CPF-1
           READ TABCLI
           IF STAT-TABCLI = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Funcion�rio n�o cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-TABCLI
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE TABCLI
              IF NOT VALID-TABCLI
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro exclu�do.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.

       EVENTO-BTN-LER-ARQUIVO.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        TDES-REGISTR-1
           MOVE W-CPF-EDIT TO TDES-CPF-1
           READ TABCLI
           IF STAT-TABCLI = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF STAT-TABCLI = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tabela n�o cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-TABCLI
                 PERFORM ERRO-ARQUIVO.

           MOVE TDES-NOME-1 TO W-NOME-EDIT
           MOVE TDES-LIMITE-1 TO W-LIMITE-EDIT
           MOVE TDES-DNAC-1 TO W-DNAC-EDIT

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
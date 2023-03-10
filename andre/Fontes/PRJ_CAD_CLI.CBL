       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-CAD-CLI.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       COPY "PRJ_CLI.SL".
       COPY "PRJ_BIL.SL".
       COPY "PRJ_LOG.SL".
       
       
       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_CLI.FD".
       COPY "PRJ_BIL.FD".
       COPY "PRJ_LOG.FD".


       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  W-CAMPOS.
           03  ST-CLI                PIC  X(02).
               88 VAL-CLI            VALUE '00' THRU '09'.

	   03  ST-BIL                PIC  X(02).
               88 VAL-BIL            VALUE '00' THRU '09'.

	   03  ST-LOG                PIC  X(02).
               88 VAL-LOG            VALUE '00' THRU '09'.

	   03 CAMPOS-TELA.
	       05 W-CPF-EDIT    PIC  999.999.999.99.
	       05 W-CPF         PIC 9(11).
	       05 W-CPF-T REDEFINES W-CPF PIC 9(1) OCCURS 11 TIMES.
	       05 W-IND         PIC 9(2).
	       05 W-AUX         PIC 9(2).
	       05 W-MULT        PIC 9(4) VALUE 0.
	       05 W-SOMA        PIC 9(4) VALUE 0.
	       05 W-VALOR       PIC 9(4) VALUE 0.
	       05 W-AUXVALOR    PIC 9(2).
	       05 W-RES         PIC 9(4) VALUE 0.
	       05 W-D1          PIC 9(1).
	       05 W-D2          PIC 9(1).
	       05 W-TEL-EDIT	PIC  99.9999.9999.  
	       05 W-TEL         PIC 9(10).
	       05 A-NOME	PIC  X(60).          
	       05 A-END		PIC  X(100).        
	       05 A-COM		PIC  9(04).         
	       05 A-DES		PIC  9(04).
	       05 FILLER                  PIC  X(01) VALUE ' '.
                  88 VALIDACAO-OK         VALUE 'S' FALSE ' '.
	       05 W-DATAUXI               PIC  9(08).
               05 REDEFINES W-DATAUXI.  
                  07 W-DIAAUXI            PIC  9(02).
                  07 W-MESAUXI            PIC  9(02).
                  07 W-ANOAUXI            PIC  9(04).
	       05 REDEFINES W-DATAUXI.  
                  07 W-ANOAUXI-I          PIC  9(04).
                  07 W-MESAUXI-I          PIC  9(02).
                  07 W-DIAAUXI-I          PIC  9(02).
	       05 W-HORA                  PIC  9(08).
	       05 W-DATASIS               PIC  9(8).

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

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".

       LINKAGE SECTION.

       77  W-LOGIN-LC            PIC X(10).  


       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "CPF:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CPF-EDIT
                          LINE 02
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-CPF.
          
	   03 LABEL       LINE 04 COL 05
                          TITLE "Nome:"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING A-NOME
                          LINE 04
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-NOME.

           03 LABEL       LINE 06 COL 05
                          TITLE "Endere?o:"
                          ID 5
                          TRANSPARENT.

           03 ENTRY-FIELD USING A-END
                          LINE 06
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 6
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-END.

           03 LABEL       LINE 08 COL 05
                          TITLE "Telefone:"
                          ID 7
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-TEL-EDIT
                          LINE 08
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-TEL.

	   03 LABEL       LINE 10 COL 05
                          TITLE "N? de viagens:"
                          ID 12
                          TRANSPARENT.

           03 ENTRY-FIELD FROM A-COM
	                  COLOR 33024
                          LINE 10
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 13
                          FONT SMALL-FONT.

	   03 LABEL       LINE 12 COL 05
                          TITLE "Par. Descontos:"
                          ID 20
                          TRANSPARENT.

           03 ENTRY-FIELD USING A-DES
                          LINE 12
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 21
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-DES.

	   
           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 14 
                          COL 05
                          SIZE 12
                          ID 9
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 14
                          COL 20
                          SIZE 10
                          ID 10
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 14
                          COL 35
                          SIZE 12
                          SELF-ACT
                          ID 11
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING W-LOGIN-LC.
       INICIO.
           
	   OPEN I-O CCLIENTE
           IF ST-CLI = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CCLIENTE
              CLOSE CCLIENTE
              OPEN I-O CCLIENTE.
           IF NOT VAL-CLI
              PERFORM ERRO-ARQUIVO.

	   OPEN INPUT CBILHETE
	   IF ST-BIL = '35'
	      PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CBILHETE
              CLOSE CBILHETE
              OPEN INPUT CBILHETE
	   END-IF
           IF NOT VAL-BIL
              PERFORM ERRO-ARQUIVO.

	   OPEN I-O CLOG
           IF ST-LOG = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CLOG
              CLOSE CLOG
              OPEN I-O CLOG.
           IF NOT VAL-LOG
              PERFORM ERRO-ARQUIVO.

	   ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 105 LINES 16
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Cadastro de Clientes"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PROGRAMA.

           DISPLAY TELA-PRINCIPAL.

	   PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXC
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE CCLIENTE CBILHETE CLOG.

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXC.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-GRAVAR
                  PERFORM GRAVAR
             WHEN EXCEPTION-EXCLUIR
                  PERFORM EXCLUIR
           END-EVALUATE.

       PROC-CPF.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
	   MOVE W-CPF-EDIT TO W-CPF 
           PERFORM VALIDA-CPF.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF
         
           INITIALIZE      CLI-REG-1 
	   MOVE W-CPF TO CLI-CPF

           READ CCLIENTE
           IF ST-CLI = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Bloqueado por outro usu?rio.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH
	   END-IF
           IF (NOT VAL-CLI) AND (ST-CLI <> '23')
              PERFORM ERRO-ARQUIVO
	   END-IF

           MOVE CLI-NOME TO A-NOME
           MOVE CLI-END TO A-END
           MOVE CLI-TEL TO W-TEL
	   MOVE W-TEL TO W-TEL-EDIT
	   MOVE CLI-COM TO A-COM
	   MOVE CLI-DESC TO A-DES
           
           DISPLAY TELA-PRINCIPAL.
	 
       PROC-NOME.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-NOME.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       PROC-END.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-END.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       PROC-TEL.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
           MOVE W-TEL-EDIT TO W-TEL
           PERFORM VALIDA-TEL.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       PROC-DES.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-DES.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       GRAVAR.
           PERFORM VALIDA-CPF.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-NOME.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-END.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-TEL.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF


           PERFORM VALIDA-DES.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.



	   INITIALIZE      CLI-REG-1
	 
           MOVE W-CPF TO CLI-CPF
           READ CCLIENTE
           IF ST-CLI = '23'
                INITIALIZE   CLI-REG-1
                MOVE W-CPF TO CLI-CPF
           ELSE
                IF NOT VAL-CLI
                    PERFORM ERRO-ARQUIVO.

	   MOVE A-NOME TO CLI-NOME
           MOVE A-END  TO CLI-END
           MOVE W-TEL  TO CLI-TEL
	   MOVE A-DES  TO CLI-DESC

	   

	   INITIALIZE CA-MESSAGE-LINK
	    ACCEPT W-DATASIS FROM CENTURY-DATE
               MOVE W-DATASIS  TO W-DATAUXI
               COMPUTE W-DATASIS =      W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000

	       ACCEPT W-HORA FROM TIME
	       INITIALIZE LOG-REG-1
	       MOVE W-HORA TO LOG-HORA
	       MOVE W-DATASIS TO LOG-DIA
	       READ CLOG
	       IF ST-LOG = '23'
	          INITIALIZE LOG-REG-1
	          MOVE W-HORA TO LOG-HORA
	          MOVE W-DATASIS TO LOG-DIA
	       ELSE
	           IF NOT VAL-LOG 
                        PERFORM ERRO-ARQUIVO
	           END-IF
	       END-IF

               MOVE W-LOGIN-LC TO LOG-USU
               MOVE A-NOME TO LOG-REG
	       MOVE 'CLIENTE.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC
           IF ST-CLI = '23'
	       MOVE A-COM  TO CLI-COM
	      
	       MOVE 1 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
               WRITE CLI-REG-1
               MOVE 'Cliente gravado.' TO CA-MESSAGE-1
           ELSE
	       MOVE 2 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
              REWRITE CLI-REG-1
              MOVE 'Cliente regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VAL-CLI
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       VALIDA-CPF.

           SET VALIDACAO-OK TO TRUE.
           IF W-CPF = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'CPF inv?lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF

	   |CALCULA E VERORIFICA DIGITO 1
	   INITIALIZE W-SOMA W-MULT W-RES
           MOVE 10 TO W-AUX
	   PERFORM VARYING W-IND FROM 1 BY 1 UNTIL W-IND > 9
	         COMPUTE W-MULT = W-CPF-T(W-IND) * W-AUX  
	         COMPUTE W-SOMA = W-SOMA + W-MULT
		 SUBTRACT 1 FROM W-AUX
           END-PERFORM

	   COMPUTE W-AUXVALOR = W-SOMA / 11
	   COMPUTE W-VALOR = W-AUXVALOR * 11
	   COMPUTE W-RES = W-SOMA - W-VALOR

	   IF W-RES = 0 OR W-RES = 1
	      IF W-CPF-T(10) <> 0
	         INITIALIZE CA-MESSAGE-LINK
	         MOVE 'CPF inv?lido.' TO CA-MESSAGE-1
	         PERFORM MOSTRA-MSG-ERRO
	         MOVE 4 TO W-ACCEPT-CONTROL
                 MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
	         SET VALIDACAO-OK TO FALSE
		 EXIT PARAGRAPH
              END-IF
	   ELSE
	      COMPUTE W-RES = 11 - W-RES
	      IF W-RES <> W-CPF-T(10)
	         INITIALIZE CA-MESSAGE-LINK
	         MOVE 'CPF inv?lido.' TO CA-MESSAGE-1
	         PERFORM MOSTRA-MSG-ERRO
	         MOVE 4 TO W-ACCEPT-CONTROL
                 MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
                 SET VALIDACAO-OK TO FALSE
		 EXIT PARAGRAPH
              END-IF
	   END-IF

	   |CALCULA E VERIFICA DIITO 2
	   INITIALIZE W-AUX W-SOMA W-MULT W-RES W-AUXVALOR

	   MOVE 11 TO W-AUX
           PERFORM VARYING W-IND FROM 1 BY 1 UNTIL W-IND > 9
	         MULTIPLY W-CPF-T(W-IND) BY W-AUX GIVING W-MULT
	         COMPUTE W-SOMA = W-SOMA + W-MULT
		 SUBTRACT 1 FROM W-AUX
           END-PERFORM
	    
	   COMPUTE W-MULT = W-CPF-T(10) * 2
           COMPUTE W-SOMA = W-SOMA + W-MULT

	   COMPUTE W-AUXVALOR = W-SOMA / 11
	   COMPUTE W-VALOR = W-AUXVALOR * 11
	   COMPUTE W-RES = W-SOMA - W-VALOR

	   IF W-RES = 0 OR W-RES = 1
	      IF W-CPF-T(11) <> 0
	         INITIALIZE CA-MESSAGE-LINK
	         MOVE 'CPF inv?lido.' TO CA-MESSAGE-1
	         PERFORM MOSTRA-MSG-ERRO
	         MOVE 4 TO W-ACCEPT-CONTROL
                 MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
	         SET VALIDACAO-OK TO FALSE
		 EXIT PARAGRAPH
              END-IF
	   ELSE
	      COMPUTE W-RES = 11 - W-RES
	      IF W-RES <> W-CPF-T(11)
	         INITIALIZE CA-MESSAGE-LINK
	         MOVE 'CPF inv?lido.' TO CA-MESSAGE-1
	         PERFORM MOSTRA-MSG-ERRO
	         MOVE 4 TO W-ACCEPT-CONTROL
                 MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
                 SET VALIDACAO-OK TO FALSE
		 EXIT PARAGRAPH
              END-IF
	   END-IF.

      
       VALIDA-NOME.

           SET VALIDACAO-OK TO TRUE.
           IF A-NOME = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Nome inv?lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-END.

           SET VALIDACAO-OK TO TRUE.
           IF A-END = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Endere?o inv?lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 6 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-TEL.

           SET VALIDACAO-OK TO TRUE.
           IF W-TEL = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Telefone inv?lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 8 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-DES.

           SET VALIDACAO-OK TO TRUE.
           IF A-DES = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Desconto inv?lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 20 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.
      
      
      
      
       EXCLUIR.

           INITIALIZE             CLI-REG-1.
           MOVE W-CPF TO CLI-CPF
           READ CCLIENTE
           IF ST-CLI = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cliente n?o cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VAL-CLI
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE BIL-CLI
           START CBILHETE KEY >= BIL-RK-1
	   PERFORM UNTIL NOT VAL-BIL
             READ CBILHETE NEXT AT END
                             EXIT PERFORM
             END-READ
             IF NOT VAL-BIL
                PERFORM ERRO-ARQUIVO
             END-IF
             IF W-CPF = BIL-CLI 
	        INITIALIZE CA-MESSAGE-LINK
          MOVE 'Cliente n?o pode ser exclu?da pois possui movimenta??o.' 
		TO CA-MESSAGE-1
                PERFORM MOSTRA-MSG-MENSAGEM
                EXIT PARAGRAPH
             END-IF
           END-PERFORM.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o cliente' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
	       ACCEPT W-DATASIS FROM CENTURY-DATE
               MOVE W-DATASIS  TO W-DATAUXI
               COMPUTE W-DATASIS =      W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000

	       ACCEPT W-HORA FROM TIME
	       INITIALIZE LOG-REG-1
	       MOVE W-HORA TO LOG-HORA
	       MOVE W-DATASIS TO LOG-DIA
	       READ CLOG
	       IF ST-LOG = '23'
	          INITIALIZE LOG-REG-1
	          MOVE W-HORA TO LOG-HORA
	          MOVE W-DATASIS TO LOG-DIA
	       ELSE
	           IF NOT VAL-LOG
                        PERFORM ERRO-ARQUIVO
	           END-IF
	       END-IF

               MOVE W-LOGIN-LC TO LOG-USU
	       MOVE 3 TO LOG-TIPO
	       MOVE A-NOME TO LOG-REG
	       MOVE 'CLIENTE.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC
	       WRITE LOG-REG-1 
              DELETE CCLIENTE
              IF NOT VAL-CLI
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cliente exclu?do.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE W-CAMPOS
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


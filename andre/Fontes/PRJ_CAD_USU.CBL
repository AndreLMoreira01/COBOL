       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-CAD-USU.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       COPY "PRJ_USU.SL".
       COPY "PRJ_LOG.SL".
       
       
       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_USU.FD".
       COPY "PRJ_LOG.FD".

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  W-CAMPOS.
           03  ST-USU                PIC  X(02).
               88 VAL-USU            VALUE '00' THRU '09'.
	   03  ST-LOG                PIC  X(02).
               88 VAL-LOG            VALUE '00' THRU '09'.

	   03 CAMPOS-TELA.
	       05 W-LOGIN       PIC  X(10) VALUE SPACES.
	       05 W-SENHA       PIC  X(8)  VALUE SPACES.
	       05 W-NOME	PIC  X(60) VALUE SPACES.
	       05 W-TIPO 	PIC  9(2)  VALUE 0.
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

       77  W-LOGIN-L            PIC X(10).
       77  W-TIPO-L		PIC 9(02).

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "Login:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-LOGIN
                          LINE 02
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-LOGIN.
          
	   03 LABEL       LINE 04 COL 05
                          TITLE "Senha:"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-SENHA
                          LINE 04
                          COL 15
                          3-D
                          BOXED
                          AUTO
			  SECURE
                          ID 4
                          FONT SMALL-FONT
                          AFTER PROCEDURE PROC-SENHA.

           03 LABEL       LINE 06 COL 05
                          TITLE "Nome:"
                          ID 7
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOME
                          LINE 06
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-NOME.

          03 FRAME     LINE 08
                       COL 04
                       LINES 8
                       SIZE 22
                       TITLE "Tipo"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "Vendedor"
                       LINE 10
                       COL 5
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-TIPO
                       ID 9
                       FONT SMALL-FONT
                       NOTIFY.

           03 GER RADIO-BUTTON
                       TITLE "Gerente"
                       LINE 12
                       COL 5
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-TIPO
                       ID 10
                       FONT SMALL-FONT
                       NOTIFY.
		    
           03 ADM RADIO-BUTTON
                       TITLE "Administrador"
                       LINE 14
                       COL 5
                       GROUP 1
                       GROUP-VALUE 3
                       USING W-TIPO
                       ID 11
                       FONT SMALL-FONT
                       NOTIFY.

	   
           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 18 
                          COL 05
                          SIZE 12
                          ID 12
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 18
                          COL 20
                          SIZE 12
                          ID 13
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 18
                          COL 35
                          SIZE 12
                          SELF-ACT
                          ID 14
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING W-LOGIN-L.
       INICIO.
           
	 OPEN I-O CUSUARIO
           IF ST-USU = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CUSUARIO
              CLOSE CUSUARIO
              OPEN I-O CUSUARIO.
           IF NOT VAL-USU
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
                           SIZE 120 LINES 20
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Cadastro de usuarios"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PROGRAMA.

           DISPLAY TELA-PRINCIPAL.

	   IF W-TIPO-L = 2
	      MODIFY ADM, ENABLED = FALSE
	      MODIFY GER, ENABLED = FALSE
	   END-IF

	   PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXC
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE CUSUARIO.

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

       PROC-LOGIN.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

	   PERFORM VALIDA-LOGIN.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

           INITIALIZE      USU-REG-1 
	   MOVE W-LOGIN TO USU-LOGIN

           READ CUSUARIO
           IF ST-USU = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Bloqueado por outro usu�rio.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF (NOT VAL-USU) AND (ST-USU <> '23')
              PERFORM ERRO-ARQUIVO.

           MOVE USU-SENHA TO W-SENHA
           MOVE USU-TIPO TO W-TIPO
           MOVE USU-NOME TO W-NOME
           

           DISPLAY TELA-PRINCIPAL.

       PROC-SENHA.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
	

	   PERFORM VALIDA-SENHA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       PROC-NOME.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

	   PERFORM VALIDA-NOME.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.


       GRAVAR.
           PERFORM VALIDA-LOGIN.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

           PERFORM VALIDA-SENHA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-NOME.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-TIPO.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   INITIALIZE      USU-REG-1
	   
           MOVE W-LOGIN TO USU-LOGIN
           READ CUSUARIO
           IF ST-USU = '23'
                INITIALIZE   USU-REG-1
                MOVE W-LOGIN TO USU-LOGIN
           ELSE
                IF NOT VAL-USU
                    PERFORM ERRO-ARQUIVO.

	   MOVE W-SENHA TO USU-SENHA
           MOVE W-TIPO TO USU-TIPO
           MOVE W-NOME TO USU-NOME

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

               MOVE W-LOGIN-L TO LOG-USU
               MOVE W-LOGIN TO LOG-REG
	       MOVE 'USUARIO.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC

           IF ST-USU = '23'
	       MOVE 1 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
              WRITE USU-REG-1
              MOVE 'Usuario gravado.' TO CA-MESSAGE-1
           ELSE
	       MOVE 2 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
              REWRITE USU-REG-1
              MOVE 'Usuario regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VAL-USU
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       VALIDA-LOGIN.

           SET VALIDACAO-OK TO TRUE.
           IF W-LOGIN = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Login inv�lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-SENHA.

           SET VALIDACAO-OK TO TRUE.
           IF W-SENHA = SPACES 
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Senha inv�lida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-NOME.

           SET VALIDACAO-OK TO TRUE.
           IF W-NOME = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Nome inv�lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 8 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-TIPO.

           SET VALIDACAO-OK TO TRUE.
           IF W-TIPO = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tipo inv�lido inv�lido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 9 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.
	 
      
       EXCLUIR.

           INITIALIZE             USU-REG-1.
           MOVE W-LOGIN TO USU-LOGIN
           READ CUSUARIO
           IF ST-USU = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Usuario n�o cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VAL-USU
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o usuario' TO CA-MESSAGE-1
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

               MOVE W-LOGIN-L TO LOG-USU
	       MOVE 3 TO LOG-TIPO
	       MOVE W-LOGIN TO LOG-REG
	       MOVE 'USUARIO.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC
	       WRITE LOG-REG-1 
              DELETE CUSUARIO
              IF NOT VAL-USU
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Usuario exclu�do.' TO CA-MESSAGE-1
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


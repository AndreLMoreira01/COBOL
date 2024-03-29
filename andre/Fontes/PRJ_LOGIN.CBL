       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-LOGIN.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       COPY "PRJ_USU.SL".

       
       
       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_USU.FD".

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-LOGAR                VALUE 02.


       01  W-CAMPOS.
           03  ST-USU                PIC  X(02).
               88 VAL-USU            VALUE '00' THRU '09'.

	   03 CAMPOS-TELA.
	       05 W-LOGIN            PIC  X(10) VALUE SPACES.
	       05 W-SENHA            PIC  X(8)  VALUE SPACES.
	       05 W-SENHA-EDIT       PIC  ********.
               05 FILLER                  PIC  X(01) VALUE ' '.
                  88 LOGIN-EXISTE         VALUE 'S' FALSE ' '.



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

           03 ENTRY-FIELD USING  W-SENHA
                          LINE 04
                          COL 15
                          3-D
                          BOXED
                          AUTO
			  SECURE
                          ID 4
                          FONT SMALL-FONT.
			  
           

	   
           03 PUSH-BUTTON TITLE "&Logar"
                          LINE 06 
                          COL 05
                          SIZE 12
                          ID 5
                          EXCEPTION-VALUE EXCEPTION-LOGAR.

          

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 06
                          COL 20
                          SIZE 12
                          SELF-ACT
                          ID 6
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.
           
	   

	   ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 80 LINES 10
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Login"
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
           CLOSE CUSUARIO.

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXC.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-LOGAR
                  PERFORM LOGAR
           END-EVALUATE.

       PROC-LOGIN.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

	   PERFORM VALIDA-LOGIN.

       
       


       LOGAR.
           
	   PERFORM ABRIR-ARQUIVO

	   INITIALIZE      USU-REG-1
	   
           MOVE W-LOGIN TO USU-LOGIN
           READ CUSUARIO
            IF ST-USU = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Bloqueado por outro usu�rio.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF (NOT VAL-USU)
	      CLOSE CUSUARIO
              PERFORM ERRO-ARQUIVO
	   END-IF
	   IF USU-SENHA = W-SENHA
	       CLOSE CUSUARIO
               CALL "PRJ_MENU" USING USU-TIPO, W-LOGIN
	            ON OVERFLOW  MOVE 'Programa n�o encontrado.' 
		            TO CA-MESSAGE-1
                            PERFORM MOSTRA-MSG-ERRO
	            NOT OVERFLOW
	                   CANCEL "PRJ_MENU"
	       END-CALL
	   ELSE
	        MOVE 'Senha incorreta.' TO CA-MESSAGE-1
                PERFORM MOSTRA-MSG-ERRO
		MOVE 4 TO W-ACCEPT-CONTROL
                MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor

           END-IF

	   CLOSE CUSUARIO.

          
       VALIDA-LOGIN.

           SET LOGIN-EXISTE TO TRUE.
           
	   PERFORM ABRIR-ARQUIVO

           INITIALIZE      USU-REG-1
	   
           MOVE W-LOGIN TO USU-LOGIN
           READ CUSUARIO
           IF ST-USU = '23'
	       INITIALIZE CA-MESSAGE-LINK
               MOVE 'Login Inv�lido.' TO CA-MESSAGE-1
               PERFORM MOSTRA-MSG-ERRO
               MOVE 4 TO W-ACCEPT-CONTROL
               MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
               SET LOGIN-EXISTE TO FALSE
	       CLOSE CUSUARIO
	       EXIT PARAGRAPH
	   END-IF

	   IF NOT VAL-USU 
	      PERFORM ERRO-ARQUIVO     
           END-IF

	   CLOSE CUSUARIO.


       ABRIR-ARQUIVO
           OPEN I-O CUSUARIO
           IF ST-USU = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CUSUARIO
              CLOSE CUSUARIO
              OPEN I-O CUSUARIO.
           IF NOT VAL-USU
              PERFORM ERRO-ARQUIVO.
	
       
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


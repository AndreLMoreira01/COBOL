       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-REL.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.



       
       
       DATA DIVISION.
       FILE SECTION.



       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-LOGS                 VALUE 02.
       78  EXCEPTION-CIDADE               VALUE 03.
       78  EXCEPTION-VENDA                VALUE 04.



	 

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

       77  W-TIPO-L		PIC 9(02).
       77  W-LOGIN-L            PIC X(10).              

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           
           03 LOGS PUSH-BUTTON TITLE "Logs"
                          LINE 04
                          COL 05
                          SIZE 20
                          ID 1
                          EXCEPTION-VALUE EXCEPTION-LOGS.      
	   
	   
	   
	   
	   03 CIDADE PUSH-BUTTON TITLE "Cidades"
                          LINE 02
                          COL 40
                          SIZE 20
                          ID 2
                          EXCEPTION-VALUE EXCEPTION-CIDADE.


	   03 VENDA PUSH-BUTTON TITLE "Vendas"
                          LINE 02
                          COL 05
                          SIZE 20
                          ID 4
                          EXCEPTION-VALUE EXCEPTION-VENDA.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 04
                          COL 40
                          SIZE 20
                          SELF-ACT
                          ID 9
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING W-TIPO-L, W-LOGIN-L.
       INICIO.
           
	 

	   ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 80 LINES 8
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Opções de relatórios"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PROGRAMA.

          
	      

           DISPLAY TELA-PRINCIPAL.

	   IF W-TIPO-L = 2
	       MODIFY LOGS, VISIBLE = FALSE
	   END-IF

	   IF W-TIPO-L = 1
	       MODIFY LOGS, VISIBLE = FALSE
	       MODIFY CIDADE, VISIBLE = FALSE
	   END-IF

	   PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXC
              END-ACCEPT
           END-PERFORM.

       FIM.
          

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXC.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH
	   END-IF.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-LOGS
                  PERFORM LOGS
             WHEN EXCEPTION-CIDADE
                  PERFORM CIDADES
             WHEN EXCEPTION-VENDA
                  PERFORM VENDA
           END-EVALUATE.

       LOGS.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           CALL "PRJ_REL_LOG" USING W-LOGIN-L
	         ON OVERFLOW  MOVE 'Programa não encontrado.' 
		              TO CA-MESSAGE-1
                              PERFORM MOSTRA-MSG-MENSAGEM
	         NOT OVERFLOW
		              CANCEL "PRJ_REL_LOG"

           END-CALL

           DISPLAY TELA-PRINCIPAL.
	 
       
       CIDADES.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           CALL "PRJ_REL_CID" 
	         ON OVERFLOW  MOVE 'Programa não encontrado.'
		              TO CA-MESSAGE-1
                              PERFORM MOSTRA-MSG-MENSAGEM
	         NOT OVERFLOW
		              CANCEL "PRJ_REL_CID"

           END-CALL

           DISPLAY TELA-PRINCIPAL.

       VENDA.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
           CALL "PRJ_REL_BIL" 
	         ON OVERFLOW  MOVE 'Programa não encontrado.'
		              TO CA-MESSAGE-1
                              PERFORM MOSTRA-MSG-MENSAGEM
	         NOT OVERFLOW
		              CANCEL "PRJ_REL_BIL"

           END-CALL
           

           DISPLAY TELA-PRINCIPAL.
       
       

       
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

       


        IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-CAD-FRO.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       COPY "PRJ_FRO.SL".
       COPY "PRJ_CID.SL".
       COPY "PRJ_BIL.SL".
       COPY "PRJ_LOG.SL".

       
       
       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_FRO.FD".
       COPY "PRJ_CID.FD".
       COPY "PRJ_BIL.FD".
       COPY "PRJ_LOG.FD".

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  W-CAMPOS.
           03  ST-FRO                PIC  X(02).
               88 VAL-FRO            VALUE '00' THRU '09'.

	   03  ST-CID                PIC  X(02).
               88 VAL-CID            VALUE '00' THRU '09'.

	   03  ST-BIL                PIC  X(02).
               88 VAL-BIL            VALUE '00' THRU '09'.

	   03  ST-LOG                PIC  X(02).
               88 VAL-LOG            VALUE '00' THRU '09'.

	   03 CAMPOS-TELA.
	       05 W-ID		PIC 9(03).
	       05 W-DESC        PIC X(60).
	       05 W-ID-ORI      PIC 9(03).
	       05 W-ID-DES      PIC 9(03).
	       05 W-NOME-ORI    PIC X(60).
	       05 W-NOME-DES    PIC X(60).
	       05 W-PRE-CON     PIC 9(5)V99.
               05 W-PRE-SUB     PIC 9(5)V99.
	       05 W-LOC-ORI     PIC 9(4).
	       05 W-LOC-DES     PIC 9(4).
	       05 W-DIS         PIC 9(4).
	       05 W-QTD         PIC 9(1).
	       
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

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "ID:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-ID
                          LINE 02
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-ID.

           03 ENTRY-FIELD USING W-DESC
                          LINE 02
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 16
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-DESC.
          
	   03 LABEL       LINE 04 COL 05
                          TITLE "Cidade Origem:"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-ID-ORI
                          LINE 04
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-ID-ORI.

	   03 ENTRY-FIELD FROM W-NOME-ORI
	                  COLOR 33024
                          LINE 04
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 5
                          FONT SMALL-FONT.

           03 LABEL       LINE 06 COL 05
                          TITLE "Cisdade Destino:"
                          ID 6
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-ID-DES
                          LINE 06
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 7
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-ID-DES.

           03 LABEL       LINE 08 COL 05
                          TITLE "Quantidade viagens"
                          ID 17
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-QTD
                          LINE 08
                          COL 25
                          3-D
                          BOXED
                          AUTO
                          ID 18
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-QTD.

	   03 ENTRY-FIELD FROM W-NOME-DES
	                  COLOR 33024
                          LINE 06
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT.


           03 LABEL       LINE 10 COL 05
                          TITLE "Preço concencional:"
                          ID 9
                          TRANSPARENT.

           03 ENTRY-FIELD FROM W-PRE-CON
	                  COLOR 33024
                          LINE 10
                          COL 35
                          3-D
                          BOXED
                          AUTO
                          ID 10
                          FONT SMALL-FONT.

	   03 LABEL       LINE 12 COL 05
                          TITLE "Preço suburbano:"
                          ID 11
                          TRANSPARENT.

           03 ENTRY-FIELD FROM W-PRE-SUB
	                  COLOR 33024
                          LINE 12
                          COL 35
                          3-D
                          BOXED
                          AUTO
                          ID 12
                          FONT SMALL-FONT.
	   
           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 14 
                          COL 05
                          SIZE 12
                          ID 13
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 14
                          COL 20
                          SIZE 12
                          ID 14
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 14
                          COL 35
                          SIZE 12
                          SELF-ACT
                          ID 15
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING W-LOGIN-L.
       INICIO.
           
	   OPEN I-O CFROTA
           IF ST-FRO = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CFROTA
              CLOSE CFROTA
              OPEN I-O CFROTA.
           IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO.

	   OPEN INPUT CCIDADE
           IF NOT VAL-CID
              PERFORM ERRO-ARQUIVO.

	   OPEN INPUT CBILHETE
	   IF ST-BIL = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CBILHETE
              CLOSE CBILHETE
              OPEN I-O CBILHETE.
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
                           TITLE "Cadastro de Frotas"
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
           CLOSE CFROTA CCIDADE.

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

       PROC-ID.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-ID.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF
         
           INITIALIZE      FRO-REG-1 
	   MOVE W-ID TO FRO-ID

           READ CFROTA
           IF ST-FRO = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Bloqueado por outro usuário.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF (NOT VAL-FRO) AND (ST-FRO <> '23')
              PERFORM ERRO-ARQUIVO.

           MOVE FRO-ORI TO W-ID-ORI
           MOVE FRO-DES TO W-ID-DES
           MOVE FRO-DESC TO W-DESC
	   MOVE FRO-CON  TO W-PRE-CON
	   MOVE FRO-SUB  TO W-PRE-SUB
	   MOVE FRO-QTD TO W-QTD
           IF ST-FRO <> '23'
	      PERFORM PROC-ID-ORI
	      PERFORM PROC-ID-DES
	   ELSE
	      INITIALIZE W-NOME-ORI W-NOME-DES
	   END-IF
           
           DISPLAY TELA-PRINCIPAL.
	 
       PROC-ID-ORI.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-ID-ORI.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

	  
		      

       PROC-ID-DES.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-ID-DES.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF



       PROC-DESC.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-DESC.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.

       PROC-QTD.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

           PERFORM VALIDA-QTD.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF.


       
       GRAVAR.
           PERFORM VALIDA-ID.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-ID-ORI.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-ID-DES.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-QTD.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   



	   INITIALIZE      FRO-REG-1
	 
           MOVE W-ID TO FRO-ID
           READ CFROTA
           IF ST-FRO = '23'
                INITIALIZE   FRO-REG-1
                MOVE W-ID TO FRO-ID
           ELSE
                IF NOT VAL-FRO
                    PERFORM ERRO-ARQUIVO.

	   MOVE W-ID-ORI TO FRO-ORI
           MOVE W-ID-DES TO FRO-DES
           MOVE W-DESC   TO FRO-DESC
	   MOVE W-PRE-SUB  TO FRO-SUB
	   MOVE W-PRE-CON  TO FRO-CON
	   MOVE W-QTD TO FRO-QTD

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
               MOVE W-DESC TO LOG-REG
	       MOVE 'FROTA.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC
           IF ST-FRO = '23'
	      
	       MOVE 1 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
               WRITE FRO-REG-1
               MOVE 'Frota gravada.' TO CA-MESSAGE-1
           ELSE
	       MOVE 2 TO LOG-TIPO
	      
	       WRITE LOG-REG-1
              REWRITE FRO-REG-1
              MOVE 'Frota regravada.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       VALIDA-ID.

           SET VALIDACAO-OK TO TRUE.
           IF W-ID = ZEROS
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'ID inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.
      
       VALIDA-ID-ORI.

           SET VALIDACAO-OK TO TRUE.
           IF W-ID-ORI = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cidade Inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF
    
	   INITIALIZE        CID-REG-1
           MOVE W-ID-ORI TO CID-ID
           READ CCIDADE
           IF ST-CID = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cidade não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 6 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF

           MOVE CID-LOC TO W-LOC-ORI

           IF NOT VAL-CID
              PERFORM ERRO-ARQUIVO
           END-IF
 
         

	   
	   MOVE CID-NOME TO W-NOME-ORI
	   DISPLAY TELA-PRINCIPAL.

       VALIDA-ID-DES.

           SET VALIDACAO-OK TO TRUE.
           IF W-ID-DES = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cidade Inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 7 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

	 
	   INITIALIZE        CID-REG-1
           MOVE W-ID-DES TO CID-ID
           READ CCIDADE
	   IF ST-CID = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cidade não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 7 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF

	   MOVE CID-LOC TO W-LOC-DES

	   IF W-ID-DES = W-ID-ORI OR W-LOC-ORI = W-LOC-DES 
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cidade destino igual a de origem.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 7 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
	      EXIT PARAGRAPH
           END-IF.

	   
           IF NOT VAL-CID
              PERFORM ERRO-ARQUIVO
           END-IF

	
          
	   MOVE CID-NOME TO W-NOME-DES

           

	   IF W-LOC-ORI > W-LOC-DES
	      COMPUTE W-DIS = W-LOC-ORI - W-LOC-DES
	      ELSE
	          COMPUTE W-DIS = W-LOC-DES - W-LOC-ORI
           END-IF

	   COMPUTE W-PRE-SUB = W-DIS * 0,15
           COMPUTE W-PRE-CON = W-DIS * 0,25

	   DISPLAY TELA-PRINCIPAL.
      
       VALIDA-DESC.

           SET VALIDACAO-OK TO TRUE.
           IF W-DESC = SPACES
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Descrição Inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 16 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

       VALIDA-QTD.

           SET VALIDACAO-OK TO TRUE.
           IF W-QTD <= 0 OR W-QTD > 3 
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Quantidade inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 18 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

    
      
       EXCLUIR.

           INITIALIZE             FRO-REG-1.
           MOVE W-ID TO FRO-ID
           READ CFROTA
           IF ST-FRO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VAL-FRO
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE BIL-FRO
           START CBILHETE KEY >= BIL-RK-1
	   PERFORM UNTIL NOT VAL-BIL
             READ CBILHETE NEXT AT END
                             EXIT PERFORM
             END-READ
             IF NOT VAL-BIL
                PERFORM ERRO-ARQUIVO
             END-IF
             IF W-ID = BIL-FRO 
	        INITIALIZE CA-MESSAGE-LINK
            MOVE 'Frota não pode ser excluída pois possui movimentação.' 
		TO CA-MESSAGE-1
                PERFORM MOSTRA-MSG-MENSAGEM
                EXIT PARAGRAPH
             END-IF
           END-PERFORM.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir a frota?' TO CA-MESSAGE-1
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
	       MOVE W-DESC TO LOG-REG
	       MOVE 'FROTA.ARQ' TO LOG-ARQ
               MOVE 0 TO LOG-DESC
	       MOVE 0 TO LOG-PERC
	       WRITE LOG-REG-1 
              DELETE CFROTA
              IF NOT VAL-FRO
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota excluída.' TO CA-MESSAGE-1
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

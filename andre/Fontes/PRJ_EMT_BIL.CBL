       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-EMT-BIL.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       COPY "PRJ_BIL.SL".
       COPY "PRJ_FRO.SL".
       COPY "PRJ_USU.SL".
       COPY "PRJ_CLI.SL".
       COPY "PRJ_LOG.SL".
       SELECT PRINTF ASSIGN TO PRINTER
              FILE STATUS IS ST-PRI.

       SELECT SORTER ASSIGN TO 'SORTER.ARQ'
                  FILE STATUS   IS ST-SOR.


       
       
       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_BIL.FD".
       COPY "PRJ_FRO.FD".
       COPY "PRJ_USU.FD".
       COPY "PRJ_CLI.FD".
       COPY "PRJ_LOG.FD".
       FD  PRINTF LABEL RECORD OMITTED.
 
       01  PRINTF-R                       PIC X(255).

       SD  SORTER.

       01  SORT-NMR                       PIC 9(16).

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-CONFIRMAR            VALUE 02.
       78  EXCEPTION-POLTRONA             VALUE 03.

       01  W-CAMPOS.
           03  ST-USU                PIC  X(02).
               88 VAL-USU            VALUE '00' THRU '09'.
	   03  ST-FRO                PIC  X(02).
               88 VAL-FRO            VALUE '00' THRU '09'.
	   03  ST-BIL                PIC  X(02).
               88 VAL-BIL            VALUE '00' THRU '09'.
	   03  ST-CLI                PIC  X(02).
               88 VAL-CLI            VALUE '00' THRU '09'.
	   03  ST-PRI                PIC  X(02).
               88 VAL-PRI            VALUE '00' THRU '09'.
	   03  ST-SOR                PIC  X(02).
               88 VAL-SOR            VALUE '00' THRU '09'.
	   03  ST-LOG                PIC  X(02).
               88 VAL-LOG            VALUE '00' THRU '09'.

	   03 CAMPOS-TELA.
	       05 W-FRO         PIC 9(03).
	       05 W-NOME-FRO    PIC X(60).
	       05 W-CLI         PIC 9(11).
	       05 W-CLI-EDIT    PIC 999.999.999.99 VALUE ZEROS.
	       05 W-DATASIS     PIC 99/99/9999.
	       05 W-DATA-EDIT   PIC 99/99/9999.
	       05 W-DATAUXI               PIC  9(08).
               05 REDEFINES W-DATAUXI.  
                  07 W-DIAAUXI            PIC  9(02).
                  07 W-MESAUXI            PIC  9(02).
                  07 W-ANOAUXI            PIC  9(04).
	       05 REDEFINES W-DATAUXI.  
                  07 W-ANOAUXI-I          PIC  9(04).
                  07 W-MESAUXI-I          PIC  9(02).
                  07 W-DIAAUXI-I          PIC  9(02).
	       05 W-DATAUXI-I             PIC  9(08).
	       05 W-DATAUXI-S             PIC 9(08).
               05 REDEFINES W-DATAUXI-S.  
                  07 W-DIAAUXIS           PIC  9(02).
                  07 W-MESAUXIS           PIC  9(02).
                  07 W-ANOAUXIS           PIC  9(04).
	       05 REDEFINES W-DATAUXI-S.  
                  07 W-ANOAUXIS-I            PIC  9(04).
                  07 W-MESAUXIS-I            PIC  9(02).
                  07 W-DIAAUXIS-I            PIC  9(02).
	       05 W-DATAUXI-S-I            PIC 9(08).
	       05 W-HORA                   PIC 9(08).
	       05 REDEFINES W-HORA.
                  07 W-HR                  PIC 9(02).
		  07 W-MIN                 PIC 9(02).
		  07 W-SEG                 PIC 9(02).
		  07 W-MM                  PIC 9(02).
	       05 W-AUX-LOG                PIC X(60).

	       05 W-VIA         PIC 9(1).
	       05 W-TIPO        PIC 9(2).
	       05 W-POL         PIC 9(2).
	       05 W-AUX-POL     PIC 9(2).
	       05 W-DESC        PIC 9(1) VALUE 0.
	       05 W-TOT         PIC 9(5)V99.
	       05 W-NMR         PIC 9(16).
	       05 W-PERC        PIC 9(2) VALUE 0.
	       05 W-TIPO-DESC   PIC 9(1).
	       05 W-CLI-NOME    PIC X(60).
	       05 W-CLI-END     PIC X(100).
	       05 W-CLI-TEL     PIC 9(10).
	       05 W-CLI-COM     PIC 9(4).
	       05 IND           PIC 9(2).
	       05 W-AUX-QTD     PIC 9(1).
	       05 W-NOME-USU    PIC X(10).
	       05 W-CLI-DESC    PIC 9(04).
	       05 W-HR-VEND     PIC 9(04).
	       05 W-USU         PIC X(10).
	       05 W-CONTFRO     PIC 9(5) VALUE 0.
	       05 LUGARES-S OCCURS 30 TIMES.
	           07 OCUPADO-S PIC 9(1) VALUE 0.
	       05 LUGARES-C OCCURS 30 TIMES.
	           07 OCUPADO-C PIC 9(1) VALUE 0.   
               05 FILLER                  PIC  X(01) VALUE ' '.
                  88 VALIDACAO-OK         VALUE 'S' FALSE ' '.
	       05 FILLER                  PIC  X(01) VALUE ' '.
                  88 POLTRONA-LIVRE       VALUE 'S' FALSE ' '.
	       05 W-CAB		PIC X(132).
	       05 W-LINHA-1.
	          07 FILLER    PIC X(12) VALUE 'N° BILHETE: '.
		  07 W-L1-NMR  PIC 9(16).
	       05 W-LINHA-2.
	          07 FILLER    PIC X(12) VALUE 'FROTA:      '.
		  07 W-L2-FRO  PIC X(60).
		  07 FILLER    PIC X(17) VALUE ' DATA DA VENDA:  '.
		  07 W-L2-DVEN PIC 99/99/9999B(4).
	       05 W-LINHA-3.
		  07 FILLER    PIC X(8) VALUE 'VIAGEM: '.
		  07 W-L3-VIA  PIC 9(1).
		  07 FILLER    PIC X(9) VALUE '   TIPO: '.
                  07 W-L3-TIPO PIC X(54).
		  07 FILLER    PIC X(17) VALUE ' DATA DA VIAGEM: '.
		  07 W-L3-DVIA PIC  99/99/9999B(4).
	        05 W-LINHA-4.
		  07 FILLER    PIC X(12) VALUE 'NOME:       '.
		  07 W-L4-CLI  PIC X(60).
		  07 FILLER    PIC X(5) VALUE ' CPF: '.
		  07 W-L4-CPF  PIC 999.999.999.99.
		05 W-LINHA-5.
		  07 FILLER    PIC X(5) VALUE 'POL :'.
		  07  W-L5-POL PIC 9(2).
		05 W-LINHA-6.
		  07 FILLER PIC X(12) VALUE 'VENDEDOR:   '.
		  07 W-L6-USU  PIC X(10).
		  07 FILLER PIC X(15) VALUE '   TOTAL:    R$'.
		  07 W-L6-TOT PIC BB99,99.
		  07 FILLER PIC X(29) VALUE ALL SPACES.
		  07 FILLER  PIC X(14) VALUE 'HORA DA VENDA:'.
		  07 W-L6-HR PIC 99.99.
		  



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
	   COPY "DATASW.CPY".

       LINKAGE SECTION.

       77  W-LOGIN-L            PIC X(10).  

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "Frota:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-FRO
                          LINE 02
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-FRO.

           03 ENTRY-FIELD FROM W-NOME-FRO
	                  COLOR 33024
                          LINE 02
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 16
                          FONT SMALL-FONT.
          
	   03 LABEL       LINE 04 COL 05
                          TITLE "Cliente:"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CLI-EDIT
                          LINE 04
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT
                          AFTER PROCEDURE PROC-CLI.

           03 LABEL       LINE 04 COL 35
                          TITLE "Data da viagem:"
                          ID 5
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATA-EDIT
                          LINE 04
                          COL 50
                          3-D
                          BOXED
                          AUTO
                          ID 6
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-DATA.

           03 LABEL       LINE 04 COL 62
                          TITLE "Data da venda:"
                          ID 5
                          TRANSPARENT.

           03 ENTRY-FIELD FROM W-DATASIS
	                  COLOR 33024
                          LINE 04
                          COL 77
                          3-D
                          BOXED
                          AUTO
                          ID 6
                          FONT SMALL-FONT.


           03 LABEL       LINE 06 COL 05
                          TITLE "N° da viagem:"
                          ID 7
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-VIA
                          LINE 06
                          COL 20
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT
			  AFTER PROCEDURE PROC-VIA.

           03 FRAME    LINE 08
                       COL 04
                       LINES 6
                       SIZE 22
                       TITLE "Tipo"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "Suburbano"
                       LINE 10
                       COL 5
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-TIPO
                       ID 9
                       FONT SMALL-FONT
                       NOTIFY
		       EXCEPTION PROCEDURE PROC-TIPO.

           03 RADIO-BUTTON
                       TITLE "Convencional"
                       LINE 12
                       COL 5
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-TIPO
                       ID 10
                       FONT SMALL-FONT
                       NOTIFY
		       EXCEPTION PROCEDURE PROC-TIPO.
           03 LABEL       LINE 08 COL 35
                          TITLE "Poltrona:"
                          ID 11
                          TRANSPARENT.

	   | CRIAR UM OUTRA FORMA DE ESCOLHER A POLTRONA, COMBO-BOX, LIST

           03 ENTRY-FIELD USING W-POL
	                  COLOR 33024 
                          LINE 08
                          COL 45
                          3-D
                          BOXED
                          AUTO
                          ID 12
                          FONT SMALL-FONT
                          AFTER PROCEDURE PROC-POL.

	   03 LABEL       LINE 08 COL 50
                          TITLE "Escolher poltrona:"
                          ID 21
                          TRANSPARENT.

           03 COMBO-POLTRONA COMBO-BOX
	                 USING W-AUX-POL
                         LINE 08 COL 68 SIZE 7 DROP-LIST UNSORTED
                         ID  20
                         FONT SMALL-FONT
                         EXCEPTION PROCEDURE PROC-POL
                         LINES 20  NOTIFY-SELCHANGE.

           03 LABEL       LINE 16 COL 05
                          TITLE "Total:"
                          ID 7
                          TRANSPARENT.

           03 ENTRY-FIELD FROM W-TOT
	                  COLOR 33024
                          LINE 16
                          COL 10
                          3-D
                          BOXED
                          AUTO
                          ID 8
                          FONT SMALL-FONT.
			  
           03 LABEL       LINE 16 COL 25
                          TITLE "N° do bilhete:"
                          ID 16
                          TRANSPARENT.

           03 ENTRY-FIELD FROM W-NMR
	                  COLOR 33024
                          LINE 16
                          COL 36
                          3-D
                          BOXED
                          AUTO
                          ID 17
                          FONT SMALL-FONT.

	   03 LABEL       LINE 16 COL 55
                          TITLE "Usuário:"
                          ID 18
                          TRANSPARENT.


	   03 ENTRY-FIELD FROM W-USU
	                  COLOR 33024
                          LINE 16
                          COL 62
                          3-D
			  SIZE 20
                          BOXED
                          AUTO
                          ID 17
                          FONT SMALL-FONT.
          
	   
           03 CONFIRMAR PUSH-BUTTON TITLE "&Confirmar"
                          LINE 18 
                          COL 05
                          SIZE 12
                          ID 18
                          EXCEPTION-VALUE EXCEPTION-CONFIRMAR.

           

           03 PUSH-BUTTON TITLE "&Cancelar"
                          LINE 18
                          COL 20
                          SIZE 12
                          SELF-ACT
                          ID 15
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING W-LOGIN-L.
       INICIO.
           
	   OPEN I-O CBILHETE
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

	   OPEN INPUT CFROTA
           IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO.

	    OPEN I-O CCLIENTE
           IF ST-CLI = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT CCLIENTE
              CLOSE CCLIENTE
              OPEN I-O CCLIENTE.

	   OPEN INPUT CUSUARIO
           IF NOT VAL-USU
              PERFORM ERRO-ARQUIVO.

	  
	   ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 130 LINES 20
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Emissão de bilhetes"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PROGRAMA.
	   INITIALIZE W-DESC

	   INITIALIZE USU-REG-1
	   MOVE W-LOGIN-L TO USU-LOGIN
	   READ CUSUARIO
	   IF ST-USU = '23'
                INITIALIZE   USU-REG-1
                MOVE W-LOGIN-L TO USU-LOGIN
           ELSE
                IF NOT VAL-USU
                    PERFORM ERRO-ARQUIVO.

           MOVE W-LOGIN-L TO W-USU

	   ACCEPT W-DATASIS FROM CENTURY-DATE
           MOVE W-DATASIS  TO W-DATAUXI
           COMPUTE W-DATASIS =      W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000


           DISPLAY TELA-PRINCIPAL.

	   PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXC
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE CUSUARIO CFROTA CBILHETE CCLIENTE.

           CLOSE WINDOW JANELA-PROGRAMA.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXC.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-CONFIRMAR
                  PERFORM CONFIRMAR
           END-EVALUATE.

       PROC-FRO.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

	   PERFORM VALIDA-FROTA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   INITIALIZE      BIL-REG-1
	   IF (W-VIA <> 0) AND (W-CLI <> 0) AND (W-DATA-CRIT <> 0) AND
	      (W-TIPO <> 0)
		   PERFORM BUSCA-DADOS
		   DISPLAY TELA-PRINCIPAL
           END-IF

	   

 
           PERFORM ATUALIZA-POLTRONA.


           

       PROC-CLI.
           IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
	   MOVE W-CLI-EDIT TO W-CLI

	   PERFORM VALIDA-CLIENTE.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   INITIALIZE      BIL-REG-1
	   IF (W-FRO <> 0) AND (W-VIA <> 0) AND (W-DATA-CRIT <> 0) AND
	      (W-TIPO <> 0)
		   PERFORM BUSCA-DADOS
		   DISPLAY TELA-PRINCIPAL
           END-IF

	  

	   PERFORM ATUALIZA-POLTRONA.

       PROC-DATA.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.

	   PERFORM VALIDA-DATA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   INITIALIZE      BIL-REG-1
	   IF (W-FRO <> 0) AND (W-CLI <> 0) AND (W-VIA <> 0) AND
	      (W-TIPO <> 0)
		   PERFORM BUSCA-DADOS
		   DISPLAY TELA-PRINCIPAL
           END-IF

	   


	   PERFORM ATUALIZA-POLTRONA.

       PROC-VIA.
            IF TECLOU-ESC OR SETA-CIMA OR OCORREU-EVENTO
              EXIT PARAGRAPH.
	  
	   PERFORM VALIDA-VIAGEM.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   INITIALIZE      BIL-REG-1
	   IF (W-FRO <> 0) AND (W-CLI <> 0) AND (W-DATA-CRIT <> 0) AND
	      (W-TIPO <> 0)
		   PERFORM BUSCA-DADOS
		   DISPLAY TELA-PRINCIPAL
           END-IF

	   

	   PERFORM ATUALIZA-POLTRONA.

       PROC-POL.
           IF OCORREU-EVENTO 
              
		

		   MOVE W-AUX-POL TO W-POL

		   DISPLAY TELA-PRINCIPAL.
		

       PROC-TIPO.

           PERFORM VALIDA-TIPO.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF
           
	   INITIALIZE  FRO-REG-1
           MOVE W-FRO TO FRO-ID
           READ CFROTA
           IF ST-FRO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF

	   IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO
           END-IF

	   INITIALIZE      BIL-REG-1
	   IF (W-FRO <> 0) AND (W-CLI <> 0) AND (W-DATA-CRIT <> 0) AND
	      (W-VIA <> 0)
		   PERFORM BUSCA-DADOS
		   DISPLAY TELA-PRINCIPAL
           END-IF

	   
           PERFORM ATUALIZA-POLTRONA.
       
       BUSCA-DADOS.

           MOVE W-FRO TO BIL-FRO
	   MOVE W-CLI TO BIL-CLI
	   MOVE W-DATA-CRIT TO BIL-DATA
	   MOVE W-VIA TO BIL-VIA
	   MOVE W-TIPO TO BIL-TIPO
	   READ CBILHETE
	   IF ST-BIL = '99'
	      INITIALIZE CA-MESSAGE-LINK
	      MOVE 'Bloqueado por outro usuário.' 
	      TO CA-MESSAGE-1
	      PERFORM MOSTRA-MSG-ATENCAO
	      EXIT PARAGRAPH
	   END-IF
	   IF (NOT VAL-BIL) AND (ST-BIL <> '23')
	      PERFORM ERRO-ARQUIVO
	   END-IF

	   MOVE BIL-POL TO W-POL
	   MOVE BIL-TIPO TO W-TIPO	   
	   MOVE BIL-NMR TO W-NMR
	   MOVE BIL-TOT TO W-TOT
	   MOVE BIL-DESC TO W-DESC
	   MOVE BIL-PERC TO W-PERC
	   IF W-DESC <> 1
		 PERFORM ATUALIZA-TOTAL
	   END-IF.

       CONFIRMAR.
           PERFORM VALIDA-FROTA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

           PERFORM VALIDA-CLIENTE.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-DATA.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-VIAGEM.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-TIPO.
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF

	   PERFORM VALIDA-POLTRONA.
	   IF NOT POLTRONA-LIVRE
	      SET VALIDACAO-OK TO FALSE
	   END-IF
           IF NOT VALIDACAO-OK
              EXIT PARAGRAPH
	   END-IF
	   
           
	   DISPLAY TELA-PRINCIPAL.

	   INITIALIZE      BIL-REG-1
           MOVE W-FRO TO BIL-FRO
	   MOVE W-CLI TO BIL-CLI
	   MOVE W-DATA-CRIT TO BIL-DATA
	   MOVE W-VIA TO BIL-VIA
	   MOVE W-TIPO TO BIL-TIPO
           READ CBILHETE |LE O ARQUIVO APENAS PARA QUE SE ELE NÃO EXISTIR, ORDENA OS NMR DE BILHETES PARA ACRESCENTAR MAIS UM 
           IF ST-BIL = '23'
	       INITIALIZE W-DESC W-PERC
	       INITIALIZE      BIL-REG-1
	       START CBILHETE KEY >= BIL-RK-1
               SORT SORTER ASCENDING KEY SORT-NMR
               INPUT  PROCEDURE CARREGA
               OUTPUT PROCEDURE PEGAULTIMO
	       

               COMPUTE W-NMR = W-NMR + 1

	       DISPLAY TELA-PRINCIPAL

	       INITIALIZE      BIL-REG-1

               MOVE W-FRO TO BIL-FRO
	       MOVE W-CLI TO BIL-CLI
	       MOVE W-DATA-CRIT TO BIL-DATA
	       MOVE W-VIA TO BIL-VIA
	       MOVE W-TIPO TO BIL-TIPO
	       READ CBILHETE
	       
	       PERFORM ATUALIZA-TOTAL
           ELSE
                IF NOT VAL-BIL
                    PERFORM ERRO-ARQUIVO.
           
            
	   MOVE W-POL TO BIL-POL	   
	   MOVE W-NMR TO BIL-NMR

           IF ST-BIL = '23'
           |VERIFICA SE O CLIENTE PODE RECEBER DESCONTO SE FOR UM NOVO BILHETE
		   INITIALIZE CLI-REG-1
		   MOVE W-CLI TO CLI-CPF
		   READ CCLIENTE
		   IF ST-CLI = '23'
			INITIALIZE   CLI-REG-1
			MOVE W-CLI TO CLI-CPF
		   ELSE
			IF NOT VAL-CLI
			    PERFORM ERRO-ARQUIVO
			END-IF
		   END-IF
		   MOVE CLI-NOME TO W-CLI-NOME
		   MOVE CLI-END TO W-CLI-END
		   MOVE CLI-TEL TO W-CLI-TEL
		   MOVE CLI-COM TO W-CLI-COM
		   MOVE CLI-DESC TO W-CLI-DESC
		   INITIALIZE W-DESC W-PERC
		   EVALUATE TRUE
		     WHEN (W-CLI-COM = W-CLI-DESC)
			  MOVE 1 TO W-TIPO-DESC
			  PERFORM PERGUNTA-DESCONTO
		     WHEN (W-CLI-COM = W-CLI-DESC * 2)
			  MOVE 2 TO W-TIPO-DESC
			  PERFORM PERGUNTA-DESCONTO
		     WHEN (W-CLI-COM = W-CLI-DESC * 3)
			  MOVE 3 TO W-TIPO-DESC
			  PERFORM PERGUNTA-DESCONTO
	             WHEN (W-CLI-COM = W-CLI-DESC * 4)
			  MOVE 4 TO W-TIPO-DESC
			  PERFORM PERGUNTA-DESCONTO
		     WHEN (W-CLI-COM = W-CLI-DESC * 5)
			  MOVE 5 TO W-TIPO-DESC
			  PERFORM PERGUNTA-DESCONTO		       
		   END-EVALUATE

		   

		   IF W-DESC = 1
		     EVALUATE W-PERC
		       WHEN 1
			  COMPUTE W-TOT = W-TOT * 0,95
		       WHEN 2
			  COMPUTE W-TOT = W-TOT * 0,9
		       WHEN 3
			  COMPUTE W-TOT = W-TOT * 0,85
		       WHEN 4
			  COMPUTE W-TOT = W-TOT * 0,75
		       WHEN 5
			  COMPUTE W-TOT = W-TOT * 0,5
		     END-EVALUATE
		     DISPLAY TELA-PRINCIPAL
		   END-IF
           END-IF
          
	   MOVE W-TOT TO BIL-TOT |PRECISO FAZER TODA A VEZ, INDEPENDENTE SE É NOVO OU NÃO
	   MOVE W-DESC TO BIL-DESC
	   MOVE W-PERC TO BIL-PERC

	   INITIALIZE CA-MESSAGE-LINK

           IF ST-BIL = '23' | SE FOR NOVO, SALVA AS INFORMAÇÕES DO CLIENTE E O BILHETE TAMBÉM 
	       
               COMPUTE W-CLI-COM = W-CLI-COM + 1
	       MOVE W-CLI-NOME TO CLI-NOME
	       MOVE W-CLI-END TO CLI-END
	       MOVE W-CLI-TEL TO CLI-TEL
	       MOVE W-CLI-COM TO CLI-COM
	       MOVE W-CLI-DESC TO CLI-DESC
	       ACCEPT W-DATASIS FROM CENTURY-DATE
               MOVE W-DATASIS  TO W-DATAUXI
               COMPUTE W-DATASIS =      W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000

	       MOVE W-DATASIS TO BIL-DT-VENDA
	       ACCEPT W-HORA FROM TIME
	       MOVE W-HORA TO BIL-HORA
	       MOVE W-LOGIN-L TO BIL-USU
	       MOVE W-CLI-NOME TO BIL-NOME
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
	       MOVE 1 TO LOG-TIPO
	       MOVE W-NOME-FRO TO LOG-REG
	       MOVE 'BILHETE.AQR' TO LOG-ARQ
               MOVE W-DESC TO LOG-DESC
	       MOVE W-PERC TO LOG-PERC

                WRITE LOG-REG-1
         	REWRITE CLI-REG-1
                WRITE BIL-REG-1
	      
               MOVE 'Registro gravado.' TO CA-MESSAGE-1
               PERFORM MOSTRA-MSG-MENSAGEM
	       IF W-TIPO = 1
	          MOVE 1 TO OCUPADO-S(W-POL)
	       ELSE
	          MOVE 1 TO OCUPADO-C(W-POL)
	       END-IF
	       INITIALIZE CA-MESSAGE-LINK
              MOVE 'Emitir bilhete?' TO CA-MESSAGE-1
              MOVE 2 TO CA-MESSAGE-TYPE
              MOVE 22 TO CA-MESSAGE-RESP
              CALL 'CAMESSAG'
              CANCEL 'CAMESSAG'
              IF CA-MESSAGE-RESP = 1
                 PERFORM EMITIR-BILHETE
	      END-IF

           ELSE
              MOVE 'Não é permitida alteração nesse registro.' 
	      TO CA-MESSAGE-1
	      PERFORM MOSTRA-MSG-MENSAGEM
	      MOVE BIL-POL TO W-POL
	      DISPLAY TELA-PRINCIPAL
           END-IF
           

	   
           IF NOT VAL-BIL
              PERFORM ERRO-ARQUIVO.

       ATUALIZA-POLTRONA.
           INITIALIZE BIL-REG-1
	   MOVE W-FRO TO BIL-FRO
	   MOVE W-DATA-CRIT TO BIL-DATA
	   MOVE W-VIA TO BIL-VIA
	   MOVE W-TIPO TO BIL-TIPO
           START CBILHETE KEY >= BIL-RK-1
	   PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
	        MOVE 0 TO OCUPADO-S(IND)
		MOVE 0 TO OCUPADO-C(IND)
           END-PERFORM
	   MODIFY COMBO-POLTRONA , RESET-LIST = 1
	   IF W-TIPO = 1
		   PERFORM UNTIL NOT VAL-BIL
		      READ CBILHETE NEXT AT END
				       EXIT PERFORM
		      END-READ
		      IF (W-FRO = BIL-FRO) AND (W-DATA-CRIT = BIL-DATA)
		         AND (W-VIA = BIL-VIA) AND (BIL-TIPO = 1)
		         PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
			   IF BIL-POL = IND 
				   MOVE 1 TO OCUPADO-S(IND)
			   END-IF
		         END-PERFORM
		      END-IF
		   END-PERFORM
		   PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
	               IF OCUPADO-S(IND) = 0
		            MODIFY COMBO-POLTRONA
                            ITEM-TO-ADD = IND
		       END-IF
                   END-PERFORM
           END-IF
	   IF W-TIPO = 2
		   PERFORM UNTIL NOT VAL-BIL
		      READ CBILHETE NEXT AT END
				       EXIT PERFORM
		      END-READ
		      IF (W-FRO = BIL-FRO) AND (W-DATA-CRIT = BIL-DATA)
		         AND (W-VIA = BIL-VIA) AND (BIL-TIPO = 2)
		         PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
			  IF BIL-POL = IND
				   MOVE 1 TO OCUPADO-C(IND)
			   END-IF
		         END-PERFORM
		      END-IF
		   END-PERFORM
		   PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
	               IF OCUPADO-C(IND) = 0
		            MODIFY COMBO-POLTRONA
                            ITEM-TO-ADD = IND
		       END-IF
                   END-PERFORM
           END-IF

	   

      

       VERIFICA-POLTRONA.
           SET POLTRONA-LIVRE TO TRUE.
           IF W-TIPO = 1
              PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
	           IF W-POL = IND
		       IF OCUPADO-S(IND) = 1
		          INITIALIZE CA-MESSAGE-LINK
                          MOVE 'Poltrona ocupada.' TO CA-MESSAGE-1
                          PERFORM MOSTRA-MSG-ERRO
                          MOVE 4 TO W-ACCEPT-CONTROL
                          MOVE 12 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
			  SET POLTRONA-LIVRE TO FALSE
		       END-IF
		   END-IF
	      END-PERFORM
	   ELSE
	      PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 30
	           IF W-POL = IND
		       IF OCUPADO-C(IND) = 1
		          INITIALIZE CA-MESSAGE-LINK
                          MOVE 'Poltrona ocupada.' TO CA-MESSAGE-1
                          PERFORM MOSTRA-MSG-ERRO
                          MOVE 4 TO W-ACCEPT-CONTROL
                          MOVE 12 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
			  SET POLTRONA-LIVRE TO FALSE
		       END-IF
		   END-IF
	      END-PERFORM
	   END-IF
              
           
       CARREGA.
           PERFORM UNTIL NOT VAL-BIL|CARREGA E ORDENA O SORTER
                   READ CBILHETE NEXT AT END
                               EXIT PERFORM
                   END-READ
		   INITIALIZE      SORT-NMR
                   MOVE BIL-NMR TO SORT-NMR
		   RELEASE SORT-NMR
	   END-PERFORM.

       PEGAULTIMO.
           PERFORM UNTIL 1 = 2|PEGA O ÚLTIMO NMR DE BILHETE
                   RETURN SORTER AT END
                            EXIT PERFORM
                   END-RETURN
		   MOVE SORT-NMR TO W-NMR
	   END-PERFORM.

       VALIDA-FROTA. 

           SET VALIDACAO-OK TO TRUE.
           IF W-FRO = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

	   INITIALIZE  FRO-REG-1
           MOVE W-FRO TO FRO-ID
           READ CFROTA
           IF ST-FRO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF.

	   IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO
           END-IF

	   MOVE FRO-DESC TO W-NOME-FRO
	   DISPLAY TELA-PRINCIPAL.

       VALIDA-CLIENTE.|FALTA VER JEITO CERTO DE VALIDAR CPF

           SET VALIDACAO-OK TO TRUE.
           IF W-CLI = 0 
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cliente inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF

	   INITIALIZE  CLI-REG-1
           MOVE W-CLI TO CLI-CPF
	   READ CCLIENTE
           IF ST-CLI = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Cliente não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 4 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF

	   IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO
           END-IF.

	   


       VALIDA-DATA.

           SET VALIDACAO-OK TO TRUE.
	   MOVE W-DATA-EDIT TO W-DATA-CRIT
                     PERFORM CRITICA-DATA
		     MOVE W-DATA-CRIT TO W-DATAUXI
                     COMPUTE W-DATAUXI-I = W-ANOAUXI * 10000 +
                                           W-MESAUXI * 100 +
                                           W-DIAAUXI
		     MOVE W-DATASIS TO W-DATAUXI-S
                     COMPUTE W-DATAUXI-S-I = W-ANOAUXIS * 10000 +
                                           W-MESAUXIS * 100 +
                                           W-DIAAUXIS

                     IF (NOT DATA-OK) OR (W-DATAUXI-I < W-DATAUXI-S-I)
                        INITIALIZE CA-MESSAGE-LINK
                        MOVE 'Data inválida.' TO CA-MESSAGE-1
                        PERFORM MOSTRA-MSG-ERRO
			MOVE 4 TO W-ACCEPT-CONTROL
                        MOVE 6 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
                        SET VALIDACAO-OK TO FALSE
                        EXIT PARAGRAPH
                        
                     END-IF.

       VALIDA-VIAGEM.

           SET VALIDACAO-OK TO TRUE.

	   INITIALIZE  FRO-REG-1
           MOVE W-FRO TO FRO-ID
           READ CFROTA
	   IF ST-FRO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Frota não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
              EXIT PARAGRAPH
           END-IF.

	   IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO
           END-IF

	   MOVE FRO-QTD TO W-AUX-QTD
           IF W-VIA > W-AUX-QTD OR W-VIA <= 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'N° da viagem inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 8 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.

	   

       VALIDA-POLTRONA.

           SET VALIDACAO-OK TO TRUE.
           IF W-POL <= 0 OR > 30
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Poltrona inválida.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 20 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF

	   PERFORM VERIFICA-POLTRONA.

       VALIDA-TIPO.

           SET VALIDACAO-OK TO TRUE.
           IF W-TIPO = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Tipo inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 9 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              SET VALIDACAO-OK TO FALSE
           END-IF.
       ATUALIZA-TOTAL.

           IF W-TIPO = 1
	       MOVE FRO-SUB TO W-TOT
           END-IF
	   IF W-TIPO = 2
	       MOVE FRO-CON TO W-TOT
	   END-IF
	   

	   DISPLAY TELA-PRINCIPAL.
	 
       PERGUNTA-DESCONTO.
           INITIALIZE CA-MESSAGE-LINK
           MOVE 'Deseja dar desconto para o cliente?' TO CA-MESSAGE-1
           MOVE 2 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              CALL "PRJ_DESC" USING W-DESC, W-PERC, W-TIPO-DESC
	         ON OVERFLOW  MOVE 'Programa não encontrado.'
		              TO CA-MESSAGE-1
                              PERFORM MOSTRA-MSG-MENSAGEM
	         NOT OVERFLOW
		              CANCEL "PRJ_DESC"

              END-CALL
	   END-IF
	   IF CA-MESSAGE-RESP = 2
	        EXIT PARAGRAPH
	   END-IF.
       EMITIR-BILHETE.
           INITIALIZE W-CAB W-LINHA-1 W-LINHA-2 W-LINHA-3 W-LINHA-4
	              W-LINHA-5 W-LINHA-6
	   OPEN OUTPUT PRINTF
	   MOVE ALL SPACES TO PRINTF-R
	   MOVE ALL '-' TO PRINTF-R(1:132)
	   WRITE PRINTF-R AFTER 0
	   MOVE ALL SPACES TO PRINTF-R
	   MOVE 'EMISSÃO BILHETES DE TRANSPORTES' TO W-CAB
	   WRITE PRINTF-R FROM W-CAB AFTER 1
	   MOVE ALL SPACES TO PRINTF-R
	   MOVE ALL '-' TO PRINTF-R(1:132)
	   WRITE PRINTF-R AFTER 1

           MOVE W-NMR TO W-L1-NMR
	   WRITE PRINTF-R FROM W-LINHA-1 AFTER 2


           MOVE ALL SPACES TO PRINTF-R
           MOVE W-NOME-FRO TO W-L2-FRO
	   MOVE W-DATASIS TO W-L2-DVEN
	   WRITE PRINTF-R FROM W-LINHA-2 AFTER 2

           MOVE ALL SPACES TO PRINTF-R
           MOVE W-VIA TO W-L3-VIA
	   MOVE W-DATA-EDIT TO W-L3-DVIA
	   IF W-TIPO = 1
	           MOVE 'SUBURBANO' TO W-L3-TIPO
           ELSE
	           MOVE 'CONVENCIONAL' TO W-L3-TIPO
           END-IF
	   WRITE PRINTF-R FROM W-LINHA-3 AFTER 2
	   
	   MOVE W-CLI TO W-L4-CPF
	   MOVE W-CLI-NOME TO W-L4-CLI
	   MOVE ALL SPACES TO PRINTF-R
	   WRITE PRINTF-R FROM W-LINHA-4 AFTER 2	   
	  
	   MOVE W-POL TO W-L5-POL
           MOVE ALL SPACES TO PRINTF-R
	   WRITE PRINTF-R FROM W-LINHA-5 AFTER 2

	   MOVE W-TOT TO W-L6-TOT
	   MOVE W-LOGIN-L TO W-L6-USU
	   COMPUTE W-HORA = (W-HR * 100) + W-MIN
	   MOVE W-HORA TO W-HR-VEND
	   MOVE W-HR-VEND TO W-L6-HR
	   MOVE ALL SPACES TO PRINTF-R
	   WRITE PRINTF-R FROM W-LINHA-6 AFTER 2

	   CLOSE PRINTF.

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
       COPY "DATASP.CPY".

       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-REL-CID.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           COPY "PRJ_FRO.SL".
	   COPY "PRJ_CID.SL".

           SELECT SORTER ASSIGN TO 'SORTER.ARQ'
                  FILE STATUS   IS ST-SORTER.

           SELECT PRINTF ASSIGN TO PRINTER
                  FILE STATUS IS ST-PRINTF.



       DATA DIVISION.
       FILE SECTION.

       
           COPY "PRJ_FRO.FD".
	   COPY "PRJ_CID.FD".

       FD  PRINTF LABEL RECORD OMITTED.
 
       01  PRINTF-R                       PIC X(255).
       
       SD  SORTER.

       01  SORT-REGISTR-1.
           03  SORT-CID-1        PIC 9(03).
	   03  SORT-NOME-1       PIC X(60).
	   03  SORT-LOC-1        PIC 9(04).
           03  SORT-MEDSUB-1     PIC 9(05)V99.
	   03  SORT-MEDCON-1     PIC 9(05)V99.
	   03  SORT-QTDFRO-1     PIC 9(3).
	   

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-IMPRIMIR             VALUE 02.

       01  CAMPOS-W.
           03  ST-CID                PIC  X(02).
               88 VAL-CID            VALUE '00' THRU '09'.
	   03  ST-FRO                PIC  X(02).
               88 VAL-FRO            VALUE '00' THRU '09'.
           03  ST-SORTER             PIC  X(02).
               88 VAL-SORTER         VALUE '00' THRU '09'.
           03  ST-PRINTF             PIC  X(02).
               88 VAL-PRINTF         VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
	       05 W-CIDINI              PIC 9(3).
	       05 W-CIDFIN              PIC 9(3).

               05 W-DATAUXI               PIC  9(08).
               05 REDEFINES W-DATAUXI.  
                  07 W-DIAAUXI            PIC  9(02).
                  07 W-MESAUXI            PIC  9(02).
                  07 W-ANOAUXI            PIC  9(04).
               05 REDEFINES W-DATAUXI.  
                  07 W-ANOAUXI-I          PIC  9(04).
                  07 W-MESAUXI-I          PIC  9(02).
                  07 W-DIAAUXI-I          PIC  9(02).

              

               05 W-NROPAGI               PIC  9(05) VALUE 0.
               05 W-CONTLIN               PIC  9(03) VALUE 0.
               05 W-DATA-SISTEMA          PIC  9(08) VALUE 0.
               05 W-CID-ANT               PIC  9(03) VALUE 0.
	       05 W-AUX-FRO               PIC  9(03).
              
               05 W-MEDSUB                PIC  9(05)V99 VALUE 0.
               05 W-MEDCONV               PIC  9(05)V99 VALUE 0.
               05 W-QTDFRO                PIC  9(3).
	       05 W-SOMSUB                PIC  9(05)V99 VALUE 0.
	       05 W-SOMCON                PIC  9(05)V99 VALUE 0.

               |LINHAS PARA IMPRESS?O
               05 W-LINHA-1.
	          07 FILLER    PIC X(08) VALUE 'CIDADE: '.
		  07 W-L1-CID  PIC X(60).
                  07 FILLER    PIC X(08) VALUE 'LOC. KM:'.
		  07 W-L2-LOC  PIC 999B.
	       05 W-LINHA-2.
	          07 FILLER    PIC X(28) 
		  VALUE 'MEDIA PRE?O SUBURBANO   : R$'.
		  07 W-L2-MED  PIC Z99,99.

	       05 W-LINHA-3.
	          07 FILLER    PIC X(28) 
		  VALUE 'MEDIA PRE?O CONVENCIONAL: R$'.
		  07 W-L3-MED  PIC Z99,99.

	       05 W-LINHA-4.
	          07 FILLER    PIC X(23)  VALUE 'QTD DE FROTAS: '.
		  07 W-L4-QTDFRO   PIC 999B.

	       05 W-CAB-1.
                  07 FILLER               PIC  X(74) VALUE
                     'RELATORIO DE CIDADES'.
                  07 W-CAB-DTSIS          PIC  99/99/9999B(4).
                  07 FILLER               PIC  X(05) VALUE 'PAG.'.
                  07 W-CAB-NPAG           PIC  ZZ.ZZ9B.
	      
	      

               05 W-OPC-CLASS             PIC  9(02) VALUE 1.

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

       01  JANELA-PRINCIPAL             PIC X(10) EXTERNAL.

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".
           COPY "DATASW.CPY".

       
        
  
       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL       LINE 02 COL 05
                          TITLE "Cidades de:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CIDINI
                          LINE 02
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 02 COL 20
                          TITLE "a"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CIDFIN
                          LINE 02
                          COL 22
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT.

           

           03 FRAME    LINE 05,75
                       COL 04
                       LINES 08
                       SIZE 22
                       TITLE "Ordem de classifica??o"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "&Quantidade de frotas"
                       LINE 7
                       COL 5
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-OPC-CLASS
                       ID 5
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&M?dia convencional"
                       LINE 09
                       COL 05
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-CLASS
                       ID 6
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&M?dia suburbano"
                       LINE 11
                       COL 05
                       GROUP 1
                       GROUP-VALUE 3
                       USING W-OPC-CLASS
                       ID 7
                       FONT SMALL-FONT
                       NOTIFY.

           03 PUSH-BUTTON TITLE "&Imprimir"
                          LINE 16
                          COL 2
                          SIZE 12
                          ID 8
                          EXCEPTION-VALUE EXCEPTION-IMPRIMIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 16
                          COL 17
                          SIZE 13
                          SELF-ACT
                          ID 9
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN INPUT CCIDADE
           IF NOT VAL-CID
              PERFORM ERRO-ARQUIVO.

	   OPEN INPUT CFROTA
           IF NOT VAL-FRO
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 100 LINES 18
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Relat?rio de Cidades"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PRINCIPAL.

           INITIALIZE W-CIDINI W-CIDFIN.

           DISPLAY TELA-PRINCIPAL.

           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE WINDOW JANELA-PRINCIPAL.

           CANCEL SORT.

           EXIT PROGRAM
           STOP RUN.

       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH
	   END-IF


           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-IMPRIMIR
	          |TESTA RANGE DE CIDADES
                  IF W-CIDINI <= 0
		      MOVE 1 TO W-CIDINI
		  ELSE
                      MOVE W-CIDINI TO W-CID-ANT
                  END-IF
		  
		  IF W-CIDFIN <= 0
		      MOVE 999 TO W-CIDFIN
		  END-IF

                  IF W-CIDFIN < W-CIDINI
                     INITIALIZE CA-MESSAGE-LINK
                     MOVE 'Range de cidade inv?lido.' TO CA-MESSAGE-1
                     PERFORM MOSTRA-MSG-ERRO
                     EXIT PARAGRAPH
                  END-IF



                  INITIALIZE W-NROPAGI W-QTDFRO W-SOMSUB W-SOMCON
                  MOVE 800 TO W-CONTLIN

                  OPEN OUTPUT PRINTF
		  INITIALIZE FRO-REG-1 CID-REG-1
                  START CCIDADE KEY >= CID-ID
		  
		  IF VAL-CID 
                     EVALUATE W-OPC-CLASS
		        WHEN 1
			     SORT SORTER ASCENDING KEY SORT-CID-1
                                                       SORT-QTDFRO-1                      
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
			WHEN 2
			     SORT SORTER ASCENDING KEY SORT-CID-1
                                                       SORT-MEDCON-1                      
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
			WHEN 1
			     SORT SORTER ASCENDING KEY SORT-CID-1
                                                       SORT-MEDSUB-1                      
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
	             END-EVALUATE
                  END-IF
                  CLOSE PRINTF
           END-EVALUATE.

       INPUTPROCE.
           PERFORM UNTIL NOT VAL-CID
	   READ CCIDADE NEXT AT END
                               EXIT PERFORM
              END-READ
              IF NOT VAL-CID
                 PERFORM ERRO-ARQUIVO
              END-IF

             INITIALIZE             SORT-REGISTR-1
	     MOVE 0 TO W-AUX-FRO
	     MOVE W-AUX-FRO TO FRO-ID
             START CFROTA KEY >= FRO-ID
	     IF VAL-FRO 
		     PERFORM UNTIL NOT VAL-FRO
		     READ CFROTA NEXT AT END
				       EXIT PERFORM
		     END-READ
		          IF NOT VAL-FRO
			       PERFORM ERRO-ARQUIVO
		          END-IF
			  IF FRO-ORI = CID-ID OR FRO-DES = CID-ID
			      ADD 1 TO W-QTDFRO
			      COMPUTE W-SOMSUB = W-SOMSUB + FRO-SUB
			      COMPUTE W-SOMCON = W-SOMCON + FRO-CON
			  END-IF
		     END-PERFORM
                     COMPUTE W-MEDSUB = W-SOMSUB / W-QTDFRO
	             COMPUTE W-MEDCONV = W-SOMCON / W-QTDFRO
		     IF CID-ID >= W-CIDINI AND <= W-CIDFIN 
			     MOVE CID-ID   TO SORT-CID-1
			     MOVE CID-NOME TO SORT-NOME-1
			     MOVE CID-LOC  TO SORT-LOC-1
			     MOVE W-MEDSUB TO SORT-MEDSUB-1
			     MOVE W-MEDCONV TO SORT-MEDCON-1
			     MOVE W-QTDFRO TO SORT-QTDFRO-1
			     RELEASE SORT-REGISTR-1
	             END-IF
	             INITIALIZE W-MEDSUB W-MEDCONV W-SOMSUB W-SOMCON 
		                W-QTDFRO
	            
	     END-IF
           END-PERFORM.

       OUTPUTPROC.
           PERFORM UNTIL 1 = 2
              RETURN SORTER AT END
                            EXIT PERFORM
              END-RETURN


	      PERFORM TESTA-QUEBRA-PAGINA

              
              |IMPRESS?O 
	      MOVE SORT-NOME-1 TO W-L1-CID
	      MOVE SORT-LOC-1 TO W-L2-LOC
	      WRITE PRINTF-R FROM W-LINHA-1 AFTER 1
	      MOVE SORT-MEDSUB-1 TO W-L2-MED
	      WRITE PRINTF-R FROM W-LINHA-2 AFTER 1
	      MOVE SORT-MEDCON-1 TO W-L3-MED
	      WRITE PRINTF-R FROM W-LINHA-3 AFTER 1
	      MOVE SORT-QTDFRO-1 TO W-L4-QTDFRO
	      WRITE PRINTF-R FROM W-LINHA-4 AFTER 1
	      MOVE SPACES TO PRINTF-R
	      WRITE PRINTF-R AFTER 2
	      ADD 6 TO W-CONTLIN							 
		
           END-PERFORM.

            

       TESTA-QUEBRA-PAGINA.
           IF W-CONTLIN > 63

              PERFORM IMPRIME-CABECALHO

              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1

              ADD 2 TO W-CONTLIN
           END-IF.




       IMPRIME-CABECALHO.
           MOVE SPACES TO PRINTF-R
           MOVE ALL '-' TO PRINTF-R(1:132)
           IF W-NROPAGI = 0
              ACCEPT W-DATA-SISTEMA FROM CENTURY-DATE
              MOVE W-DATA-SISTEMA TO W-DATAUXI
              COMPUTE W-DATA-SISTEMA = W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000

              WRITE PRINTF-R AFTER 0
           ELSE
              WRITE PRINTF-R AFTER PAGE.

           ADD 1 TO W-NROPAGI
           MOVE W-NROPAGI      TO W-CAB-NPAG
           MOVE W-DATA-SISTEMA TO W-CAB-DTSIS
           WRITE PRINTF-R FROM W-CAB-1 AFTER 1

           MOVE SPACES TO PRINTF-R
           MOVE ALL '-' TO PRINTF-R(1:132)
           WRITE PRINTF-R AFTER 1

           MOVE 3 TO W-CONTLIN.          
           
          

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

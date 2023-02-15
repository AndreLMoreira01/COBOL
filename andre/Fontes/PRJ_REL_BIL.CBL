       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-REL-BIL.
       AUTHOR.        HIGOR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           COPY "PRJ_BIL.SL".

           SELECT SORTER ASSIGN TO 'SORTER.ARQ'
                  FILE STATUS   IS ST-SORTER.

           SELECT PRINTF ASSIGN TO PRINTER
                  FILE STATUS IS ST-PRINTF.



       DATA DIVISION.
       FILE SECTION.

       COPY "PRJ_BIL.FD".

       FD  PRINTF LABEL RECORD OMITTED.
 
       01  PRINTF-R                       PIC X(255).
       
       SD  SORTER.

       01  SORT-REGISTR-1.
           03  SORT-FRO-1             PIC 9(03).
           03  SORT-CLI-1             PIC 9(11).
           03  SORT-DATA-1            PIC 9(08).
           03  SORT-VIA-1             PIC 9(06).
           03  SORT-TIPO-1            PIC 9(02).
           03  SORT-POL-1             PIC 9(02).
	   03  SORT-DESC-1            PIC 9(1).
	   03  SORT-TOT-1             PIC 9(06)V99.
	   03  SORT-NMR-1             PIC 9(16).
	   03  SORT-NOME-1            PIC X(60).
	   03  SORT-PERC-1            PIC 9(02).
	   03  SORT-DTVENDA-1         PIC 9(8).
	   03  SORT-HORA-1            PIC 9(8).
	   03  SORT-USU-1             PIC X(10).


       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-IMPRIMIR             VALUE 02.

       01  CAMPOS-W.
           03  ST-BIL                PIC  X(02).
               88 VAL-BIL            VALUE '00' THRU '09'.
           03  ST-SORTER             PIC  X(02).
               88 VAL-SORTER         VALUE '00' THRU '09'.
           03  ST-PRINTF             PIC  X(02).
               88 VAL-PRINTF         VALUE '00' THRU '09'.
	   03  ST-FRO                PIC  X(02).
               88 FIM-FROTA          VALUE 'S' FALSE 'N'.

           03  CAMPOS-TELA-W.
               05 W-DATAINI               PIC  99/99/9999.
               05 W-DATAFIN               PIC  99/99/9999.
	       05 W-FROTAINI              PIC 9(3).
	       05 W-FROTAFIN              PIC 9(3).

               05 W-DATAUXI               PIC  9(08).
               05 REDEFINES W-DATAUXI.  
                  07 W-DIAAUXI            PIC  9(02).
                  07 W-MESAUXI            PIC  9(02).
                  07 W-ANOAUXI            PIC  9(04).
               05 REDEFINES W-DATAUXI.  
                  07 W-ANOAUXI-I          PIC  9(04).
                  07 W-MESAUXI-I          PIC  9(02).
                  07 W-DIAAUXI-I          PIC  9(02).

               05 W-DATAINI-I             PIC  9(08).
               05 W-DATAFIN-I             PIC  9(08).
               05 W-DATAVEN-I             PIC  9(08).
	       05 W-DATAREL               PIC  9(8).

               05 W-NROPAGI               PIC  9(05) VALUE 0.
               05 W-CONTLIN               PIC  9(03) VALUE 0.
               05 W-DATA-SISTEMA          PIC  9(08) VALUE 0.
               05 W-FRO-ANT               PIC  9(03) VALUE 0.
               05 W-DATA-ANT              PIC  9(08) VALUE 0.
	       05 W-HORA                  PIC  9(8).
	       05 REDEFINES W-HORA.
	          07 W-HR		  PIC 9(2).
		  07 W-MIN		  PIC 9(2).
		  07 W-SEG		  PIC 9(2).
		  07 W-MM		  PIC 9(2).
	       05 W-HR-CER                PIC 9(4).
               05 W-TOTDIA                PIC  9(10)V99 VALUE 0.
               05 W-TOTFRO                PIC  9(10)V99 VALUE 0.
               05 W-TOTGERAL              PIC  9(10)V99 VALUE 0.

               |LINHAS PARA IMPRESSÃO
               05 W-LINHA-1.
	          07 FILLER    PIC X(12) VALUE 'N° BILHETE: '.
		  07 W-L1-NMR  PIC 9(16).
	       05 W-LINHA-2.
		  07 FILLER    PIC X(8) VALUE 'VIAGEM: '.
		  07 W-L2-VIA  PIC 9(1).
		  07 FILLER    PIC X(9) VALUE '   TIPO: '.
                  07 W-L2-TIPO PIC X(54).
		  07 FILLER    PIC X(17) VALUE ' DATA DA VENDA: '.
		  07 W-L2-DVEN PIC  99/99/9999B(4).
	        05 W-LINHA-3.
		  07 FILLER    PIC X(12) VALUE 'CLIENTE:    '.
		  07 W-L3-CLI  PIC X(60).
		  07 FILLER    PIC X(5) VALUE ' CPF: '.
		  07 W-L3-CPF  PIC 999.999.999.99.
		05 W-LINHA-4.
		  07 FILLER    PIC X(5) VALUE 'POL :'.
		  07  W-L4-POL PIC 9(2).
		05 W-LINHA-5.
		  07 FILLER    PIC X(12) VALUE 'VENDEDOR:   '.
		  07 W-L5-USU  PIC X(10).
		  07 FILLER    PIC X(15) VALUE '      TOTAL: R$'.
		  07 W-L5-TOT  PIC Z999,99.
		  07 FILLER    PIC X(28) VALUE ALL SPACES.
		  07 FILLER    PIC X(15) VALUE ' HORA DA VENDA:'.
		  07 W-L5-HR   PIC 99.99.
		05 W-LINHA-6.
		  07 FILLER    PIC X(10) VALUE 'DESCONTO: '.
		  07 W-L6-DESC PIC 9(02).
		  07 FILLER    PIC X(1) VALUE '%'.
		05 W-LINHA-TOTAL-DIA.
		  07 FILLER    PIC X(30) VALUE ALL SPACES.
		  07 FILLER    PIC X(18)   VALUE '*** TOTAL DO DIA: '.
		  07 W-D-DT    PIC 99/99/9999.
		  07 FILLER    PIC X(4)   VALUE '  R$'.
		  07 W-D-TOT   PIC Z99,99.
		05 W-LINHA-TOTAL-FROTA.
		  07 FILLER    PIC X(30) VALUE ALL SPACES.
		  07 FILLER    PIC X(20)   VALUE '*** TOTAL DA FROTA: '.
		  07 W-F-FROTA PIC 9(3).
		  07 FILLER    PIC X(4)   VALUE '  R$'.
		  07 W-F-TOT   PIC Z99,99.
		05 W-LINHA-TOTAL-GERAL.
		  07 FILLER    PIC X(60) VALUE ALL SPACES.
                  07 FILLER    PIC X(19)   VALUE '*** TOTAL GERAL: R$'.
		  07 W-G-TOT   PIC Z99,99.

               05 W-CAB-1.
                  07 FILLER               PIC  X(74) VALUE
                     'RELATORIO DE EMISSÕES'.
                  07 W-CAB-DTSIS          PIC  99/99/9999B(4).
                  07 FILLER               PIC  X(05) VALUE 'PAG.'.
                  07 W-CAB-NPAG           PIC  ZZ.ZZ9B.

	       05 W-CONTFRO               PIC 9(5) VALUE 0.

               05 W-CAB-FRO.
                  07 FILLER             PIC  X(8) VALUE 'FROTA : '.
                  07 W-C-FRO            PIC  999B.
               
               05 W-CAB-DATA.   
                  07 FILLER              PIC  X(7) VALUE 'DATA : '.
                  07 W-C-DATA           PIC  99/99/9999.

	       05 W-CAB-CONTFRO.
	          07 FILLER    PIC X(30) VALUE ALL SPACES.
                  07 FILLER PIC X(31) 
		  VALUE '*** TOTAL DE VENDAS NA FROTA : '.
                  07 W-T-FRO            PIC  999B.
		  07 W-CFRO             PIC  B9(5).

               05 W-OPC-CLASSIFICACAO     PIC  9(02) VALUE 1.

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
                          TITLE "Viagens de:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATAINI
                          LINE 02
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 02 COL 27
                          TITLE "a"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATAFIN
                          LINE 02
                          COL 29
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT.

           03 LABEL       LINE 04 COL 05
                          TITLE "Frotas de:"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-FROTAINI
                          LINE 04
                          COL 15
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 04 COL 20
                          TITLE "a"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-FROTAFIN
                          LINE 04
                          COL 22
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT.

           03 FRAME    LINE 02,75
                       COL 79
                       LINES 05
                       SIZE 22
                       TITLE "Ordem de classificação"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "&Cliente"
                       LINE 04
                       COL 80
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-OPC-CLASSIFICACAO
                       ID 5
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&Usuário"
                       LINE 06
                       COL 80
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-CLASSIFICACAO
                       ID 6
                       FONT SMALL-FONT
                       NOTIFY.

           03 PUSH-BUTTON TITLE "&Imprimir"
                          LINE 8
                          COL 2
                          SIZE 12
                          ID 7
                          EXCEPTION-VALUE EXCEPTION-IMPRIMIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 8
                          COL 17
                          SIZE 13
                          SELF-ACT
                          ID 6
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN INPUT CBILHETE
           IF NOT VAL-BIL
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                           SIZE 105 LINES 10
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Relatório de emissões"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           BACKGROUND-LOW
                           HANDLE JANELA-PRINCIPAL.

           INITIALIZE W-DATAINI W-DATAFIN.

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
                  |* validacao das datas antes de iniciar a impressao
                  IF W-DATAINI <> '00/00/0000'
                     MOVE W-DATAINI TO W-DATA-CRIT
                     PERFORM CRITICA-DATA
                     IF NOT DATA-OK
                        INITIALIZE CA-MESSAGE-LINK
                        MOVE 'Data inicial inválida.' TO CA-MESSAGE-1
                        PERFORM MOSTRA-MSG-ERRO
                        EXIT PARAGRAPH
                     END-IF
                  END-IF
                  IF W-DATAFIN = '00/00/0000'
                     MOVE 99999999 TO W-DATAFIN
                     DISPLAY TELA-PRINCIPAL
                  END-IF
                  IF W-DATAFIN <> '99/99/9999'
                     MOVE W-DATAFIN TO W-DATA-CRIT
                     PERFORM CRITICA-DATA
                     IF NOT DATA-OK
                        INITIALIZE CA-MESSAGE-LINK
                        MOVE 'Data final inválida.' TO CA-MESSAGE-1
                        PERFORM MOSTRA-MSG-ERRO
                        EXIT PARAGRAPH
                     END-IF
                  END-IF
                  |* inverte a data inicial
                  MOVE W-DATAINI TO W-DATAUXI
                  COMPUTE W-DATAINI-I = W-ANOAUXI * 10000 +
                                        W-MESAUXI * 100 +
                                        W-DIAAUXI
                  |* inverte a data final
                  MOVE W-DATAFIN TO W-DATAUXI
                  COMPUTE W-DATAFIN-I = W-ANOAUXI * 10000 +
                                        W-MESAUXI * 100 +
                                        W-DIAAUXI
                  |* compara o range de data
                  IF W-DATAFIN-I < W-DATAINI-I
                     INITIALIZE CA-MESSAGE-LINK
                     MOVE 'Range de data inválido.' TO CA-MESSAGE-1
                     PERFORM MOSTRA-MSG-ERRO
                     EXIT PARAGRAPH
                  END-IF

                  |testa o range das frotas

		   IF W-FROTAINI <= 0
		      MOVE 1 TO W-FROTAINI
		  ELSE
                      MOVE W-FROTAINI TO W-FRO-ANT
                  END-IF
		  
		  IF W-FROTAFIN <= 0
		      MOVE 999 TO W-FROTAFIN
		  END-IF

                  IF W-FROTAFIN < W-FROTAINI
                     INITIALIZE CA-MESSAGE-LINK
                     MOVE 'Range de frota inválido.' TO CA-MESSAGE-1
                     PERFORM MOSTRA-MSG-ERRO
                     EXIT PARAGRAPH
                  END-IF


                  INITIALIZE W-NROPAGI  W-TOTGERAL W-TOTFRO
                  MOVE 800 TO W-CONTLIN

                  OPEN OUTPUT PRINTF
                  INITIALIZE BIL-REG-1
                  START CBILHETE KEY >= BIL-RK-1
                  IF VAL-BIL
                     IF W-OPC-CLASSIFICACAO = 1
                        SORT SORTER ASCENDING KEY SORT-FRO-1
                                                  SORT-DATA-1
                                                  SORT-NOME-1
                                                  SORT-USU-1
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
                     ELSE
                        SORT SORTER ASCENDING KEY SORT-FRO-1
                                                  SORT-DATA-1
                                                  SORT-USU-1
                                                  SORT-NOME-1
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
                     END-IF
                  END-IF
                  CLOSE PRINTF
           END-EVALUATE.

       INPUTPROCE.
           PERFORM UNTIL NOT VAL-BIL
	   READ CBILHETE NEXT AT END
                               EXIT PERFORM
              END-READ
              IF NOT VAL-BIL
                 PERFORM ERRO-ARQUIVO
              END-IF

              |* inverte a data da viagem
              MOVE BIL-DATA TO W-DATAUXI
              COMPUTE W-DATAVEN-I = W-ANOAUXI * 10000 +
                                    W-MESAUXI * 100 +
                                    W-DIAAUXI

	      INITIALIZE             SORT-REGISTR-1

              IF W-DATAVEN-I >= W-DATAINI-I AND <= W-DATAFIN-I
	         IF (BIL-FRO >= W-FROTAINI AND <= W-FROTAFIN)
			 INITIALIZE             SORT-REGISTR-1
			 MOVE BIL-FRO      TO SORT-FRO-1
			 MOVE BIL-CLI      TO SORT-CLI-1
			 MOVE W-DATAVEN-I  TO SORT-DATA-1
			 MOVE BIL-VIA      TO SORT-VIA-1
			 MOVE BIL-TIPO     TO SORT-TIPO-1
			 MOVE BIL-POL      TO SORT-POL-1
			 MOVE BIL-DESC     TO SORT-DESC-1
			 MOVE BIL-TOT      TO SORT-TOT-1
			 MOVE BIL-NMR      TO SORT-NMR-1
			 MOVE BIL-NOME     TO SORT-NOME-1
			 MOVE BIL-PERC     TO SORT-PERC-1
			 MOVE BIL-DT-VENDA TO SORT-DTVENDA-1
			 MOVE BIL-HORA     TO SORT-HORA-1
			 MOVE BIL-USU      TO SORT-USU-1
			 RELEASE SORT-REGISTR-1
	         END-IF
              END-IF
           END-PERFORM.

       OUTPUTPROC.
           SET FIM-FROTA TO FALSE
           PERFORM UNTIL 1 = 2
              RETURN SORTER AT END
                            EXIT PERFORM
              END-RETURN

              IF SORT-FRO-1 <> W-FRO-ANT AND W-DATA-ANT <> 0 | IMPRIMIR SÓ QUANDO ACABA A FROTA
                        MOVE 800 TO W-CONTLIN
			SET FIM-FROTA TO TRUE
			| IMPRIME TOTAL DA DATA
			PERFORM TOTALIZA-DATA
              END-IF

              PERFORM TESTA-QUEBRA-PAGINA
 
              IF SORT-DATA-1 <> W-DATA-ANT
                 IF W-DATA-ANT = 0 | SABER QUE ESTÁ COMEÇANDO A FROTA, ENTÃO NÃO PRECISA TOTALIZAR
		 | IMPRIME APENAS CABEÇALHO DA DATA
		    PERFORM CABECALHO-DATA
		    ADD 1 TO W-CONTLIN
		 ELSE
		 | IMPRIME TOTAL DA DATA
		   PERFORM TOTALIZA-DATA
		  | IMPRIME CABEÇALHO DA DATA
		     PERFORM CABECALHO-DATA
		     ADD 2 TO W-CONTLIN
		  
		  END-IF
              END-IF

              |IMPRESÃO DO BILHETE
              MOVE SORT-NMR-1 TO W-L1-NMR
              WRITE PRINTF-R FROM W-LINHA-1 AFTER 1
	      MOVE SORT-VIA-1 TO W-L2-VIA
	      IF SORT-TIPO-1 = 1
	        MOVE 'SUBURBANO' TO W-L2-TIPO
	      ELSE
	        MOVE 'CONVENCIONAL' TO W-L2-TIPO
	      END-IF
	      MOVE SORT-DTVENDA-1 TO W-L2-DVEN
	      WRITE PRINTF-R FROM W-LINHA-2 AFTER 1
	      MOVE SORT-NOME-1 TO W-L3-CLI
	      MOVE SORT-CLI-1 TO W-L3-CPF
	      WRITE PRINTF-R FROM W-LINHA-3 AFTER 1
	      MOVE SORT-POL-1 TO W-L4-POL
	      WRITE PRINTF-R FROM W-LINHA-4 AFTER 1
	      MOVE SORT-USU-1 TO W-L5-USU 
	      MOVE SORT-TOT-1 TO W-L5-TOT
	      MOVE SORT-HORA-1 TO W-HORA
	      COMPUTE W-HR-CER = (W-HR * 100) + W-MIN
	      MOVE W-HR-CER TO W-L5-HR
	      WRITE PRINTF-R FROM W-LINHA-5 AFTER 1
	      MOVE 0 TO W-L6-DESC
	      EVALUATE SORT-PERC-1
               WHEN 1
                  MOVE 5 TO W-L6-DESC
               WHEN 2
                  MOVE 10 TO W-L6-DESC
               WHEN 3
                  MOVE 15 TO W-L6-DESC
	       WHEN 4
                  MOVE 25 TO W-L6-DESC
	       WHEN 5
                  MOVE 50 TO W-L6-DESC
              END-EVALUATE
	      WRITE PRINTF-R FROM W-LINHA-6 AFTER 1
	      MOVE SPACES TO PRINTF-R
	      WRITE PRINTF-R AFTER 1
	      ADD SORT-TOT-1 TO W-TOTDIA
              ADD 1 TO W-CONTFRO
	      ADD 7 TO W-CONTLIN
	      MOVE SORT-FRO-1 TO W-FRO-ANT
	      MOVE SORT-DATA-1 TO W-DATA-ANT
           END-PERFORM.

            IF W-CONTLIN <> 800
	         | IMPRIME TOTAL DA DATA
                PERFORM TOTALIZA-DATA
	       | IMPRIME TOTAL DA FROTA
	      PERFORM TOTALIZA-FROTA
	      | IMPRIME TOTAL GERAL
              PERFORM TESTA-QUEBRA-PAGINA
              MOVE W-TOTGERAL TO W-G-TOT
              WRITE PRINTF-R FROM W-LINHA-TOTAL-GERAL AFTER 2
           END-IF.

       TOTALIZA-FROTA.
           MOVE W-FRO-ANT TO W-F-FROTA
	   MOVE W-TOTFRO TO W-F-TOT
	   MOVE W-CONTFRO TO W-CFRO
	   MOVE W-FRO-ANT TO W-T-FRO
	   ADD W-TOTFRO TO W-TOTGERAL
	   WRITE PRINTF-R FROM W-CAB-CONTFRO AFTER 2
	   INITIALIZE W-TOTFRO W-CONTFRO
	   WRITE PRINTF-R FROM W-LINHA-TOTAL-FROTA AFTER 2
           SET FIM-FROTA TO FALSE.

       TOTALIZA-DATA.
           MOVE W-DATA-ANT TO W-DATAUXI
	   COMPUTE W-DATAREL = W-ANOAUXI-I +
		       W-MESAUXI-I * 10000 +
		       W-DIAAUXI-I * 1000000
	   MOVE W-DATAREL TO W-D-DT
	   MOVE W-TOTDIA TO W-D-TOT
	   ADD W-TOTDIA TO W-TOTFRO
	   INITIALIZE W-TOTDIA
	   WRITE PRINTF-R FROM W-LINHA-TOTAL-DIA AFTER 1
	   ADD 1 TO W-CONTLIN
	   MOVE SPACES TO PRINTF-R
	   WRITE PRINTF-R AFTER 1
	   ADD 1 TO W-CONTLIN
	   MOVE 0 TO W-DATA-ANT.

       CABECALHO-DATA.
           MOVE SORT-DATA-1 TO W-DATAUXI
	   COMPUTE W-DATAREL = W-ANOAUXI-I +
		       W-MESAUXI-I * 10000 +
		       W-DIAAUXI-I * 1000000
	    MOVE W-DATAREL TO W-C-DATA
	    WRITE PRINTF-R FROM W-CAB-DATA AFTER 1
	    MOVE ALL SPACES TO PRINTF-R
	    WRITE PRINTF-R AFTER 1.


       TESTA-QUEBRA-PAGINA.
           IF W-CONTLIN > 62
	     
	      IF FIM-FROTA
	        PERFORM TOTALIZA-FROTA
              END-IF

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
           WRITE PRINTF-R AFTER 1.

           MOVE 3 TO W-CONTLIN
           
           
           MOVE SPACES TO PRINTF-R
           WRITE PRINTF-R AFTER 1
           MOVE SORT-FRO-1 TO W-C-FRO
           WRITE PRINTF-R FROM W-CAB-FRO AFTER 1
           ADD 2 TO W-CONTLIN.

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

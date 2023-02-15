       IDENTIFICATION DIVISION.
       PROGRAM-ID.    BOLETIM.
       AUTHOR.        ANDRE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT TABBO ASSIGN TO 'BOLETIM.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-1
                  FILE STATUS  IS STAT-TABBO.

           SELECT TABAL ASSIGN TO 'ALUNO.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-2
                  FILE STATUS  IS STAT-TABAL.

	       SELECT TABPROF ASSIGN TO 'PROFESSOR.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-4
                  FILE STATUS  IS STAT-TABPROF.

            SELECT TABMAT ASSIGN TO 'MATERIA.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   TDES-RECORDK-3
                  FILE STATUS  IS STAT-TABMAT.

       DATA DIVISION.
       FILE SECTION.

       FD  TABBO  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-1.
           03  TDES-RECORDK-1.
	       05  TDES-PROFESSOR-1             PIC  9(06).
           03  TDES-ALUNO-1             PIC  9(006).
           03  TDES-MATERIA-1             PIC  9(003).
           03  TDES-NOTA-1             PIC  9(003)V99.

       FD  TABAL  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-2.
           03  TDES-RECORDK-2.
               05 TDES-CODIGO-2           PIC  9(06).
           03  TDES-NOME-2             PIC  X(40).      

       FD  TABMAT  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-3.
           03  TDES-RECORDK-3.
                05 TDES-CODIGO-3         PIC  9(003).
                03  TDES-NOME-3             PIC  X(40).
           03  TDES-MEDIA-3            PIC 9(003)V99.     
       
       FD  TABPROF  LABEL RECORD IS STANDARD.

       01  TDES-REGISTR-4.
           03  TDES-RECORDK-4.
                05 TDES-CODIGO-4          PIC  9(06).
           03  TDES-NOME-4             PIC  X(40).       

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-TABBO                PIC  X(02).
               88 VALID-TABBO            VALUE '00' THRU '09'.

	   03  STAT-TABAL               PIC  X(02).
               88 VALID-TABAL           VALUE '00' THRU '09'.
	   
	   03  STAT-TABPROF                PIC  X(02).
               88 VALID-TABPROF            VALUE '00' THRU '09'.

           03  STAT-TABMAT              PIC  X(02).
               88 VALID-TABMAT           VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
	       05 W-PROFESSOR-EDIT        PIC  9(03).
	       05 W-ALUNO-EDIT         PIC  9(11).
               05 W-MATERIA-EDIT         PIC  9(10).
               05 W-NOTA-EDIT      PIC  9(03).

               05 W-PROFESSOR             PIC  9(06).
	       05 W-ALUNO              PIC  9(006).
               05 W-MATERIA             PIC  9(003).

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
           03 LABEL       LINE 01,5 COL 05
                          TITLE "Professor"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-PROFESSOR-EDIT
                          LINE 01,5
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
			  SIZE 12
                          FONT SMALL-FONT.

           03 LABEL       LINE 03,5 COL 05
                          TITLE "Aluno"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-ALUNO-EDIT
                          LINE 03,5
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
			  SIZE 12
                          FONT SMALL-FONT.

           03 LABEL       LINE 05,5 COL 05
                          TITLE "Materia"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-MATERIA-EDIT
                          LINE 05,5
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
			  SIZE 12
                          FONT SMALL-FONT.

           03 LABEL       LINE 07,5 COL 05
                          TITLE "Nota"
                          ID 6
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOTA-EDIT
                          SIZE 12
                          LINE 07,5
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 7
                          FONT SMALL-FONT.
     
           03 PUSH-BUTTON TITLE "&Gravar"
                          LINE 15,5
                          COL 05
                          SIZE 12
                          ID 14
                          EXCEPTION-VALUE EXCEPTION-GRAVAR.

           03 PUSH-BUTTON TITLE "&Excluir"
                          LINE 15,5
                          COL 20
                          SIZE 12
                          ID 15
                          EXCEPTION-VALUE EXCEPTION-EXCLUIR.

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 15,5
                          COL 50
                          SIZE 12
                          SELF-ACT
                          ID 16
                          EXCEPTION-VALUE 27.

	   03 PUSH-BUTTON TITLE "&Ler o arquivo"
                          LINE 15,5
                          COL 35
                          SIZE 12
                          ID 5
                          EVENT PROCEDURE EVENTO-BTN-LER-ARQUIVO.

	   03 PUSH-BUTTON TITLE "&Cadatrar Professor"
                          LINE 01,5
                          COL 50
                          SIZE 14
                          ID 5
                          EVENT PROCEDURE CADASTRAR-PROFESSOR.

	   03 PUSH-BUTTON TITLE "&Cadatrar Aluno"
                          LINE 03,5
                          COL 50
                          SIZE 14
                          ID 5
                          EVENT PROCEDURE CADASTRAR-ALUNO.

	   03 PUSH-BUTTON TITLE "&Cadatrar Matéria"
                          LINE 05,5
                          COL 50
                          SIZE 14
                          ID 5
                          EVENT PROCEDURE CADASTRAR-MATERIA.

       PROCEDURE DIVISION.
       INICIO.
           OPEN I-O TABBO
           IF STAT-TABBO = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT TABBO
              CLOSE TABBO
              OPEN I-O TABBO.
           IF NOT VALID-TABBO
              PERFORM ERRO-ARQUIVO.

	       OPEN I-O TABAL.

           OPEN I-O TABPROF.
           
           OPEN I-O TABMAT.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Boletim"
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
           CLOSE TABBO.

           CLOSE TABAL.

	       CLOSE TABPROF.

	       CLOSE TABMAT.

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
           INITIALIZE TDES-REGISTR-4
           MOVE W-PROFESSOR-EDIT TO TDES-CODIGO-4
           READ TABPROF
           IF NOT VALID-TABPROF
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Professor ' TDES-CODIGO-4 ' não cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE TDES-REGISTR-2
           MOVE W-ALUNO-EDIT TO TDES-CODIGO-2
           READ TABAL
           IF NOT VALID-TABAL
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Aluno ' TDES-CODIGO-2 ' não cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE TDES-REGISTR-3
           MOVE W-MATERIA-EDIT TO TDES-CODIGO-3
           READ TABMAT
           IF NOT VALID-TABMAT
              INITIALIZE CA-MESSAGE-LINK
              STRING 'Matéria ' TDES-CODIGO-3 ' não cadastrado.'
                   DELIMITED BY SIZE 
                   INTO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             TDES-REGISTR-1
           MOVE W-PROFESSOR-EDIT TO TDES-PROFESSOR-1
	       MOVE W-ALUNO-EDIT TO TDES-ALUNO-1
	       MOVE W-MATERIA-EDIT TO TDES-MATERIA-1
           READ TABBO
           
	   IF STAT-TABBO = '23'
              INITIALIZE             TDES-REGISTR-1
              MOVE W-PROFESSOR-EDIT TO TDES-PROFESSOR-1
	      MOVE W-ALUNO-EDIT TO TDES-ALUNO-1
	      MOVE W-MATERIA-EDIT TO TDES-MATERIA-1
	      END-IF.

           MOVE W-NOTA-EDIT TO TDES-NOTA-1

           INITIALIZE CA-MESSAGE-LINK

	   IF TDES-NOTA-1 >= TDES-MEDIA-3
	      STRING  'ALUNO ' TDES-NOME-2 'APROVADO'
		INTO CA-MESSAGE-1
	      PERFORM MOSTRA-MSG-MENSAGEM
	   ELSE 
	      STRING  'ALUNO ' TDES-NOME-2 'REPROVADO'
		DELIMITED BY SIZE
		INTO CA-MESSAGE-1
	      PERFORM MOSTRA-MSG-MENSAGEM
	  END-IF.

           IF STAT-TABBO = '23'
              WRITE TDES-REGISTR-1
              MOVE 'Registro não cadastrado.' TO CA-MESSAGE-1 
           ELSE 
	   REWRITE TDES-REGISTR-1
	   END-IF.

           IF NOT VALID-TABBO
              PERFORM ERRO-ARQUIVO.


       ROTINA-EXCLUIR.
           INITIALIZE             TDES-REGISTR-1
           MOVE W-PROFESSOR-EDIT TO TDES-PROFESSOR-1
           READ TABBO
           IF STAT-TABBO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro não cadastrada.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-TABBO
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE TABBO
              IF NOT VALID-TABBO
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro excluído.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.
       
       CADASTRAR-PROFESSOR.
           CALL 'PROFESSOR' USING W-PROFESSOR-EDIT
		       ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa não encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'BOLETIM'.

       CADASTRAR-ALUNO.
           CALL 'ALUNO' USING W-ALUNO-EDIT
               ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa não encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'BOLETIM'.
       
       CADASTRAR-MATERIA.
           CALL 'MATERIA' USING W-MATERIA-EDIT
		       ON OVERFLOW
		   INITIALIZE CA-MESSAGE-LINK
		   MOVE 'Programa não encontrado.'
		       TO CA-MESSAGE-1
		   PERFORM MOSTRA-MSG-MENSAGEM
           END-CALL.
           CANCEL 'BOLETIM'.
       
       EVENTO-BTN-LER-ARQUIVO.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        TDES-REGISTR-1
           MOVE W-PROFESSOR-EDIT TO TDES-PROFESSOR-1
	   MOVE W-ALUNO-EDIT TO TDES-ALUNO-1
	   MOVE W-MATERIA-EDIT TO TDES-MATERIA-1
           READ TABBO
           IF STAT-TABBO = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF STAT-TABBO = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-TABBO
                 PERFORM ERRO-ARQUIVO.
                 
	   MOVE W-NOTA-EDIT TO TDES-NOTA-1

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
	
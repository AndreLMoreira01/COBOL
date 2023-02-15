       IDENTIFICATION DIVISION.
       PROGRAM-ID.    CADASTRO_VENDEDORES.
       AUTHOR.        GABRIEL.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT VENDEDORES ASSIGN TO 'VENDEDORES.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   VENDE-RECORDK-1
                  FILE STATUS  IS STAT-VENDEDORES.

       DATA DIVISION.
       FILE SECTION.

       FD  VENDEDORES  LABEL RECORD IS STANDARD.

       01  VENDE-REGISTR-1.
           03  VENDE-RECORDK-1.
               05 VENDE-CODIGO-1          PIC  9(03).
           03  VENDE-NOME-1               PIC  X(50).
           03  VENDE-TOTALVENDAS-1        PIC  9(09)V99.

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.
       78  EXCEPTION-GRAVAR               VALUE 02.
       78  EXCEPTION-EXCLUIR              VALUE 03.

       01  CAMPOS-W.
           03  STAT-VENDEDORES                PIC  X(02).
               88 VALID-VENDEDORES            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-CODIGO-EDIT           PIC  9(03).
               05 W-NOME                  PIC  X(50).
               05 W-TOTALVENDAS-EDIT      PIC  ZZ9,99.

               05 W-CODIGO                PIC  9(03).

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
           03 LABEL       LINE 04 COL 05
                          TITLE "Código"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-CODIGO-EDIT
                          LINE 04
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 2
			  SIZE 12
                          FONT SMALL-FONT.
           
           03 PUSH-BUTTON TITLE "&Ler o arquivo"
                          LINE 04
                          COL 50
                          SIZE 12
                          ID 5
                          EVENT PROCEDURE EVENTO-BTN-LER-ARQUIVO.

           03 LABEL       LINE 06 COL 05
                          TITLE "Nome"
                          ID 6
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-NOME
                          SIZE 12
                          LINE 06
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 7
                          FONT SMALL-FONT.

           03 LABEL       LINE 08 COL 05
                          TITLE "Total de vendas"
                          ID 8
                          TRANSPARENT.
           
           03 ENTRY-FIELD USING W-TOTALVENDAS-EDIT
                          LINE 08
                          COL 30
                          3-D
                          BOXED
                          AUTO
                          ID 9
			  SIZE 12
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
                          COL 35
                          SIZE 13
                          SELF-ACT
                          ID 16
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION USING CODIGO-L.
       INICIO.
           OPEN I-O VENDEDORES
           IF STAT-VENDEDORES = '35'
              PERFORM PERGUNTA-INICIALIZA
              OPEN OUTPUT VENDEDORES
              CLOSE VENDEDORES
              OPEN I-O VENDEDORES.
           IF NOT VALID-VENDEDORES
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 95 LINES 16,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Cadastro de Vendedores"
                            NO SCROLL
                            SYSTEM MENU
                            AUTO-RESIZE
                            BACKGROUND-LOW
                            HANDLE JANELA-PROGRAMA.

	       MOVE CODIGO-L TO W-CODIGO-EDIT

           DISPLAY TELA-PRINCIPAL.

           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.
           CLOSE VENDEDORES.

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
           MOVE W-CODIGO-EDIT TO W-CODIGO
           IF W-CODIGO = 0
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Vendedor inválido.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              MOVE 4 TO W-ACCEPT-CONTROL
              MOVE 2 TO W-CONTROL-ID |* id do campo onde quero posicionar o cursor
              EXIT PARAGRAPH.

           INITIALIZE             VENDE-REGISTR-1
           MOVE W-CODIGO-EDIT TO VENDE-CODIGO-1
           READ VENDEDORES
           IF STAT-VENDEDORES = '23'
              INITIALIZE             VENDE-REGISTR-1
              MOVE W-CODIGO-EDIT TO VENDE-CODIGO-1
           ELSE
              IF NOT VALID-VENDEDORES
                 PERFORM ERRO-ARQUIVO.

           MOVE W-NOME      TO VENDE-NOME-1
           MOVE W-TOTALVENDAS-EDIT TO VENDE-TOTALVENDAS-1

           INITIALIZE CA-MESSAGE-LINK

           IF STAT-VENDEDORES = '23'
              WRITE VENDE-REGISTR-1
              MOVE 'Registro gravado.' TO CA-MESSAGE-1
           ELSE
              REWRITE VENDE-REGISTR-1
              MOVE 'Registro regravado.' TO CA-MESSAGE-1
           END-IF.

           IF NOT VALID-VENDEDORES
              PERFORM ERRO-ARQUIVO.

           PERFORM MOSTRA-MSG-MENSAGEM.

       ROTINA-EXCLUIR.
           INITIALIZE             VENDE-REGISTR-1
           MOVE W-CODIGO-EDIT TO VENDE-CODIGO-1
           READ VENDEDORES
           IF STAT-VENDEDORES = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Vendedor não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
              EXIT PARAGRAPH
           ELSE
              IF NOT VALID-VENDEDORES
                 PERFORM ERRO-ARQUIVO.

           INITIALIZE CA-MESSAGE-LINK
           MOVE 3 TO CA-MESSAGE-TYPE
           MOVE 22 TO CA-MESSAGE-RESP
           MOVE 'Deseja realmente excluir o registro?' TO CA-MESSAGE-1
           CALL 'CAMESSAG'
           CANCEL 'CAMESSAG'
           IF CA-MESSAGE-RESP = 1
              DELETE VENDEDORES
              IF NOT VALID-VENDEDORES
                 PERFORM ERRO-ARQUIVO
              END-IF
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro excluído.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM

              INITIALIZE CAMPOS-TELA-W
              DISPLAY TELA-PRINCIPAL
           END-IF.

       EVENTO-BTN-LER-ARQUIVO.
           IF EVENT-TYPE <> CMD-GOTO AND CMD-CLICKED
              EXIT PARAGRAPH.

           INITIALIZE        VENDE-REGISTR-1
           MOVE W-CODIGO-EDIT TO VENDE-CODIGO-1
           READ VENDEDORES
           IF STAT-VENDEDORES = '99'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Registro bloqueado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ATENCAO
              EXIT PARAGRAPH.
           IF STAT-VENDEDORES = '23'
              INITIALIZE CA-MESSAGE-LINK
              MOVE 'Vendedor não cadastrado.' TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-MENSAGEM
           ELSE
              IF NOT VALID-VENDEDORES
                 PERFORM ERRO-ARQUIVO.

           MOVE VENDE-NOME-1 TO W-NOME
           MOVE VENDE-TOTALVENDAS-1 TO W-TOTALVENDAS-EDIT

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
IDENTIFICATION  DIVISION.
       PROGRAM-ID.     PRG07.
       ENVIRONMENT     DIVISION.
       CONFIGURATION   SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  SMALL-FONT             HANDLE.

       01  WORK-GERAL.
           03  W-VALOR1            PIC  S9(11)V99.
           03  W-VALOR2            PIC  S9(11)V99.
	   03  W-RES               PIC  S9(11)V99 VALUE 0.
           03  W-RES-EDIT          PIC  ZZ.ZZZ.ZZZ.ZZ9,99-.
           03  W-VALOR1-EDIT       PIC  ZZ.ZZZ.ZZZ.ZZ9,99-.
           03  W-VALOR2-EDIT       PIC  ZZ.ZZZ.ZZZ.ZZ9,99-.
           03  W-AUX               PIC  X.

           03  HANDLE-DA-JANELA   HANDLE.
       
       SCREEN SECTION.
       01  TELA-PRINCIPAL.
           03 LABEL LINE 03 COL 05
                    TITLE "Primeiro valor"
                    TRANSPARENT.
           03 LABEL LINE 05 COL 05
                    TITLE "Segundo valor"
                    TRANSPARENT.
	   03 LABEL LINE 10 COL 05
                    TITLE "RESULTADO"
                    TRANSPARENT.

           03 ENTRY-VALOR1 ENTRY-FIELD
              USING W-VALOR1-EDIT
              LINE 03 COL 24 BOXED
              AUTO
              FONT SMALL-FONT.

           03 ENTRY-VALOR2 ENTRY-FIELD
              USING W-VALOR2-EDIT
              LINE 05 COL 24 BOXED
              AUTO
              FONT SMALL-FONT.

	   03 PUSH-BUTTON
	      TITLE "&Soma"
              LINE 20 COL 05 
              SIZE 12
	      ID 01
	      EVENT PROCEDURE SOMA.
	   03 PUSH-BUTTON
	      TITLE "&Subtração"
              LINE 20 COL 20 
              SIZE 12
	      ID 01
	      EVENT PROCEDURE SUBTRACAO.
	   03 PUSH-BUTTON
	      TITLE "&Multiplicação"
              LINE 20 COL 35 
              SIZE 12
	      ID 01
	      EVENT PROCEDURE MULTIPLICACAO.
	   03 PUSH-BUTTON
	      TITLE "&Divisão"
              LINE 20 COL 50 
              SIZE 12
	      ID 01
	      EVENT PROCEDURE DIVISAO.

       
           03  ENTRY-RESUL ENTRY-FIELD
              USING W-RES-EDIT
              LINE 10 COL 24 BOXED
              AUTO
              FONT SMALL-FONT.
       
           
       PROCEDURE DIVISION.
       INICIO.
           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".

           DISPLAY INITIAL GRAPHICAL WINDOW
                           SIZE 150 LINES 25
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "CALCULADORA"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           AUTO-MINIMIZE
                           BACKGROUND-LOW
                           USER-COLORS
                           HANDLE HANDLE-DA-JANELA.

           DISPLAY TELA-PRINCIPAL.
           ACCEPT TELA-PRINCIPAL.

       SOMA.
           MOVE W-VALOR1-EDIT TO W-VALOR1
           MOVE W-VALOR2-EDIT TO W-VALOR2
	   COMPUTE W-RES = W-VALOR1 + W-VALOR2
           MOVE W-RES TO W-RES-EDIT
           DISPLAY ENTRY-RESUL.
	   ACCEPT TELA-PRINCIPAL.
           

       SUBTRACAO.
           MOVE W-VALOR1-EDIT TO W-VALOR1
           MOVE W-VALOR2-EDIT TO W-VALOR2
	   COMPUTE W-RES = W-VALOR1 - W-VALOR2
           MOVE W-RES TO W-RES-EDIT
	   DISPLAY ENTRY-RESUL.
           ACCEPT TELA-PRINCIPAL.

       MULTIPLICACAO.
           MOVE W-VALOR1-EDIT TO W-VALOR1
           MOVE W-VALOR2-EDIT TO W-VALOR2
	   COMPUTE W-RES = W-VALOR1 * W-VALOR2
           MOVE W-RES TO W-RES-EDIT
	   DISPLAY ENTRY-RESUL.
           ACCEPT TELA-PRINCIPAL.

       DIVISAO.
           MOVE W-VALOR1-EDIT TO W-VALOR1
           MOVE W-VALOR2-EDIT TO W-VALOR2
           IF W-VALOR2 <> 0
		COMPUTE W-RES = W-VALOR1 / W-VALOR2
                MOVE W-RES TO W-RES-EDIT
		DISPLAY ENTRY-RESUL
	   END-IF.

       MOSTRAR.
     
           
           

       FECHAR.
           CLOSE WINDOW HANDLE-DA-JANELA.

           EXIT PROGRAM.
           STOP RUN.
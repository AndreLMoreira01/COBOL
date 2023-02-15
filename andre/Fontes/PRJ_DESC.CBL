       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRJ-DESC.
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
       78  EXCEPTION-CONFIRMAR            VALUE 02.

       01  CAMPOS-W.
           

           03  CAMPOS-TELA-W.
               05 W-OPC-DESC     PIC  9(02) VALUE 1.

      

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

       01  JANELA-PROGRAMA                PIC X(10).

           COPY "MAINRTN.MSG".
           COPY "ACUGUI.DEF".

       LINKAGE SECTION.

       77  W-DESC            PIC X(1).
       77  W-PERC            PIC X(2).
       77  W-TIPO            PIC X(1).

       SCREEN SECTION.
       01  TELA-PRINCIPAL.
          

           03 FRAME    LINE 02,75
                       COL 03
                       LINES 17
                       SIZE 22
                       TITLE "Opções de desconto"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 P5 RADIO-BUTTON
                       TITLE "&5%"
                       LINE 04
                       COL 4
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-OPC-DESC
                       Id 1
                       FONT SMALL-FONT
                       NOTIFY. | gerará um evento ao clicar

           03 P10 RADIO-BUTTON
                       TITLE "%10"
                       LINE 06
                       COL 04
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-DESC
                       ID 3
                       FONT SMALL-FONT
                       NOTIFY.

           
           03 P15 RADIO-BUTTON
                       TITLE "%15"
                       LINE 08
                       COL 04
                       GROUP 1
                       GROUP-VALUE 3
                       USING W-OPC-DESC
                       ID 5
                       FONT SMALL-FONT
                       NOTIFY.

           03 P25 RADIO-BUTTON
                       TITLE "%25"
                       LINE 10
                       COL 04
                       GROUP 1
                       GROUP-VALUE 4
                       USING W-OPC-DESC
                       ID 6
                       FONT SMALL-FONT
                       NOTIFY.

           03 P50 RADIO-BUTTON
                       TITLE "%50"
                       LINE 12
                       COL 04
                       GROUP 1
                       GROUP-VALUE 5
                       USING W-OPC-DESC
                       ID 7
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "Sem desconto"
                       LINE 14
                       COL 04
                       GROUP 1
                       GROUP-VALUE 6
                       USING W-OPC-DESC
                       ID 8
                       FONT SMALL-FONT
                       NOTIFY.



           03 PUSH-BUTTON TITLE "&Confirmar"
                          LINE 16
                          COL 04
                          SIZE 12
                          ID 9
                          EXCEPTION-VALUE EXCEPTION-CONFIRMAR.


       PROCEDURE DIVISION USING W-DESC, W-PERC, W-TIPO.
       INICIO.

         

	   

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".
           
           DISPLAY FLOATING GRAPHICAL WINDOW
                            SIZE 105 LINES 25,5
                            CONTROL FONT SMALL-FONT
                            COLOR 257
                            TITLE "Tabela de descontos"
                            NO SCROLL
                            SYSTEM MENU
                            AUTO-RESIZE
                            BACKGROUND-LOW
                            HANDLE JANELA-PROGRAMA.

           DISPLAY TELA-PRINCIPAL.

	   IF W-TIPO = 1
	      MODIFY P10, ENABLED = FALSE
	      MODIFY P25, ENABLED = FALSE
	      MODIFY P15, ENABLED = FALSE
	      MODIFY P50, ENABLED = FALSE
	   END-IF

	   IF W-TIPO = 2
	      MODIFY P15, ENABLED = FALSE
	      MODIFY P50, ENABLED = FALSE
	      MODIFY P25, ENABLED = FALSE
	   IF W-TIPO = 3
	      MODIFY P50, ENABLED = FALSE
	      MODIFY P25, ENABLED = FALSE
	   IF W-TIPO = 4
	      MODIFY P50, ENABLED = FALSE
	   END-IF


           PERFORM TEST AFTER UNTIL TECLOU-ESC
              ACCEPT TELA-PRINCIPAL
                     ON EXCEPTION PERFORM TRATA-EXCEPTION-TELA-PRINCIPAL
              END-ACCEPT
           END-PERFORM.

       FIM.

           CLOSE WINDOW JANELA-PROGRAMA.


           EXIT PROGRAM
           STOP RUN.


       TRATA-EXCEPTION-TELA-PRINCIPAL.
           IF EVENT-TYPE = CMD-CLOSE
              SET TECLOU-ESC TO TRUE
              EXIT PARAGRAPH.

           EVALUATE TECLA-ESCAPE
             WHEN EXCEPTION-CONFIRMAR
                  PERFORM CONFIRMAR
           END-EVALUATE.

       
       
       CONFIRMAR.
           INITIALIZE W-DESC W-PERC 
          

	   IF W-OPC-DESC = 6
	      MOVE 0 TO W-PERC
	      MOVE 0 TO W-DESC
	   ELSE
	      MOVE W-OPC-DESC TO W-PERC
	      MOVE 1 TO W-DESC
	   END-IF
	   
	   PERFORM FIM.
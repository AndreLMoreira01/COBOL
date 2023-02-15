       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      PRG02.
       ENVIRONMENT      DIVISION.
       CONFIGURATION    SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *77  CONFIRMACAO          PIC X(01) VALUE ''.
      *    88 SIM               VALUE 'S'.
      *    88 NAO               VALUE 'N'.
       01 WORK-GERAL.
           03 VALOR-2DEC        PIC 9(11)V99.
           03 VALOR-4DEC        PIC 9(11)V9(4).
           03 VALOR-6DEC        PIC 9(11)V9(6).
           03 QTD-UNIT          PIC 9(05)V9(6).
           03 PRECO-UNIT        PIC 9(05)V9(6).
           03 PERC-DESCONTO     PIC 9(03)V99 VALUE 15.
           03 VALOR-EDITADO     PIC ZZZ.ZZZ.ZZ9,99-.
           03 CAMPO-AUXILIAR    PIC X(20) VALUE '   100,50'.

           03 X-1               PIC X(01).
           03 WLIN              PIC 9(02).
           03 WCOL              PIC 9(02).

           03 NOME              PIC X(01).
           03 FILLER            PIC X(01).
                88 SIM          VALUE 'S'.
                88 NAO          VALUE 'N'.

           PROCEDURE DIVISION.
           INICIO.
                MOVE ALL 'X' TO WORK-GERAL.
                INITIALIZE WORK-GERAL.

                MOVE ALL 'X' TO WORK-GERAL.
                INITIALIZE WORK-GERAL FILLER.

                MOVE 2 TO WLIN
                MOVE 30 TO WCOL

                MOVE 1,458967 TO PRECO-UNIT
                MOVE 25,75 TO QTD-UNIT
                MOVE 15 TO PERC-DESCONTO

                COMPUTE VALOR-2DEC ROUNDED = QTD-UNIT * PRECO-UNIT *
                                             PERC-DESCONTO / 100
                COMPUTE VALOR-4DEC ROUNDED = QTD-UNIT * 
                                             PRECO-UNIT *
                                             PERC-DESCONTO / 100
                COMPUTE VALOR-6DEC ROUNDED = QTD-UNIT * 
                                             PRECO-UNIT *
                                             PERC-DESCONTO / 100

                MOVE '   725,89' TO CAMPO-AUXILIAR
                MOVE 123,45 TO VALOR-2DEC

                MOVE CAMPO-AUXILIAR TO VALOR-2DEC
                MOVE CAMPO-AUXILIAR TO VALOR-2DEC CONVERT.

                MOVE 'MARIA1,75' TO CAMPO-AUXILIAR.
                MOVE CAMPO-AUXILIAR TO VALOR-2DEC
                MOVE CAMPO-AUXILIAR TO VALOR-2DEC CONVERT.

                EXIT PROGRAM.
                STOP RUN.

                                           


       




















































































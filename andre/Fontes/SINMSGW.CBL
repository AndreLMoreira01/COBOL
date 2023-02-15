       IDENTIFICATION       DIVISION.
       PROGRAM-ID.          SINMSGW.
       AUTHOR.              PAULO/EDILSON.

             | Confirmacao de mensagens
             |
             | Parametros :
             |
             | Titulo       - Titulo da mensagem    ( Default "Mensagem !" )
             | Mensagem 1   - Descricao da 1 linha de mensagem
             | Mensagem 2   - Descricao da 2 linha de mensagem
             | Mensagem 3   - Descricao da 3 linha de mensagem
             | Mensagem 4   - Descricao da 4 linha de mensagem
             | Mensagem 5   - Descricao da 5 linha de mensagem
             | Botao    1   - Titulo do 1o. botao
             | Botao    2   - Titulo do 1o. botao
             | Botao    3   - Titulo do 1o. botao
             | Botao    4   - Titulo do 1o. botao
             | Botao    5   - Titulo do 1o. botao
             | Botao padrao - Botao inicial para accept
             | Tipo de msg  - Infomar "i", "!", "?", "x" ou "!!", onde :
             |                "i" = mensagens apenas informativas
             |                "!" = mensagem de atencao
             |                "?" = pergunta
             |                "x" = erro
             |                "!!" = mensagem de atencao piscando
             |              - Informar uma literal numerica, e sera' apresenta-
             |                do o bitmap de numero informado (SINMSGW.BMP)
             |              - Na ausencia desse parametro sera' apresentado
             |                o bitmap default do Sinc.
             |
             | OBS : Um '*' na posicao 20 do botao desabilita o botao.
             |
             | IMPORTANTE: se a environment "SINMSGW-DESATIVADO" for igual a "1"
             |             indica que o programa SINMSGW não deve ser acionado.
             |             Normalmente será utilizado pelo Sinc, no ponto onde
             |             aciona os inicializadores de arquivos, para que estes
             |             nao dêem mensagens indicando que os arquivos estão
             |             inicializados.

       ENVIRONMENT DIVISION.
       SPECIAL-NAMES.
            SCREEN CONTROL IS SCREEN-CONTROL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       78  78-COL-MSG                   VALUE 12.
       78  78-PIXELS-ESPACO-ENTRE-BOTOES VALUE 4.

       01  SCREEN-CONTROL.
           03  ACCEPT-CONTROL           PIC 9.
           03  CONTROL-VALUE            PIC 999.
           03  CONTROL-HANDLE           USAGE HANDLE.
           03  CONTROL-ID               PIC X(2) COMP-X.

       01  SV-CURSOR-MODE               PIC 9(01).

       01  SV-WINDOWS-G                 HANDLE OF WINDOW.
       01  SV-LINEWIN-G                 PIC 9(005)V99 VALUE ZEROS.
       01  SV-SIZEWIN-G                 PIC 9(005)  VALUE 70.
       01  SV-COLUNA1-G                 PIC S9(05)V99  VALUE ZEROS.
       01  SV-COLUNA2-G                 PIC S9(05)V99  VALUE ZEROS.
       01  SV-COLUNA3-G                 PIC S9(05)V99  VALUE ZEROS.
       01  SV-COLUNA4-G                 PIC S9(05)V99  VALUE ZEROS.
       01  SV-COLUNA5-G                 PIC S9(05)V99  VALUE ZEROS.

       01  SV-VISIBLE-G.
           03  SV-VISIBL1-G                 PIC 9(001)  VALUE 1.
           03  SV-VISIBL2-G                 PIC 9(001)  VALUE 1.
           03  SV-VISIBL3-G                 PIC 9(001)  VALUE 1.
           03  SV-VISIBL4-G                 PIC 9(001)  VALUE 1.
           03  SV-VISIBL5-G                 PIC 9(001)  VALUE 1.
       01  FILLER REDEFINES SV-VISIBLE-G.
           03  SV-VISIBLE-T PIC 9(001) OCCURS 5 TIMES.

       01  SV-ENABLED-G.
           03  SV-ENABLE1-G                 PIC 9(001)  VALUE 1.
           03  SV-ENABLE2-G                 PIC 9(001)  VALUE 1.
           03  SV-ENABLE3-G                 PIC 9(001)  VALUE 1.
           03  SV-ENABLE4-G                 PIC 9(001)  VALUE 1.
           03  SV-ENABLE5-G                 PIC 9(001)  VALUE 1.
       01  FILLER REDEFINES SV-ENABLED-G.
           03  SV-ENABLED-T PIC 9(001) OCCURS 5 TIMES.


       01  SV-COLUNAS-G                 PIC 9(005)  VALUE 0.

       01  SV-HANDLES-G                 PIC S9(009) USAGE COMP-4.

       01  SV-TITULOS                 PIC X(100) VALUE SPACES.

       01  SV-MESSAGE-G.
           05  SV-MESSAGE-1                 PIC X(100) VALUE SPACES.
           05  SV-MESSAGE-2                 PIC X(100) VALUE SPACES.
           05  SV-MESSAGE-3                 PIC X(100) VALUE SPACES.
           05  SV-MESSAGE-4                 PIC X(100) VALUE SPACES.
           05  SV-MESSAGE-5                 PIC X(100) VALUE SPACES.
       01  FILLER REDEFINES SV-MESSAGE-G.
           05  SV-MESSAGE-T                 PIC X(100) OCCURS 5 TIMES.

       01  SV-BUTTONS-G.
           03  SV-BUTTONS-1                 PIC X(030) VALUE SPACES.
           03  SV-BUTTONS-2                 PIC X(030) VALUE SPACES.
           03  SV-BUTTONS-3                 PIC X(030) VALUE SPACES.
           03  SV-BUTTONS-4                 PIC X(030) VALUE SPACES.
           03  SV-BUTTONS-5                 PIC X(030) VALUE SPACES.
       01  FILLER REDEFINES SV-BUTTONS-G.
           03  SV-BUTTONS-T PIC X(030) OCCURS 5 TIMES.


       01  STYLE-BUTTON-W.
           03  STYLE-BUTTON-1               PIC 9(09).
           03  STYLE-BUTTON-2               PIC 9(09).
           03  STYLE-BUTTON-3               PIC 9(09).
           03  STYLE-BUTTON-4               PIC 9(09).
           03  STYLE-BUTTON-5               PIC 9(09).
       01  FILLER REDEFINES STYLE-BUTTON-W.
           03  STYLE-BUTTON-T               PIC 9(09) OCCURS 5.

       01  W-DEFAULT-BUTTON                 PIC 9(001) VALUE 0.
       01  SV-DEFAULT-BUTTON                PIC 9(001) VALUE 0.
       01  SV-TPSINAL-G                 PIC X(002) VALUE ' '.
       01  SV-TPSINAL-N                 PIC 9(002) VALUE 0.

       01  SV-PARSIZE-G                 PIC 9(005) VALUE 0.
       01  SV-PARSIZE-D.
           03 SV-PARSIZE-T              PIC 9(005) OCCURS 13.

       01  IND                          PIC 9(005) VALUE ZEROS.
       01  IND-BTN                      PIC 9(005) VALUE ZEROS.
       01  W-BMP-START                  PIC 9(002) VALUE ZEROS.
       01  W-BMP-END                    PIC 9(002) VALUE ZEROS.
       01  MAX-COL-MSG                  PIC 9(05)V99 VALUE ZEROS.
       01  MAX-COL-BTN                  PIC 9(05)V99 VALUE ZEROS.
       01  QTD-BOTOES                   PIC 9(002) VALUE ZEROS.
       01  W-VISIBLE                    PIC 9(001) VALUE ZEROS.
       01  MAX-PIXELS-BTN               PIC 9(004) VALUE ZEROS.
       01  W-SIZE-BTN                   PIC 9(003) VALUE 0.

       01  SV-NUMLINH-G                 PIC 9(005)v99 VALUE ZEROS.

       01  ONE-CHAR                     PIC X(001).

       01  BINARIO                      PIC 9 COMP-X.
       01  FILLER REDEFINES BINARIO.
           03 CARACTER                  PIC X.

       01  CONT                         PIC 9(03).
       01  LINHA-BMP                    PIC 9(02)V99.
       01  QTD-LINHAS-MSG               PIC 9(02).

       01  X-1                          PIC X(100).
       01  X-2                          PIC X(100).
       01  N-1                          PIC 9(01).

       01  SV-MOUSE-SHAPE               PIC 9(01).

       01  THREAD-IMAGEM                HANDLE OF THREAD.

       01  W-HANDLE-IMG                 HANDLE.

       01  W-HANDLE-LABELS.
           03 W-HANDLE-LABEL-T          HANDLE OCCURS 5.

       01  JANELA-PRINCIPAL             PIC X(10) EXTERNAL.

       COPY "SINWRK.CPY".
       COPY "ACUGUI.DEF".
       COPY "ACUCOBOL.DEF".
       COPY "CONTROLS.DEF".
       COPY "MAINRTN.CIV".
       COPY "MAINRTN.CBV".
           88  ABORT-KEY                VALUE 27.
       COPY "MAINRTN.KEY".
           88  EVENT-OCCURS             VALUE 96.
           88  END-KEY                  VALUE 79.
           88  HOME-KEY                 VALUE 71.
       COPY "MAINRTN.MSG".

       COPY RESOURCE "SINMSGW.BMP".

       LINKAGE SECTION.
       01  M010-TITULOS-L           PIC X(100).
       01  M010-MESSAG1-L           PIC X(100).
       01  M010-MESSAG2-L           PIC X(100).
       01  M010-MESSAG3-L           PIC X(100).
       01  M010-MESSAG4-L           PIC X(100).
       01  M010-MESSAG5-L           PIC X(100).
       01  M010-BUTTON1-L           PIC X(030).
       01  M010-BUTTON2-L           PIC X(030).
       01  M010-BUTTON3-L           PIC X(030).
       01  M010-BUTTON4-L           PIC X(030).
       01  M010-BUTTON5-L           PIC X(030).
       01  M010-NUMBUTT-L           PIC X(002).
       01  M010-TPSINAL-L           PIC X(002).

       SCREEN SECTION.

       01  TELA01-DATA.
           03 PUSH-BUTTON1      PUSH-BUTTON
              VISIBLE IS SV-VISIBL1-G
              ENABLED IS SV-ENABLE1-G
              TITLE             SV-BUTTONS-1
              LINE              SV-NUMLINH-G
              COL               SV-COLUNA1-G
              ID 001
              SIZE              W-SIZE-BTN
              LINES 1.25
              SELF-ACT
              STYLE STYLE-BUTTON-1
              EXCEPTION-VALUE 201.

           03 PUSH-BUTTON2      PUSH-BUTTON
              VISIBLE IS SV-VISIBL2-G
              ENABLED IS SV-ENABLE2-G
              TITLE             SV-BUTTONS-2
              LINE              SV-NUMLINH-G
              COL               SV-COLUNA2-G
              ID 002
              SIZE              W-SIZE-BTN
              LINES 1.25
              SELF-ACT
              STYLE STYLE-BUTTON-2
              EXCEPTION-VALUE 202.

           03 PUSH-BUTTON3      PUSH-BUTTON
              VISIBLE IS SV-VISIBL3-G
              ENABLED IS SV-ENABLE3-G
              TITLE             SV-BUTTONS-3
              LINE              SV-NUMLINH-G
              COL               SV-COLUNA3-G
              ID 003
              SIZE              W-SIZE-BTN
              LINES 1.25
              SELF-ACT
              STYLE STYLE-BUTTON-3
              EXCEPTION-VALUE 203.

           03 PUSH-BUTTON4      PUSH-BUTTON
              VISIBLE IS SV-VISIBL4-G
              ENABLED IS SV-ENABLE4-G
              TITLE             SV-BUTTONS-4
              LINE              SV-NUMLINH-G
              COL               SV-COLUNA4-G
              ID 004
              SIZE              W-SIZE-BTN
              LINES 1.25
              SELF-ACT
              STYLE STYLE-BUTTON-4
              EXCEPTION-VALUE 204.

           03 PUSH-BUTTON5      PUSH-BUTTON
              VISIBLE IS SV-VISIBL5-G
              ENABLED IS SV-ENABLE5-G
              TITLE             SV-BUTTONS-5
              LINE              SV-NUMLINH-G
              COL               SV-COLUNA5-G
              ID = 005
              SIZE              W-SIZE-BTN
              LINES 1.25
              SELF-ACT
              STYLE STYLE-BUTTON-5
              EXCEPTION-VALUE 205.

       PROCEDURE DIVISION USING M010-TITULOS-L,
                                M010-MESSAG1-L,
                                M010-MESSAG2-L,
                                M010-MESSAG3-L,
                                M010-MESSAG4-L,
                                M010-MESSAG5-L,
                                M010-BUTTON1-L,
                                M010-BUTTON2-L,
                                M010-BUTTON3-L,
                                M010-BUTTON4-L,
                                M010-BUTTON5-L,
                                M010-NUMBUTT-L,
                                M010-TPSINAL-L.

       000-00-ROTINICIAL SECTION.
       000-05-ROTINICIAL.

           INITIALIZE WSIN-RETORNO-W

           CALL 'W$MOUSE' USING GET-MOUSE-SHAPE
           MOVE RETURN-CODE TO SV-MOUSE-SHAPE.
           CALL 'W$MOUSE' USING SET-MOUSE-SHAPE, ARROW-POINTER.

           CALL   'C$NARG' USING SV-ARGUMEN.
           CANCEL 'C$NARG'.

           IF SV-ARGUMEN < 7
              MOVE 'SINMSGW: Número inválido de argumentos.'
                   TO CA-MESSAGE-1
              PERFORM MOSTRA-MSG-ERRO
              PERFORM FECHA-TUDO
           END-IF.

           MOVE 6.5 TO SV-LINEWIN-G.

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 13
              IF IND <= SV-ARGUMEN
                 CALL 'C$PARAMSIZE' USING IND GIVING SV-PARSIZE-T(IND)
              END-IF
           END-PERFORM
           CANCEL 'C$PARAMSIZE'.

           IF SV-PARSIZE-T(1) > 100
              MOVE 100 TO SV-PARSIZE-T(1).
           IF SV-PARSIZE-T(2) > 100
              MOVE 100 TO SV-PARSIZE-T(2).
           IF SV-PARSIZE-T(3) > 100
              MOVE 100 TO SV-PARSIZE-T(3).
           IF SV-PARSIZE-T(4) > 100
              MOVE 100 TO SV-PARSIZE-T(4).
           IF SV-PARSIZE-T(5) > 100
              MOVE 100 TO SV-PARSIZE-T(5).
           IF SV-PARSIZE-T(6) > 100
              MOVE 100 TO SV-PARSIZE-T(6).
           IF SV-PARSIZE-T(7) > 30
              MOVE 30 TO SV-PARSIZE-T(7).
           IF SV-PARSIZE-T(8) > 30
              MOVE 30 TO SV-PARSIZE-T(8).
           IF SV-PARSIZE-T(9) > 30
              MOVE 30 TO SV-PARSIZE-T(9).
           IF SV-PARSIZE-T(10) > 30
              MOVE 30 TO SV-PARSIZE-T(10).
           IF SV-PARSIZE-T(11) > 30
              MOVE 30 TO SV-PARSIZE-T(11).
           IF SV-PARSIZE-T(12) > 2
              MOVE 2 TO SV-PARSIZE-T(12).
           IF SV-PARSIZE-T(13) > 2
              MOVE 2 TO SV-PARSIZE-T(13).

           MOVE 0 TO IND-BTN
           MOVE SPACES TO SV-BUTTONS-G.

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 13
              MOVE SV-PARSIZE-T(IND) TO SV-PARSIZE-G
              IF SV-PARSIZE-G > 0
                 EVALUATE IND
                    WHEN  1
                          MOVE M010-TITULOS-L(1:SV-PARSIZE-G)
                               TO SV-TITULOS
                    WHEN  2
                          MOVE M010-MESSAG1-L(1:SV-PARSIZE-G)
                               TO SV-MESSAGE-1
                          IF SV-MESSAGE-1 NOT = SPACES
                             ADD  1 TO SV-LINEWIN-G
                          END-IF
                    WHEN  3
                          MOVE M010-MESSAG2-L(1:SV-PARSIZE-G)
                               TO SV-MESSAGE-2
                          IF SV-MESSAGE-2 NOT = SPACES
                             ADD  1 TO SV-LINEWIN-G
                          END-IF
                    WHEN  4
                          MOVE M010-MESSAG3-L(1:SV-PARSIZE-G)
                               TO SV-MESSAGE-3
                          IF SV-MESSAGE-3 NOT = SPACES
                             ADD  1 TO SV-LINEWIN-G
                          END-IF
                    WHEN  5
                          MOVE M010-MESSAG4-L(1:SV-PARSIZE-G)
                               TO SV-MESSAGE-4
                          IF SV-MESSAGE-4 NOT = SPACES
                             ADD  1 TO SV-LINEWIN-G
                          END-IF
                    WHEN  6
                          MOVE M010-MESSAG5-L(1:SV-PARSIZE-G)
                               TO SV-MESSAGE-5
                          IF SV-MESSAGE-5 NOT = SPACES
                             ADD  1 TO SV-LINEWIN-G
                          END-IF
                    WHEN  7
                          IF M010-BUTTON1-L(1:SV-PARSIZE-G) NOT = ' '
                             ADD 1 TO IND-BTN
                             MOVE M010-BUTTON1-L(1:SV-PARSIZE-G)
                                  TO SV-BUTTONS-T(IND-BTN)
                          END-IF
                    WHEN  8
                          IF M010-BUTTON2-L(1:SV-PARSIZE-G) NOT = ' '
                             ADD 1 TO IND-BTN
                             MOVE M010-BUTTON2-L(1:SV-PARSIZE-G)
                                  TO SV-BUTTONS-T(IND-BTN)
                          END-IF
                    WHEN  9
                          IF M010-BUTTON3-L(1:SV-PARSIZE-G) NOT = ' '
                             ADD 1 TO IND-BTN
                             MOVE M010-BUTTON3-L(1:SV-PARSIZE-G)
                                  TO SV-BUTTONS-T(IND-BTN)
                          END-IF
                    WHEN  10
                          IF M010-BUTTON4-L(1:SV-PARSIZE-G) NOT = ' '
                             ADD 1 TO IND-BTN
                             MOVE M010-BUTTON4-L(1:SV-PARSIZE-G)
                                  TO SV-BUTTONS-T(IND-BTN)
                          END-IF
                    WHEN  11
                          IF M010-BUTTON5-L(1:SV-PARSIZE-G) NOT = ' '
                             ADD 1 TO IND-BTN
                             MOVE M010-BUTTON5-L(1:SV-PARSIZE-G)
                                  TO SV-BUTTONS-T(IND-BTN)
                          END-IF
                    WHEN  12
                          MOVE M010-NUMBUTT-L(1:SV-PARSIZE-G)
                               TO W-DEFAULT-BUTTON CONVERT
                    WHEN  13
                          MOVE M010-TPSINAL-L(1:SV-PARSIZE-G)
                               TO SV-TPSINAL-G
                          MOVE SV-TPSINAL-G TO SV-TPSINAL-N CONVERT
              END-EVALUATE
           END-PERFORM.

           IF W-DEFAULT-BUTTON = 0
              MOVE 1 TO W-DEFAULT-BUTTON.

           CALL "C$TOUPPER" USING SV-TPSINAL-G, VALUE 1

           MOVE ZEROS TO W-BMP-START W-BMP-END.

           IF SV-TPSINAL-G = "!" OR "?" OR "X" OR "!!" OR "I"
              EVALUATE SV-TPSINAL-G
                WHEN "!"
                     MOVE 1 TO W-BMP-START
                     IF SV-TITULOS = SPACES
                        MOVE 'Atenção' TO SV-TITULOS
                     END-IF
                WHEN "?"
                     MOVE 3 TO W-BMP-START
                     IF SV-TITULOS = SPACES
                        MOVE 'Mensagem' TO SV-TITULOS
                     END-IF
                WHEN "I"
                     MOVE 4 TO W-BMP-START
                     IF SV-TITULOS = SPACES
                        MOVE 'Mensagem' TO SV-TITULOS
                     END-IF
                WHEN "X"
                     MOVE 5 TO W-BMP-START
                     IF SV-TITULOS = SPACES
                        MOVE 'Erro' TO SV-TITULOS
                     END-IF
                WHEN OTHER
                     MOVE 1 TO W-BMP-START
                     MOVE 2 TO W-BMP-END
                     IF SV-TITULOS = SPACES
                        MOVE 'Atenção' TO SV-TITULOS
                     END-IF
              END-EVALUATE
           ELSE
              IF SV-TPSINAL-N NOT = ZEROS
                 MOVE SV-TPSINAL-N TO W-BMP-START
              ELSE
                 IF QTD-BOTOES = 1
                    MOVE 4 TO W-BMP-START
                 ELSE
                    MOVE 3 TO W-BMP-START.

           IF SV-TITULOS = SPACES
              MOVE 'Mensagem' TO SV-TITULOS.

           ACCEPT WSIN-X256 FROM ENVIRONMENT "SINMSGW-DESATIVADO"
           IF WSIN-X256 = '1'
              |* IMPORTANTE: esse procedimento deve ser colocado apos
              |* o processamento dos argumentos de entrada e montagem do
              |* titulo da janela
              |*
              |* assumo que o primeiro botao foi clicado, para os casos de 
              |* programas que pedem confirmacao de inicializacao (como e'
              |* o caso do CTB999)
              MOVE 1 TO WSIN-RETORNO-W
              |* coloco a mensagem que seria exibida em environments, de
              |* forma que o programa que desabilitou a exibicao de mensagens
              |* possa capturar essas informacoes
              |* OBS: se mudar alguma coisa aqui, acertar o CTB518A, que limpa
              |*      essas mensagens...
              SET ENVIRONMENT "SINMSGW-TIT-MSG-NAO-EXIBIDA"
                              TO SV-TITULOS
              PERFORM VARYING N-1 FROM 1 BY 1 UNTIL N-1 > 5
                 MOVE SPACES TO WSIN-X256
                 STRING "SINMSGW-MSG-NAO-EXIBIDA-" N-1
                   DELIMITED SIZE INTO WSIN-X256
                 SET ENVIRONMENT WSIN-X256 TO SV-MESSAGE-T(N-1)
              END-PERFORM
              PERFORM FECHA-TUDO
           END-IF.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT 'SMALL-FONT'.

           MOVE 0 TO MAX-COL-MSG QTD-LINHAS-MSG

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
              IF SV-MESSAGE-T(IND) NOT = SPACES
                 ADD 1 TO QTD-LINHAS-MSG
                 MOVE SMALL-FONT TO TEXTSIZE-FONT
                 SET TEXTSIZE-STRIP-SPACES TO TRUE
                 CALL "W$TEXTSIZE" USING SV-MESSAGE-T(IND),
                                         TEXTSIZE-DATA
                 IF TEXTSIZE-SIZE-X > MAX-COL-MSG
                    MOVE TEXTSIZE-SIZE-X TO MAX-COL-MSG
                 END-IF
              END-IF
           END-PERFORM.

           MOVE 0 TO QTD-BOTOES MAX-PIXELS-BTN

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
              IF SV-BUTTONS-T(IND) NOT = SPACES
                 ADD 1 TO QTD-BOTOES
                 MOVE SMALL-FONT TO TEXTSIZE-FONT
                 SET TEXTSIZE-STRIP-SPACES TO TRUE
                 CALL "W$TEXTSIZE" USING SV-BUTTONS-T(IND),
                                         TEXTSIZE-DATA
                 IF TEXTSIZE-BASE-X > MAX-PIXELS-BTN
                    MOVE TEXTSIZE-BASE-X TO MAX-PIXELS-BTN
                 END-IF
              END-IF
           END-PERFORM.

           ADD 8 TO MAX-PIXELS-BTN   |* espaco das bordas

           MOVE SMALL-FONT TO TEXTSIZE-FONT
           SET TEXTSIZE-STRIP-SPACES TO TRUE
           CALL "W$TEXTSIZE" USING '0', TEXTSIZE-DATA

           IF MAX-PIXELS-BTN < 98
              MOVE 98 TO MAX-PIXELS-BTN.

           COMPUTE W-SIZE-BTN ROUNDED = MAX-PIXELS-BTN /
                                        TEXTSIZE-BASE-X

           IF W-SIZE-BTN < 15
              MOVE 15 TO W-SIZE-BTN.

           COMPUTE MAX-COL-BTN = (QTD-BOTOES * W-SIZE-BTN) +
                                 ((QTD-BOTOES - 1) * 2)

           IF MAX-COL-BTN > MAX-COL-MSG
              MOVE MAX-COL-BTN TO MAX-COL-MSG.

           COMPUTE SV-SIZEWIN-G = 78-COL-MSG + MAX-COL-MSG + 2

           COMPUTE SV-COLUNA1-G ROUNDED = (SV-SIZEWIN-G - MAX-COL-BTN)
                                          / 2 + 1
           IF SV-COLUNA1-G < 1
              MOVE 1 TO SV-COLUNA1-G.

           COMPUTE SV-COLUNA2-G = SV-COLUNA1-G + W-SIZE-BTN + 2
           COMPUTE SV-COLUNA3-G = SV-COLUNA2-G + W-SIZE-BTN + 2
           COMPUTE SV-COLUNA4-G = SV-COLUNA3-G + W-SIZE-BTN + 2
           COMPUTE SV-COLUNA5-G = SV-COLUNA4-G + W-SIZE-BTN + 2

           PERFORM ROTINA-ACCEPT.

       FECHA-TUDO.
           CALL 'W$MOUSE' USING SET-MOUSE-SHAPE, SV-MOUSE-SHAPE.

           COPY 'FINALIZA.CPY'.
           EXIT PROGRAM WSIN-RETORNO-W.
           STOP RUN.

       ROTINA-ACCEPT.
           ACCEPT SV-CURSOR-MODE FROM ENVIRONMENT "CURSOR-MODE"
           SET ENVIRONMENT "CURSOR-MODE" TO "2"

           IF SINC-WIN-XP
              PERFORM DISPLAY-NULL-WINDOW.

           PERFORM DISPLAY-WINDOW.

           COMPUTE LINHA-BMP = 2 + ((QTD-LINHAS-MSG - 1) * 0.5)

           PERFORM MOSTRA-IMAGEM

           MOVE 2.5 TO SV-NUMLINH-G

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
              IF SV-MESSAGE-T(IND) NOT = SPACES
                 DISPLAY LABEL SV-MESSAGE-T(IND) UPON SV-WINDOWS-G
                               LINE SV-NUMLINH-G
                               COL  78-COL-MSG
                               HANDLE IN W-HANDLE-LABEL-T(IND)
                 ADD  1 TO SV-NUMLINH-G
              END-IF
           END-PERFORM.

           ADD 1 TO SV-NUMLINH-G

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
              IF ( SV-BUTTONS-T(IND) = SPACES    )
                 INITIALIZE SV-VISIBLE-T(IND)
              ELSE
                 MOVE 1  TO SV-VISIBLE-T(IND)
              END-IF
              IF ( SV-BUTTONS-T(IND)(20:1) = '*' )
                 INITIALIZE SV-ENABLED-T(IND)
                 MOVE ' ' TO SV-BUTTONS-T(IND)(20:1)
              END-IF
           END-PERFORM.

           ADD 1.25 TO SV-NUMLINH-G.

      *    ACCEPT OMITTED BEFORE TIME 1

           IF ENTER-ATIVADO
              PERFORM SINC-SET-ENTER-DEFAULT-ACUCOBOL.

           |* loop para "gastar" as escapes que estiverem armazenadas no
           |* buffer do teclado...
           PERFORM TEST AFTER UNTIL CA-KEY-ENTERED = 99
              ACCEPT X-1 AT 0101 CONTROL KEY CA-KEY-ENTERED
                                 BEFORE TIME 0
                                 AUTO-SKIP
                                 NO-ECHO
           END-PERFORM
           MOVE 0 TO CA-KEY-ENTERED.

           MOVE W-DEFAULT-BUTTON TO CONTROL-VALUE
           MOVE 1                TO ACCEPT-CONTROL
           MOVE 0                TO CA-KEY-ENTERED
                                    SV-DEFAULT-BUTTON

           PERFORM TEST AFTER UNTIL WSIN-RETORNO-W <> 0
              IF W-DEFAULT-BUTTON NOT = SV-DEFAULT-BUTTON
                 INITIALIZE STYLE-BUTTON-W
                 MOVE PBS-DEFAULT-BUTTON TO
                          STYLE-BUTTON-T(W-DEFAULT-BUTTON)
                 DISPLAY TELA01-DATA UPON SV-WINDOWS-G
                 IF SV-DEFAULT-BUTTON = 0
                    MODIFY WINDOW SV-WINDOWS-G, VISIBLE = TRUE
                 END-IF
                 MOVE W-DEFAULT-BUTTON TO SV-DEFAULT-BUTTON
              END-IF

              ACCEPT ONE-CHAR AT 0101
                              NO-ECHO
                              AUTO-SKIP
                              CONTROL KEY CA-KEY-ENTERED
                     ON EXCEPTION
                        CONTINUE
              END-ACCEPT
              
              IF WSIN-VERSRUN-G >= 5.2
                 |* Importante, senao no ACUTHIN 7.0 da' problema
                 |* (se perde no retorno)
                 CALL 'W$FLUSH' USING 1
              END-IF
              
              IF ONE-CHAR = ' ' AND CA-KEY-ENTERED = 0
                 |* teclou barra de espacos
                 PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
                    IF STYLE-BUTTON-T(IND) = PBS-DEFAULT-BUTTON
                       COMPUTE CA-KEY-ENTERED = 200 + IND
                       EXIT PERFORM
                    END-IF
                 END-PERFORM
              END-IF

              IF CA-KEY-ENTERED = 99
                 |* esgotou o timeout
                 EXIT PERFORM
              END-IF

              IF ONE-CHAR NOT = SPACES
                 CALL 'C$TOUPPER' USING ONE-CHAR, VALUE 1
                 PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
                    IF SV-BUTTONS-T(IND) NOT = SPACES
                       MOVE 0 TO CONT
                       INSPECT SV-BUTTONS-T(IND) TALLYING CONT
                                                 FOR ALL '&'
                       IF CONT NOT = ZEROS
                          UNSTRING SV-BUTTONS-T(IND) DELIMITED '&'
                                   INTO X-1 X-2
                          CALL 'C$TOUPPER' USING X-2(1:1), VALUE 1
                          IF ONE-CHAR = X-2(1:1) AND
                             SV-ENABLED-T(IND) = 1
                             COMPUTE CA-KEY-ENTERED = 200 + IND
                             EXIT PERFORM
                          END-IF
                       END-IF
                    END-IF
                 END-PERFORM
              END-IF

              IF CA-KEY-ENTERED >= 201 AND <= 205
                 COMPUTE WSIN-RETORNO-W = CA-KEY-ENTERED - 200
              END-IF

              IF CA-KEY-ENTERED = 77
                 IF W-DEFAULT-BUTTON = QTD-BOTOES
                    MOVE 1 TO W-DEFAULT-BUTTON
                 ELSE
                    ADD 1 TO W-DEFAULT-BUTTON
                 END-IF
              ELSE
                 IF CA-KEY-ENTERED = 75
                    IF W-DEFAULT-BUTTON = 1
                       MOVE QTD-BOTOES TO W-DEFAULT-BUTTON
                    ELSE
                       SUBTRACT 1 FROM W-DEFAULT-BUTTON
                    END-IF
                 END-IF
              END-IF
           END-PERFORM.

           IF ENTER-ATIVADO
              PERFORM SINC-SET-ATIVAR-ENTER.

           SET ENVIRONMENT "CURSOR-MODE" TO SV-CURSOR-MODE

           DESTROY W-HANDLE-IMG.

           PERFORM VARYING IND FROM 1 BY 1 UNTIL IND > 5
              IF SV-MESSAGE-T(IND) NOT = SPACES
                 DESTROY W-HANDLE-LABEL-T(IND)
              END-IF
           END-PERFORM.

           CALL "W$BITMAP" USING WBITMAP-DESTROY,
                                 SV-HANDLES-G.

           DESTROY SV-WINDOWS-G.

       MOSTRA-IMAGEM.
           IF W-BMP-START NOT = 0
              CALL 'W$BITMAP' USING WBITMAP-LOAD,
                                    'SINMSGW.BMP'
                              GIVING SV-HANDLES-G
              IF W-BMP-END = 0
                 display bitmap
                         upon SV-WINDOWS-G
                         bitmap-handle = SV-HANDLES-G
                         size 34
                         lines 34
                         bitmap-number W-BMP-START
                         line LINHA-BMP
                         column 3
                         handle in w-handle-img
              ELSE
                 display bitmap
                         upon SV-WINDOWS-G
                         bitmap-handle = SV-HANDLES-G
                         size 34
                         lines 34
                         bitmap-start W-BMP-START
                         bitmap-end   W-BMP-END
                         bitmap-timer 25
                         line LINHA-BMP
                         column 3
                         handle in w-handle-img.

       DISPLAY-WINDOW.
           MOVE 1 TO W-VISIBLE.

           IF JANELA-PRINCIPAL = SPACES OR LOW-VALUES
              |* ainda nao exibiu a tela do menu do Sinc
              DISPLAY INDEPENDENT GRAPHICAL WINDOW
                      SIZE SV-SIZEWIN-G
                      LINES SV-LINEWIN-G
                      CONTROL FONT SMALL-FONT
                      COLOR 257
                      |* TITLE-BAR
                      TITLE SV-TITULOS
                      BACKGROUND-LOW
                      VISIBLE W-VISIBLE
                      HANDLE SV-WINDOWS-G
           ELSE
              DISPLAY FLOATING GRAPHICAL WINDOW
                      SIZE SV-SIZEWIN-G
                      LINES SV-LINEWIN-G
                      CONTROL FONT SMALL-FONT
                      COLOR 257 TITLE-BAR
                      TITLE SV-TITULOS
                      BACKGROUND-LOW
                      BIND TO THREAD
                      VISIBLE W-VISIBLE
                      HANDLE SV-WINDOWS-G.

       DISPLAY-NULL-WINDOW.
           DISPLAY FLOATING WINDOW
                   LINES           1
                   SIZE            5
                   HANDLE          SV-WINDOWS-G.

           ACCEPT ONE-CHAR AT 0101
                           NO-ECHO
                           AUTO-SKIP
                           BEFORE TIME 0
                           CONTROL KEY CA-KEY-ENTERED
                  ON EXCEPTION
                     CONTINUE
           END-ACCEPT

           CLOSE WINDOW SV-WINDOWS-G.


       COPY "SINFIM.CPY".
       COPY "SINKEYP.CPY".

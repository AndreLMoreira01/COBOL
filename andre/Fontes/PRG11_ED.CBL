       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRG11C_ED.
       AUTHOR.        ESTAGIÁRIOS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           copy "cadfun.sl".

           SELECT SORTER ASSIGN TO 'SORTER.ARQ'
                  FILE STATUS   IS STAT-SORTER.

           SELECT PRINTF ASSIGN TO PRINTER
                  FILE STATUS IS STAT-PRINTF.

       DATA DIVISION.
       FILE SECTION.

           copy "cadfun.fd".

       FD  PRINTF LABEL RECORD OMITTED.
 
       01  PRINTF-R                       PIC X(255).
       
       SD  SORTER.

       01  SORT-REGISTR-1.
           03  SORT-EMPRESA-1             PIC  9(03).
           03  SORT-CODFUNC-1             PIC  9(06).
           03  SORT-NOMEFUN-1             PIC  X(60).
           03  SORT-CENTCUS-1             PIC  9(06).
           03  SORT-DATADMI-1             PIC  9(08).
           03  SORT-SALARIO-1             PIC  9(11)V99.

       WORKING-STORAGE SECTION.
       77  SMALL-FONT                     HANDLE.           
       78  EXCEPTION-IMPRIMIR             VALUE 02.

       01  CAMPOS-W.
           03  STAT-CADFUN                PIC  X(02).
               88 VALID-CADFUN            VALUE '00' THRU '09'.
           03  STAT-SORTER                PIC  X(02).
               88 VALID-SORTER            VALUE '00' THRU '09'.
           03  STAT-PRINTF                PIC  X(02).
               88 VALID-PRINTF            VALUE '00' THRU '09'.

           03  CAMPOS-TELA-W.
               05 W-DATAINI               PIC  99/99/9999.
               05 W-DATAFIN               PIC  99/99/9999.

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
               05 W-DATADMI-I             PIC  9(08).

               05 W-NROPAGI               PIC  9(05) VALUE 0.
               05 W-CONTLIN               PIC  9(03) VALUE 0.
               05 W-DATA-SISTEMA          PIC  9(08) VALUE 0.
               05 W-TOT-SALARIO           PIC  9(11)V99 VALUE 0.
              
               05 W-POS-ANT-CENTCUS       PIC  9(06) VALUE 0. | CENTRO DE CUSTO ANTERIOR
               05 W-TOT-CENTCUS           PIC  9(11)V99 VALUE 0. | TOTAL DE SALARIOS POR CENTRO DE CUSTO

               05 W-POS-ANT-EMP           PIC  9(3) VALUE 0.    | CODIGO DA EMPRESA ANTERIOR
               05 W-TOT-EMP               PIC  9(11)V99 VALUE 0.| TOTAL DE SALARIOS POR EMPRESA 
               05 W-TOT-FUNC              PIC  9(3) VALUE 0.

               05 W-LINHA-DETALHE.
                  07 W-EMPRESA-DET        PIC  ZZ9B.
                  07 W-CODFUNC-DET        PIC  ZZZ.ZZ9B.
                  07 W-NOMEFUN-DET        PIC  X(40)B.
                  07 W-CENTCUS-DET        PIC  99.99.99B.
                  07 W-DATADMI-DET        PIC  99/99/9999B.
                  07 W-SALARIO-DET        PIC  ZZ.ZZZ.ZZZ.ZZ9,99.

               05 W-CAB-1.
                  07 FILLER               PIC  X(74) VALUE
                     'RELATORIO DE FUNCIONARIOS'.
                  07 WCAB-DATASIS-1       PIC  99/99/9999B(4).
                  07 FILLER               PIC  X(05) VALUE 'PAG.'.
                  07 WCAB-NROPAGI-1       PIC  ZZ.ZZ9B.

               05 W-CAB-2.
                  07 PIC X(132) VALUE 'EMP -------------------FUNCIONARI
      -              'O------------------ C. CUSTO -ADMISSAO- -----SALAR
      -              'IO-----'.

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
                          TITLE "Data de admissão de"
                          ID 1
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATAINI
                          LINE 02
                          COL 23
                          3-D
                          BOXED
                          AUTO
                          ID 2
                          FONT SMALL-FONT.

           03 LABEL       LINE 02 COL 35
                          TITLE "a"
                          ID 3
                          TRANSPARENT.

           03 ENTRY-FIELD USING W-DATAFIN
                          LINE 02
                          COL 37
                          3-D
                          BOXED
                          AUTO
                          ID 4
                          FONT SMALL-FONT.

           03 FRAME    LINE 02,75
                       COL 79
                       LINES 09 
                       SIZE 22
                       TITLE "Ordem de classificação"
                       TITLE-POSITION 1
                       ENGRAVED
                       FONT SMALL-FONT.

           03 RADIO-BUTTON
                       TITLE "&Nome"
                       LINE 04
                       COL 80
                       GROUP 1
                       GROUP-VALUE 1
                       USING W-OPC-CLASSIFICACAO
                       ID 5
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&Código"
                       LINE 06
                       COL 80
                       GROUP 1
                       GROUP-VALUE 2
                       USING W-OPC-CLASSIFICACAO
                       ID 6
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&Salario Menor-Maior"
                       LINE 08
                       COL 80
                       GROUP 1
                       GROUP-VALUE 3
                       USING W-OPC-CLASSIFICACAO
                       ID 7
                       FONT SMALL-FONT
                       NOTIFY.

           03 RADIO-BUTTON
                       TITLE "&Salario Maior-Menor"
                       LINE 10
                       COL 80
                       GROUP 1
                       GROUP-VALUE 4
                       USING W-OPC-CLASSIFICACAO
                       ID 8
                       FONT SMALL-FONT
                       NOTIFY.

           03 PUSH-BUTTON TITLE "&Imprimir"
                          LINE 24
                          COL 2
                          SIZE 12
                          ID 7
                          EXCEPTION-VALUE EXCEPTION-IMPRIMIR.                         

           03 PUSH-BUTTON TITLE "&Sair"
                          LINE 24
                          COL 17
                          SIZE 13
                          SELF-ACT
                          ID 6
                          EXCEPTION-VALUE 27.

       PROCEDURE DIVISION.
       INICIO.

           OPEN INPUT CADFUN
           IF NOT VALID-CADFUN
              PERFORM ERRO-ARQUIVO.

           ACCEPT SMALL-FONT FROM STANDARD OBJECT "SMALL-FONT".           

           DISPLAY INITIAL GRAPHICAL WINDOW
                           SIZE 105 LINES 25,5
                           CONTROL FONT SMALL-FONT
                           COLOR 257
                           TITLE "Relatório Com Cabeçalho"
                           NO SCROLL
                           SYSTEM MENU
                           AUTO-RESIZE
                           AUTO-MINIMIZE
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

                  |

                  INITIALIZE W-NROPAGI  W-TOT-SALARIO
                  MOVE 800 TO W-CONTLIN  

                  OPEN OUTPUT PRINTF
                  INITIALIZE DFUN-REGISTR-1
                  START CADFUN KEY >= DFUN-RECORDK-1
                  IF VALID-CADFUN
                     IF W-OPC-CLASSIFICACAO = 1
                        SORT SORTER ASCENDING KEY SORT-EMPRESA-1
                                                  SORT-CENTCUS-1 | MUDAR DE CENTRO DE CUSTO APENAS QUANDO TERMINAR O OUTRO
                                                  SORT-NOMEFUN-1 | (SERÁ CLASSIFICADO POR CENTRO DE CUSTO TBM)
                                                  SORT-CODFUNC-1
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
                     ELSE
                        IF W-OPC-CLASSIFICACAO = 2                        
                        SORT SORTER ASCENDING KEY SORT-EMPRESA-1
                                                  SORT-CENTCUS-1 | MUDAR DE CENTRO DE CUSTO APENAS QUANDO TERMINAR O OUTRO
                                                  SORT-CODFUNC-1 | (SERÁ CLASSIFICADO POR CENTRO DE CUSTO TBM)
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
                     ELSE
                        IF W-OPC-CLASSIFICACAO = 3
                        SORT SORTER ASCENDING KEY SORT-EMPRESA-1                                                  
                                                  SORT-CENTCUS-1
                                                  SORT-SALARIO-1
                                                  SORT-CODFUNC-1
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC
                     ELSE
                        IF W-OPC-CLASSIFICACAO = 4                       
                        SORT SORTER ASCENDING KEY SORT-EMPRESA-1
                                                  SORT-CENTCUS-1
                                                  |SORT-CODFUNC-1
                                    DESCENDING KEY SORT-SALARIO-1                                                                                                      
                                                   |SORT-CENTCUS-1                                                   
                                                                                   
                             INPUT  PROCEDURE INPUTPROCE
                             OUTPUT PROCEDURE OUTPUTPROC                
                        END-IF
                     END-IF
                  END-IF
                  END-IF
                  END-IF
                  CLOSE PRINTF
           END-EVALUATE.

       INPUTPROCE. | MOVE DO ARQUIVO PARA O ARQUIVO DE CLASSIFICAÇÃO
           PERFORM UNTIL NOT VALID-CADFUN
              READ CADFUN NEXT AT END
                               EXIT PERFORM
              END-READ
              IF NOT VALID-CADFUN
                 PERFORM ERRO-ARQUIVO
              END-IF

              |* inverte a data de admissao do funcionario
              MOVE DFUN-DATADMI-1 TO W-DATAUXI
              COMPUTE W-DATADMI-I = W-ANOAUXI * 10000 +
                                    W-MESAUXI * 100 +
                                    W-DIAAUXI
            
              IF W-DATADMI-I >= W-DATAINI-I AND <= W-DATAFIN-I
                 INITIALIZE             SORT-REGISTR-1
                 MOVE DFUN-EMPRESA-1 TO SORT-EMPRESA-1 | DO ARQUIVO PARA O SORT (CLASS.)
                 MOVE DFUN-CODFUNC-1 TO SORT-CODFUNC-1
                 MOVE DFUN-NOMEFUN-1 TO SORT-NOMEFUN-1
                 MOVE DFUN-CENTCUS-1 TO SORT-CENTCUS-1
                 MOVE DFUN-DATADMI-1 TO SORT-DATADMI-1
                 MOVE DFUN-SALARIO-1 TO SORT-SALARIO-1

                 RELEASE SORT-REGISTR-1
              END-IF
           END-PERFORM.
                               
       OUTPUTPROC. | MOVE DO CLASSIFICADO PARA A EDITADA.
           PERFORM UNTIL 1 = 2
              RETURN SORTER AT END
                            EXIT PERFORM
              END-RETURN
                                                   
              PERFORM TESTA-QUEBRA-PAGINA
 
              MOVE SORT-EMPRESA-1 TO W-EMPRESA-DET
              MOVE SORT-CODFUNC-1 TO W-CODFUNC-DET
              MOVE SORT-NOMEFUN-1 TO W-NOMEFUN-DET
              MOVE SORT-CENTCUS-1 TO W-CENTCUS-DET
              MOVE SORT-DATADMI-1 TO W-DATADMI-DET
              MOVE SORT-SALARIO-1 TO W-SALARIO-DET  


              |MOVE W-LINHA-DETALHE TO PRINTF-R
              |WRITE PRINTF-R AFTER 1
              

              WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 1
              ADD 1 TO W-CONTLIN
              ADD SORT-SALARIO-1 TO W-TOT-EMP | A CADA REGISTRO ADICIONA AO TOTAL POR EMPRESA      
              ADD SORT-SALARIO-1 TO W-TOT-CENTCUS | A CADA REGISTRO ELE ADIIONA O SALÁRIO DO REGISTRO ATUAL PARA CENTCUS
              ADD 1 TO W-TOT-FUNC              
           END-PERFORM.

           IF W-CONTLIN <> 800  | CONTEUDO DO FINAL DA LEITURA
              PERFORM TESTA-QUEBRA-PAGINA
              |INICIO
              MOVE SPACES TO W-LINHA-DETALHE
              MOVE '*** TOTAL POR CENTRO DE CUSTO' TO W-NOMEFUN-DET
              MOVE W-TOT-CENTCUS TO W-SALARIO-DET
              WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 2 
              |FIM
              
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 3              
              STRING "            *** FUNCIONÁRIOS NESTA EMPRESA  " 
                                 W-TOT-FUNC INTO PRINTF-R
              WRITE PRINTF-R AFTER 1
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1
              INITIALIZE W-TOT-FUNC

              | VAI EXIBIR O SALARIO TOTAL DA ULTIMA EMPRESA
              MOVE SPACES TO W-LINHA-DETALHE
              MOVE '*** TOTAL POR EMPRESA' TO W-NOMEFUN-DET
              MOVE W-TOT-EMP TO W-SALARIO-DET
              WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 1

              MOVE SPACES TO W-LINHA-DETALHE
              MOVE '*** TOTAL GERAL' TO W-NOMEFUN-DET
              ADD W-TOT-EMP TO W-TOT-SALARIO
              MOVE W-TOT-SALARIO TO W-SALARIO-DET
              WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 2
              ADD 11 TO W-CONTLIN | ADICIONA LINHAS NO CONTADOR, QUE IMPRIRAM O TOTAL POR CENTCUS, TOTAL POR EMPRESA E O TOTAL GERAL
           END-IF.

       TESTA-QUEBRA-PAGINA.

           IF W-NROPAGI <> 0 AND SORT-CENTCUS-1 <> W-POS-ANT-CENTCUS | ELE VAI ENTRAR APENAS QUANDO NÃO FOR A 1ª PAG.
              MOVE SPACES TO W-LINHA-DETALHE
              MOVE '*** TOTAL POR CENTRO DE CUSTO' TO W-NOMEFUN-DET
              MOVE W-TOT-CENTCUS TO W-SALARIO-DET
              WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 2
           END-IF

           IF W-CONTLIN > 64 OR SORT-EMPRESA-1 <> W-POS-ANT-EMP  | QUANDO A EMPRESA MUDAR OU SEJA A EMPRESA SEJA DIFERENTE.
              PERFORM IMPRIME-CABECALHO

              WRITE PRINTF-R FROM W-CAB-2 AFTER 2
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1
              MOVE SPACES TO PRINTF-R
              STRING "EMPRESA  " SORT-EMPRESA-1 INTO PRINTF-R |CABEÇALHO QUE MOSTRA O CÓDIGO DA EMPRESA
              WRITE PRINTF-R AFTER 1
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1
              ADD 5 TO W-CONTLIN 
           END-IF              

           IF SORT-CENTCUS-1 <> W-POS-ANT-CENTCUS | IDENTIFICA QUANDO MUDA O CENTRO DE CUSTO, IMPRIME UM NOVO CABEÇALHO                           
              MOVE SORT-CENTCUS-1 TO W-CENTCUS-DET
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1
              STRING "CENTRO DE CUSTO " W-CENTCUS-DET INTO PRINTF-R |JOGA STRING DENTRO DA IMPRESSORA
              WRITE PRINTF-R AFTER 1
              MOVE SPACES TO PRINTF-R
              WRITE PRINTF-R AFTER 1
              MOVE SORT-CENTCUS-1 TO W-POS-ANT-CENTCUS
              INITIALIZE W-TOT-CENTCUS |LIMPA O CENTRO DE CUSTO PARA QUANDO COMEÇAR UM NOVO FUNCIONÁRIO ELE NÃO PEGAR A SUJEIRA DO CENTRO DE CUSTO DO FNCIONÁRIO ANTERIOR
              ADD 3 TO W-CONTLIN | ADICIONA 3 LINHAS AO CONTADOR PARA A IMPRESSÃO DE UM NOVO CABEÇALHO
           END-IF.           
           
       IMPRIME-CABECALHO.
           MOVE SPACES TO PRINTF-R
           MOVE ALL '-' TO PRINTF-R(1:132)
           IF W-NROPAGI = 0
              ACCEPT W-DATA-SISTEMA FROM CENTURY-DATE | * PEGA A DATA DO SISTEMA JA INVERTIDA.
              MOVE W-DATA-SISTEMA TO W-DATAUXI
              COMPUTE W-DATA-SISTEMA = W-ANOAUXI-I +
                                       W-MESAUXI-I * 10000 +
                                       W-DIAAUXI-I * 1000000

              WRITE PRINTF-R AFTER 0
              MOVE SORT-EMPRESA-1 TO W-POS-ANT-EMP
           ELSE  
              IF SORT-EMPRESA-1 <> W-POS-ANT-EMP |ENTRA NESSE IF QUANDO TROCAR DE PÁGINA E MUDAR DE EMPRESA
                 
                 MOVE SPACES TO PRINTF-R
                 WRITE PRINTF-R AFTER 3              
                 STRING "            *** FUNCIONÁRIOS NESTA EMPRESA  " 
                                 W-TOT-FUNC INTO PRINTF-R
                 WRITE PRINTF-R AFTER 1
                 MOVE SPACES TO PRINTF-R
                 WRITE PRINTF-R AFTER 1
                 INITIALIZE W-TOT-FUNC
                 
                 MOVE SPACES TO W-LINHA-DETALHE
                 MOVE '*** TOTAL POR EMPRESA' TO W-NOMEFUN-DET
                 MOVE W-TOT-EMP TO W-SALARIO-DET
                 WRITE PRINTF-R FROM W-LINHA-DETALHE AFTER 1 | QUANDO MUDAR A EMPRESA IMPRIME O TOTAL DA EMPRESA
                 ADD W-TOT-EMP TO W-TOT-SALARIO | ADICIONA TOTAL POR EMPRESA AO TOTAL GERAL
                 INITIALIZE W-TOT-EMP  | LIMPA O TOTAL POR EMPRESA    
                 ADD 2 TO W-CONTLIN | ADICIONAMOS 2 LINHAS AO CONTADOR PARA IMPRIMIR O TOTAL DA EMPRESA QUANDO NECESSÁRIO
              END-IF
                            
              MOVE ALL '-' TO PRINTF-R(1:132)
              WRITE PRINTF-R AFTER PAGE
              MOVE SORT-EMPRESA-1 TO W-POS-ANT-EMP. | MOVE O COD DA "NOVA" EMPRESA PARA A VARIAVEL

           ADD 1 TO W-NROPAGI
           MOVE W-NROPAGI      TO WCAB-NROPAGI-1
           MOVE W-DATA-SISTEMA TO WCAB-DATASIS-1
           WRITE PRINTF-R FROM W-CAB-1 AFTER 1

           MOVE SPACES TO PRINTF-R
           MOVE ALL '-' TO PRINTF-R(1:132)
           WRITE PRINTF-R AFTER 1.

           MOVE 3 TO W-CONTLIN.
           
           COPY "ERRO.CPY".
           COPY "MSG-ERRO.CPY".
           COPY "PRG-INICIALIZA.CPY".
           COPY "DATASP.CPY".
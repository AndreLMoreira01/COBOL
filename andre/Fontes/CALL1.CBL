       IDENTIFICATION DIVISION.
       PROGRAM-ID       CALL1.

       WORKING-STORAGE SECTION.
       77  NOME-CLIENTE         PIC X(50).
       77  CNPJ-CLIENTE         PIC X(15).

       COPY "MAINRTN.MSG".

       PROCEDURE DIVISION.
           MOVE 'CLIENTE TESTE' TO NOME-CLIENTE
           MOVE 123456          TO CNPJ-CLIENTE
           CALL 'CALL2' USING 'A',  CNPJ-CLIENTE, NOME-CLIENTE
                        ON OVERFLOW
                                INITIALIZE CA-MESSAGE-LINK
                                MOVE 'PROGRAMA CALL2 NÃO ENCONTRADO'
                                TO CA-MESSAGE-1
                                PERFORM MOSTRA-MSG-ERRO
                        NOT OVERFLOW
                                CANCEL 'CALL2'
           END-CALL.

           MOSTRA-MSG-ERRO.

           MOVE 1 TO CA-MESSAGE-TYPE CA-MESSAGE-RESP
           CALL "CAMESSAG"
           CANCEL "CAMESSAG"

           EXIT PROGRAM.
           STOP RUN.
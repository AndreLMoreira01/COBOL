        SELECT CPRODUTO ASSIGN TO 'PRODUTO.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   PROD-ID
                  ALTERNATE RECORD KEY PROD-PRECO WITH DUPLICATES
                  FILE STATUS  IS ST-PROD.
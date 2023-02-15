       SELECT CADFUN ASSIGN TO 'FUNCIONARIO.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   DFUN-RECORDK-1
                  ALTERNATE RECORD KEY DFUN-NOMEFUN-1
                                       WITH DUPLICATES
                  ALTERNATE RECORD KEY DFUN-CHAVALT-1 = DFUN-EMPRESA-1
                                                        DFUN-CENTCUS-1
                                                        DFUN-CODFUNC-1
                  FILE STATUS  IS STAT-CADFUN.
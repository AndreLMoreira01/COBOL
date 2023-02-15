       SELECT CLOG ASSIGN TO 'LOG.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   LOG-RK-1 = LOG-DIA
		                          LOG-HORA
                  ALTERNATE RECORD KEY LOG-TIPO WITH DUPLICATES
		  ALTERNATE RECORD KEY LOG-ARQ WITH DUPLICATES
                  FILE STATUS  IS ST-LOG.
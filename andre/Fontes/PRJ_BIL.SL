       SELECT CBILHETE ASSIGN TO 'BILHETE.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   BIL-RK-1 = BIL-FRO
		                          BIL-CLI
					  BIL-DATA
					  BIL-VIA
                                          BIL-TIPO
                  ALTERNATE RECORD KEY BIL-TIPO WITH DUPLICATES
		  ALTERNATE RECORD KEY BIL-NMR WITH DUPLICATES
		  ALTERNATE RECORD KEY BIL-NOME WITH DUPLICATES
		                                  
                  FILE STATUS  IS ST-BIL.
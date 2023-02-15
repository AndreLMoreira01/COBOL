        SELECT CCIDADE ASSIGN TO 'CIDADE.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   CID-ID
                  ALTERNATE RECORD KEY CID-CHAVALT = CID-NOME
		                                     CID-LOC
		  
		                                  
                  FILE STATUS  IS ST-CID.
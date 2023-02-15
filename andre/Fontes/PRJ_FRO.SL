       SELECT CFROTA ASSIGN TO 'FROTA.ARQ'
                  ORGANIZATION INDEXED
                  ACCESS MODE  DYNAMIC
                  LOCK MODE    AUTOMATIC
                  RECORD KEY   FRO-ID
                  ALTERNATE RECORD KEY  FRO-ORI WITH DUPLICATES
		  ALTERNATE RECORD KEY  FRO-DES WITH DUPLICATES                                   
		                                  
                  FILE STATUS  IS ST-FRO.
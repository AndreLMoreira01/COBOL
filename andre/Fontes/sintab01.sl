           SELECT SINTAB01
                ASSIGN TO "SINTAB01.ARQ"
                ORGANIZATION INDEXED
                ACCESS MODE DYNAMIC
                LOCK MODE AUTOMATIC
                RECORD KEY NTAB-CODMUNI-1
                ALTERNATE RECORD KEY NTAB-NOMEMUN-1
                   WITH DUPLICATES
                ALTERNATE RECORD KEY NTAB-CODIBGE-1
                   WITH DUPLICATES
                FILE STATUS STAT-SINTAB01.

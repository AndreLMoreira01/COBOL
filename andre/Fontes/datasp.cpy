       CRITICA-DATA.
           SET DATA-OK TO FALSE.

           IF W-DATA-CRIT <> 0 AND W-DIA-CRIT = 0
              MOVE W-MES-CRIT TO W-DIA-CRIT
              COMPUTE W-MES-CRIT = W-ANO-CRIT / 100
              COMPUTE W-ANO-CRIT = W-ANO-CRIT * 100
              COMPUTE W-ANO-CRIT = 2000 + (W-ANO-CRIT / 100)
           END-IF.

           IF (W-MES-CRIT < 1 OR > 12) OR
              (W-ANO-CRIT < 1600)      OR
              (W-DIA-CRIT = 0)
              EXIT PARAGRAPH.

           IF W-MES-CRIT = 2
              COMPUTE W-RESTDIV-400 = W-ANO-CRIT / 400
              COMPUTE W-RESTDIV-400 = W-ANO-CRIT - (W-RESTDIV-400 * 400)
 
              COMPUTE W-RESTDIV-100 = W-ANO-CRIT / 100
              COMPUTE W-RESTDIV-100 = W-ANO-CRIT - (W-RESTDIV-100 * 100)
 
              COMPUTE W-RESTDIV-4 = W-ANO-CRIT / 4
              COMPUTE W-RESTDIV-4 = W-ANO-CRIT - (W-RESTDIV-4 * 4)
              
              IF W-RESTDIV-400 = 0 OR (W-RESTDIV-4 = 0 AND
                                       W-RESTDIV-100 <> 0)
                 MOVE 29 TO W-DIAS-MES-T(2)
              ELSE
                 MOVE 28 TO W-DIAS-MES-T(2)
              END-IF
           END-IF.
           
           IF W-DIA-CRIT > W-DIAS-MES-T(W-MES-CRIT)
              EXIT PARAGRAPH.

           SET DATA-OK TO TRUE.

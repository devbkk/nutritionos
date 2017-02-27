select *
from NUTR_PADM
where HN = ' 725350'

select *
from NUTR_FOOD_REQS
where AN = '5934109'
 
 
 
 SELECT D.*, A.FGRP, H.MEALORD   
 FROM NUTR_FOOD_REQD D   
 LEFT JOIN  (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, G.FGRP   
             FROM (SELECT *,   
                        dbo.ParGrpLev(F.FGRC,1) AS FGRC1,  
                        dbo.ParGrpLev(F.FGRC,0) AS FGRC0   
                   FROM NUTR_FOOD_REQD R   
                   LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE   
                   WHERE REQCODE <>   'freetext'  ) A   
              LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1   
              WHERE A.FGRC0=   0002  ) A ON A.REQID = D.REQID   
 LEFT JOIN NUTR_FOOD_REQS H ON H.REQID = D.REQID   
 WHERE D.REQID LIKE '0004A'   
 ORDER BY D.REQID, D.REQCODE
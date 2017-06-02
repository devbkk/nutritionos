 SELECT DISTINCT D.REQID, D.REQCODE, D.REQDESC, 
                 A.FGRP, H.MEALORD, FC.FPRT   
 FROM NUTR_FOOD_REQD D   
 LEFT JOIN  (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, A.FPRT, G.FGRP   
             FROM (SELECT *,   
                        dbo.ParGrpLev(F.FGRC,1) AS FGRC1,  
                        dbo.ParGrpLev(F.FGRC,0) AS FGRC0
                   FROM NUTR_FOOD_REQD R   
                   LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE   
                   WHERE REQCODE <>   'freetext'  ) A   
              LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1   
              WHERE A.FGRC0=   0002  ) A ON A.REQID = D.REQID   
 LEFT JOIN NUTR_FOOD_REQS H ON H.REQID = D.REQID   
 LEFT JOIN NUTR_FACT FC ON FC.CODE = D.REQCODE
 WHERE D.REQID LIKE '00046'   
 ORDER BY D.REQID, D.REQCODE

		   

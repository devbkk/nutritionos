CREATE FUNCTION FN_REPORT1(@RQDATE DATETIME)
RETURNS TABLE
AS
RETURN
(
SELECT RQ.REQID, RQ.HN, RQ.MEALORD, RQ.FOODREQDESC,
       RQ.REQDATE, RQ.HTS, RQ.WTS,
       PA.TNAME, PA.FNAME, PA.LNAME,
       DATEDIFF(YYYY,PA.BIRTH,GETDATE()) AS AGE,
       PA.WARDID, PA.WARDNAME, PA.ROOMNO, PA.BEDNO,
       B.FGRC, B.FGRP,
       D.[DES] AS DIAGDESC
FROM NUTR_FOOD_REQS RQ 
LEFT JOIN NUTR_PADM PA ON PA.AN = RQ.AN 
LEFT JOIN (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, G.FGRP 
           FROM (SELECT *,
                        dbo.ParGrpLev(F.FGRC,1) AS FGRC1,
                        dbo.ParGrpLev(F.FGRC,0) AS FGRC0 
                 FROM NUTR_FOOD_REQD R 
                 LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE 
                 WHERE REQCODE <> 'freetext') A 
           LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1 
           WHERE A.FGRC0= '0002') B ON B.REQID = RQ.REQID 
LEFT JOIN NUTR_DIAG D ON D.CODE = RQ.DIAG 
WHERE ISNULL(RQ.REQEND,'') = 'Y' 
AND ISNULL(RQ.FOODREQDESC,'') <> '' 
AND CONVERT(DATE,RQ.REQDATE) = CONVERT(DATE,@RQDATE))
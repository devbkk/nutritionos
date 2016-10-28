--select *
--from NUTR_FOOD_REQS

--select *
--from NUTR_PATN_ADMT



--SELECT DISTINCT 
--  A.WARDID, A.WARDNAME,
--  ISNULL(A.ROOMNO,'') AS ROOMNO, ISNULL(A.BEDNO,'') AS BEDNO, 
--  P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
--  RQ.AMOUNTAM, RQ.AMOUNTPM 
--FROM NUTR_FOOD_REQS RQ
--LEFT JOIN NUTR_PATN_ADMT A ON A.AN = RQ.AN
--LEFT JOIN NUTR_PATN P ON P.HN = A.HN


--SELECT *
--FROM NUTR_FOOD_REQS

--SELECT /*DISTINCT*/ P.WARDID, P.WARDNAME,
--ISNULL(P.ROOMNO,'') AS ROOMNO,
--ISNULL(P.BEDNO,'')  AS BEDNO,
--P.HN,
--P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
--RQ.AMOUNTAM, RQ.AMOUNTPM, RQ.SALTWT,
--RQ.REQFR, RQ.REQTO,
--GETDATE() AS PRNDATE,
--RQ.FOODREQDESC
--FROM NUTR_PADM P
--JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN
--                      AND RQ.AN = RQ.AN
--WHERE '2015-12-04' BETWEEN RQ.REQFR AND RQ.REQTO

--SELECT *
--FROM NUTR_FACT_GRPS
--WHERE ISNULL(SLIPPRN,'') = 'Y'

--SELECT *
--FROM NUTR_FACT F
--JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC
--WHERE ISNULL(G.SLIPPRN,'') = 'Y'
 
--SELECT F.CODE
--FROM NUTR_FACT F
--JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC
--WHERE ISNULL(G.SLIPPRN,'') = 'Y'

--SELECT D.*
--FROM NUTR_FOOD_REQD D
--WHERE EXISTS (SELECT 1
--              FROM NUTR_FACT F
--              JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC
--              WHERE ISNULL(G.SLIPPRN,'') = 'Y'
--		      AND CODE=D.REQCODE)

--SELECT  
--  P.WARDID, P.WARDNAME,
--  ISNULL(P.ROOMNO,'') AS ROOMNO,
--  ISNULL(P.BEDNO,'')  AS BEDNO,
--  P.HN,
--  P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
--  GETDATE() AS PRNDATE,
--  RQ.REQID, RQ.FOODREQDESC, RQ.REQDATE,
--  RQ.DIAG
--FROM NUTR_PADM P
--JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN
--                      AND RQ.AN = RQ.AN
--JOIN (SELECT TOP 1 D.*
--      FROM NUTR_FOOD_REQD D
--      WHERE EXISTS (SELECT 1
--                    FROM NUTR_FACT F
--                    JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC
--                    WHERE ISNULL(G.SLIPPRN,'') = 'Y'
--		            AND CODE=D.REQCODE)) A ON A.REQID = RQ.REQID

--SELECT *
--FROM NUTR_FOOD_REQD
--WHERE REQID = '00008'


--SELECT 
--  P.WARDID, P.WARDNAME,
--  ISNULL(P.ROOMNO,'''') AS ROOMNO,
--  ISNULL(P.BEDNO,'''')  AS BEDNO,
--  P.HN,
--  P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
--  GETDATE() AS PRNDATE,
--  RQ.REQID, RQ.FOODREQDESC, RQ.REQDATE, RQ.DIAG, RQ.MEALORD 
--FROM NUTR_PADM P 
--JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN 
--                      AND RQ.AN = RQ.AN 
--JOIN (SELECT TOP 1 D.* 
--      FROM NUTR_FOOD_REQD D 
--      WHERE EXISTS (SELECT 1 
--                    FROM NUTR_FACT F 
--                    JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC 
--                    WHERE ISNULL(G.SLIPPRN,'') = 'Y' 
--                    AND CODE=D.REQCODE)) A ON A.REQID = RQ.REQID

--SELECT *
--FROM NUTR_FACT_GRPS
--WHERE SLIPPRN = 'Y'

--SELECT *
--FROM NUTR_FACT_GRPS G
--JOIN NUTR_FACT F ON F.FGRC = G.FGRC
--WHERE SLIPPRN = 'Y'



/*SELECT 
  P.WARDID, P.WARDNAME,
  ISNULL(P.ROOMNO,'''') AS ROOMNO,
  ISNULL(P.BEDNO,'''')  AS BEDNO,
  P.HN,
  P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
  GETDATE() AS PRNDATE,
  RQ.REQID, RQ.FOODREQDESC, RQ.REQDATE, 
  RQ.DIAG, RQ.MEALORD, RQ.REQEND
FROM NUTR_PADM P 
JOIN NUTR_FOOD_REQS RQ ON RQ.HN = P.HN 
                      AND RQ.AN = RQ.AN*/ 
/*JOIN (SELECT TOP 1 D.* 
      FROM NUTR_FOOD_REQD D 
      WHERE EXISTS (SELECT 1 
                    FROM NUTR_FACT F 
                    JOIN NUTR_FACT_GRPS G ON G.FGRC = F.FGRC 
                    WHERE ISNULL(G.SLIPPRN,'') = 'Y' 
                    AND CODE=D.REQCODE)) A ON A.REQID = RQ.REQID*/
/*JOIN
(
SELECT DISTINCT REQID
FROM NUTR_FOOD_REQD
WHERE EXISTS 
  (SELECT *
   FROM NUTR_FACT_GRPS G
   JOIN NUTR_FACT F ON F.FGRC = G.FGRC
   WHERE SLIPPRN = 'Y')) B ON B.REQID = RQ.REQID*/

/*JOIN
(
SELECT AN, MAX(REQDATE) AS REQDATE 
FROM NUTR_FOOD_REQS
GROUP BY AN) C ON C.AN = RQ.AN
              AND C.REQDATE = RQ.REQDATE

--WHERE ISNULL(RQ.REQEND,'') <> 'Y'
ORDER BY WARDID, HN*/

 SELECT D.*, A.FGRP, H.MEALORD  
 FROM NUTR_FOOD_REQD D
 LEFT JOIN  (SELECT DISTINCT A.REQID, A.FGRC1 AS FGRC, G.FGRP 
             FROM (SELECT *,
                        dbo.ParGrpLev(F.FGRC,1) AS FGRC1,
                        dbo.ParGrpLev(F.FGRC,0) AS FGRC0 
                 FROM NUTR_FOOD_REQD R 
                 LEFT JOIN NUTR_FACT F ON F.CODE = R.REQCODE 
                 WHERE REQCODE <> 'freetext') A 
             LEFT JOIN NUTR_FACT_GRPS G ON G.FGRC = A.FGRC1 
             WHERE A.FGRC0= '0002') A ON A.REQID = D.REQID 
LEFT JOIN NUTR_FOOD_REQS H ON H.REQID = D.REQID
 WHERE D.REQID LIKE %S   
 ORDER BY D.REQID, D.REQCODE ;
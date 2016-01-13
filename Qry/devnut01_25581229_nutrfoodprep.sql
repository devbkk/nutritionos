select *
from NUTR_FOOD_REQS

select *
from NUTR_PATN_ADMT



SELECT DISTINCT 
  A.WARDID, A.WARDNAME,
  ISNULL(A.ROOMNO,'') AS ROOMNO, ISNULL(A.BEDNO,'') AS BEDNO, 
  P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
  RQ.AMOUNTAM, RQ.AMOUNTPM 
FROM NUTR_FOOD_REQS RQ
LEFT JOIN NUTR_PATN_ADMT A ON A.AN = RQ.AN
LEFT JOIN NUTR_PATN P ON P.HN = A.HN


SELECT *
FROM NUTR_FOOD_REQS
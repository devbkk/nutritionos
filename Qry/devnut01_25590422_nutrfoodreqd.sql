
select top 1  *
from NUTR_FOOD_REQD
where REQID = '0000C' and REQCODE = '02310002'

SELECT ROW_NUMBER() over (order by REQID, REQCODE) AS ROW  , *
FROM NUTR_FOOD_REQD

--This method not work
--DELETE 
--(SELECT ROW_NUMBER() over (order by REQID, REQCODE) AS ROW  , *
-- FROM NUTR_FOOD_REQD) A
--WHERE A.ROW = 1

--this work for delete duplicate data
WITH CTE AS (
  SELECT REQID, REQCODE, REQDESC,
         RN = ROW_NUMBER() OVER (PARTITION BY REQID, REQCODE ORDER BY REQID,REQCODE)
  FROM NUTR_FOOD_REQD 
)DELETE FROM CTE WHERE RN >1

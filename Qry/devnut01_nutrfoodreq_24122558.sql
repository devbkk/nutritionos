select *
from NUTR_FACT

--update NUTR_FACT set FGRP = 'diag',FGRC='03', FTYC='001'
--where FTYP = '�ä'

SELECT FDES
FROM NUTR_FACT
WHERE FGRP = 'diag'

select *
from NUTR_FOOD_REQS

SELECT *
FROM NUTR_PATN

SELECT *
FROM NUTR_PATN_ADMT 

SELECT P.HN, A.AN, P.PID, 
       P.TNAME+P.FNAME+' '+P.LNAME AS PATNAME,
	   P.GENDER, P.BIRTH, A.WARDID, A.WARDNAME
FROM NUTR_PATN P 
LEFT JOIN NUTR_PATN_ADMT A ON A.HN = P.HN
WHERE A.AN = ''

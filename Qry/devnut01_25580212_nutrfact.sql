--���Ѻ�ٵ�
--1
--UPDATE NUTR_FACT SET FGRP = 'recipe', FGRC = '00', FTYC = '001' 
--WHERE CODE = '00001001' 
--UPDATE NUTR_FACT SET FGRP = 'recipe', FGRC = '00', FTYC = '001' 
--WHERE CODE = '00001002' 

--SELECT FGRC, FGRP
--FROM NUTR_FACT
--GROUP BY FGRC, FGRP

--SELECT *, '31'+FTYC+SUBSTRING(CODE,6,3)--, SUBSTRING(CODE,6,3)
--FROM NUTR_FACT
--WHERE FGRC = '03'

--SELECT *
--FROM NUTR_FOOD_REQS

--UPDATE NUTR_FACT SET CODE = '11'+SUBSTRING(F.CODE,3,6)
--FROM NUTR_FACT F
--WHERE FGRC = '01'

--UPDATE NUTR_FACT SET FGRC = '11'
--WHERE FGRC = '01'

--UPDATE NUTR_FACT SET CODE = '12'+F.FTYC+SUBSTRING(F.CODE,6,3)
--FROM NUTR_FACT F
--WHERE FGRC = '02'

--UPDATE NUTR_FACT SET FGRC = '12'
--WHERE FGRC = '02'

--UPDATE NUTR_FACT SET CODE = '31'+F.FTYC+SUBSTRING(F.CODE,6,3)
--FROM NUTR_FACT F
--WHERE FGRC = '03'

--UPDATE NUTR_FACT SET FGRC = '31'
--WHERE FGRC = '03'

--UPDATE NUTR_FACT SET CODE = '11001'+SUBSTRING(F.CODE,3,3), FGRP = 'foodtype'
----SELECT *, SUBSTRING(F.CODE,3,3)
--FROM NUTR_FACT F
--WHERE ISNULL(F.FGRC,'') = ''

--UPDATE NUTR_FACT SET FGRC = '11'
--WHERE CODE IN ('11001001','11001002')

--SELECT CODE 
--FROM NUTR_FACT
--GROUP BY CODE 
--HAVING COUNT(*) >1

--UPDATE NUTR_FACT SET CODE = '11003002'
--WHERE FDES = '�������͹ - �״'

--UPDATE NUTR_FACT
--SET PCOD = '00001002', FGRC = '01', FTYC ='001'
--SET FGRP = 'feed'
--WHERE ISNULL(FGRP,'')=''
--WHERE ISNULL(FGRP,'')='feed'
--AND FGRC = '01' AND FTYC = '002'

--SELECT *
--INTO NUTR_FACT_TEMP
--FROM NUTR_FACT
--WHERE ISNULL(FGRP,'')= 'feed'

--INSERT NUTR_FACT 
--SELECT '01002'+SUBSTRING(CODE,6,3) AS CODE,FDES, '���������ҧ�ٵ�����ҹ' as FTYP, NOTE, FGRP, FGRC, '002' AS FTYC, PCOD
--FROM NUTR_FACT_TEMP

SELECT  *
FROM NUTR_FACT 
--WHERE ISNULL(FGRP,'')=''

SELECT MAX(CODE) 
FROM NUTR_FACT
WHERE FGRC = '01'
AND FTYC = '001'
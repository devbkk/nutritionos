--select *
--from NUTR_FACT
--where FGRC like '24%'

--select *
--from NUTR_FOOD_REQS

--select *
--from NUTR_FOOD_REQD

----ความเข้มข้น
--select RD.REQID,C.FDES
--from NUTR_FOOD_REQD RD
--join NUTR_FACT C on C.CODE = RD.REQCODE
--                and C.FGRC in ('2411','2422')
----ชนิดอาหาร
--select RD.REQID,T.FDES
--from NUTR_FOOD_REQD RD
--join NUTR_FACT T on T.CODE = RD.REQCODE
--                and T.FGRC in ('2414','2421')

----จำนวนซี.ซี.
--select RD.REQID, CC.FDES AS CC, '1' ASMEAL
--from NUTR_FOOD_REQD RD
--join NUTR_FACT CC on CC.CODE = RD.REQCODE
--                and CC.FGRC in ('2412','2423')
--union
----จำนวนมื้อ
--select RD.REQID, '1' AS CC,  M.FDES AS MEAL
--from NUTR_FOOD_REQD RD
--join NUTR_FACT M on M.CODE = RD.REQCODE
--                 and M.FGRC in ('2413','2424')
--order by RD.REQID

--update select table
--UPDATE
--    Table_A
--SET
--    Table_A.col1 = Table_B.col1,
--    Table_A.col2 = Table_B.col2
--FROM
--    Some_Table AS Table_A
--    INNER JOIN Other_Table AS Table_B
--        ON Table_A.id = Table_B.id
--WHERE
--    Table_A.col3 = 'cool'

CREATE FUNCTION FN_REP1_FEEDCC() 
RETURNS @T TABLE
(
REQID     char(5)     collate Thai_BIN, 
FOODTYPE  varchar(50) collate Thai_BIN, 
CONC      varchar(50) collate Thai_BIN,
CC        varchar(50) collate Thai_BIN,
MEAL      varchar(50) collate Thai_BIN
)
AS
BEGIN 

IF OBJECT_ID('tempdb..#TEMP_REP01') IS NOT NULL
  DROP TABLE #TEMP_REP01  
CREATE TABLE #TEMP_REP01 (REQID     char(5)     collate Thai_BIN, 
                          FOODTYPE  varchar(50) collate Thai_BIN, 
                          CONC      varchar(50) collate Thai_BIN,
                          CC        varchar(50) collate Thai_BIN,
                          MEAL      varchar(50) collate Thai_BIN)


INSERT INTO #TEMP_REP01 
SELECT RD.REQID,T.FDES,'','',''
FROM NUTR_FOOD_REQD RD
JOIN NUTR_FACT T ON T.CODE = RD.REQCODE
                AND T.FGRC IN ('2414','2421')

UPDATE #TEMP_REP01 
SET
     #TEMP_REP01.CONC = C.FDES
FROM NUTR_FOOD_REQD RD
JOIN NUTR_FACT C ON C.CODE = RD.REQCODE
                AND C.FGRC IN ('2411','2422')
WHERE #TEMP_REP01.REQID = RD.REQID

UPDATE #TEMP_REP01
SET
    #TEMP_REP01.CC = CC.FDES
FROM NUTR_FOOD_REQD RD
JOIN NUTR_FACT CC ON CC.CODE = RD.REQCODE
                AND CC.FGRC IN ('2412','2423')
WHERE #TEMP_REP01.REQID = RD.REQID

UPDATE #TEMP_REP01
SET
    #TEMP_REP01.MEAL = M.FDES
FROM NUTR_FOOD_REQD RD
JOIN NUTR_FACT M ON M.CODE = RD.REQCODE
                AND M.FGRC IN ('2413','2424')
WHERE #TEMP_REP01.REQID = RD.REQID

SELECT * FROM #TEMP_REP01

SELECT *
INTO @T
FROM #TEMP_REP01

RETURN
END
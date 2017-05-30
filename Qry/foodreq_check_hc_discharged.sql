--case 1: end food request permanently
SELECT  AN, REQEND, REQENDDATE, REQENDTYPE
FROM NUTR_FOOD_REQS
WHERE ISNULL(REQEND,'') = 'Y'
AND ISNULL(REQENDTYPE,'')= ''

--case 2: end food request because NPO
SELECT  AN, REQEND, REQENDDATE, REQENDTYPE
FROM NUTR_FOOD_REQS
WHERE ISNULL(REQEND,'') = 'Y'
AND ISNULL(REQENDTYPE,'')= 'N'

--case 3: continue food request as usual
SELECT  AN, REQEND, REQENDDATE, REQENDTYPE
FROM NUTR_FOOD_REQS
WHERE ISNULL(REQEND,'') = ''
AND ISNULL(REQENDTYPE,'')= ''
AND EXISTS (SELECT 1 
            FROM DEVHC.dbo.Ipd_h 
			where (ISNULL(discharge_date,'') <> '') 
			AND ladmit_n = AN)

-- update select example
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


UPDATE NUTR_FOOD_REQS
SET REQEND     = 'Y', 
    REQENDDATE = GETDATE(),
	REQENDTYPE = ''
FROM NUTR_FOOD_REQS R
WHERE ISNULL(R.REQEND,'') = ''
AND ISNULL(R.REQENDTYPE,'')= ''
AND EXISTS (SELECT 1 
            FROM DEVHC.dbo.Ipd_h 
			where (ISNULL(discharge_date,'') <> '') 
			AND ladmit_n = R.AN)

--check function view or stored procedure exist
SELECT xtype 
FROM dbo.sysobjects
GROUP BY xtype 

--function
SELECT * FROM dbo.sysobjects 
WHERE xtype in ('FN','IF','TF') 

--view
SELECT * FROM dbo.sysobjects 
WHERE xtype in ('V') 

--stored_procedure
SELECT * FROM dbo.sysobjects 
WHERE xtype in ('P') 
and id = OBJECT_ID('name')
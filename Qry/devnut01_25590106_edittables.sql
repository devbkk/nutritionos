--ALTER TABLE NUTR_FACT ALTER COLUMN CODE CHAR(8) NOT NULL
--ALTER TABLE NUTR_FACT ADD FGRC CHAR(2) NULL, FTYC CHAR(3) NULL
-----------------------------------------------------------------
--ALTER TABLE NUTR_PATN_ADMT ADD ROOMNO CHAR(5)
--ALTER TABLE NUTR_PATN_ADMT ADD BEDNO CHAR(10)
--ALTER TABLE NUTR_FOOD_REQS ADD PRINTED CHAR(1) NULL
--UPDATE NUTR_FOOD_REQS SET PRINTED = 'N'
--ALTER TABLE NUTR_FOOD_REQS ADD SALTWT FLOAT NULL
--ALTER TABLE NUTR_FACT ALTER COLUMN NOTE VARCHAR(250) NULL
--ALTER TABLE NUTR_FACT ADD PCOD VARCHAR(8) NULL
-----------------------------------------------------------------
--ALTER TABLE NUTR_FACT ALTER COLUMN FTYP VARCHAR(30) NULL
--ALTER TABLE NUTR_FOOD_REQS ADD FOODTYPC CHAR(8) NULL
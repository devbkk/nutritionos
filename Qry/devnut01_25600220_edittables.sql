--view for print condition
CREATE VIEW VW_PRINTCOND AS 
SELECT 'AUT' AS ACODE, 'อัตโนมัติ' AS ADESC
UNION
SELECT 'FTY' AS ACODE, 'อาหารสายยาง[ชนิด]' AS ADESC
UNION
SELECT 'FME' AS ACODE, 'อาหารสายยาง[ปริมาณ]' AS ADESC
UNION
SELECT 'FTX' AS ACODE, 'อาหารสายยาง[เพิ่มเติม]' AS ADESC

select * from VW_PRINTCOND

--define new field data for various slip print
alter table NUTR_FACT add FTYP char(3) null

--6/4/2560
alter table NUTR_REPORTS add RTYP char(1) null

--13/4/2560
alter table NUTR_REPORTS add RDEL char(1) null

--19/4/2560
alter table NUTR_FOOD_REQD add REQLN int
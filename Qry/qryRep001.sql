--SELECT RD.REQID,T.FDES--,C.FDES
--FROM NUTR_FOOD_REQD RD
--JOIN NUTR_FACT T ON T.CODE = RD.REQCODE
--                AND T.FGRC IN ('2414','2421')

--UNION
--SELECT RD.REQID,C.FDES
--FROM NUTR_FOOD_REQD RD
--JOIN NUTR_FACT C ON C.CODE = RD.REQCODE
--                AND C.FGRC IN ('2411','2422')

--SELECT 
--RD.REQID
--,T.FDES AS FOODTYPE
--,B.FDES AS CONC
--,C.FDES AS CC
--,D.FDES AS MEAL
--FROM NUTR_FOOD_REQD RD
--JOIN NUTR_FACT T ON T.CODE = RD.REQCODE
--                AND T.FGRC IN ('2414','2421')

--JOIN (SELECT RD.REQID,C.FDES 
--      FROM NUTR_FOOD_REQD RD
--      JOIN NUTR_FACT C ON C.CODE = RD.REQCODE
--                       AND C.FGRC IN ('2411','2422')) B ON B.REQID = RD.REQID

--JOIN (SELECT RD.REQID,CC.FDES 
--      FROM NUTR_FOOD_REQD RD
--      JOIN NUTR_FACT CC ON CC.CODE = RD.REQCODE
--                       AND CC.FGRC IN ('2412','2423')) C ON C.REQID = RD.REQID

--JOIN (SELECT RD.REQID,M.FDES 
--      FROM NUTR_FOOD_REQD RD
--      JOIN NUTR_FACT M ON M.CODE = RD.REQCODE
--                AND M.FGRC IN ('2413','2424')) D ON D.REQID = RD.REQID

--select *
--from NUTR_FOOD_REQD D
--join NUTR_FACT F on F.CODE = D.REQCODE
--where REQID = '0000T'

select * from VW_REP001_FEEDBYCC order by FOODTYPE, CONC

select FOODTYPE, CONC, sum(convert(int,CC)*convert(int,MEAL)) TOTAL_CC
from VW_REP001_FEEDBYCC
group by FOODTYPE, CONC
order by FOODTYPE, CONC

select FOODTYPE
from VW_REP001_FEEDBYCC
group by FOODTYPE

select CONC
from VW_REP001_FEEDBYCC
group by CONC


--ความเข้มข้น
select FDES
from NUTR_FACT
where FGRC in ('2411','2422')

--ชนิดอาหาร
select FDES
from NUTR_FACT
where FGRC in ('2414','2421')

select 
FOODTYPE,
isnull([0.5:1],0) AS [0.5:1], 
isnull([1:1],0)   AS [1:1],
isnull([1.2:1],0) AS [1.2:1],
isnull([1.5:1],0) AS [1.5:1]
from
(select FOODTYPE, CONC, sum(convert(int,CC)*convert(int,MEAL)) TOTAL_CC
from VW_REP001_FEEDBYCC
group by FOODTYPE, CONC) A 
pivot (SUM(TOTAL_CC) FOR CONC IN ([0.5:1], [1:1],[1.2:1], [1.5:1])) AS pvt
order by FOODTYPE 
delete from NUTR_FOOD_REQD 
where exists
(
select S.*
from NUTR_FOOD_REQS S
where exists (select 1 from NUTR_PADM where AN = S.AN AND WARDID LIKE '2%')
and S.REQID = NUTR_FOOD_REQD.REQID
)

select *
into NUTR_FOOD_REQD_BK
from NUTR_FOOD_REQD

delete
from NUTR_FOOD_REQS
where exists (select 1 from NUTR_PADM where AN = NUTR_FOOD_REQS.AN AND WARDID LIKE '2%')

select *
into NUTR_FOOD_REQS_BK
from NUTR_FOOD_REQS

delete from NUTR_PADM 
where WARDID LIKE '2%'

select *
into NUTR_PADM_BK
from NUTR_PADM

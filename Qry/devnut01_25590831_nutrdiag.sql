--select D.*
--from [DEVHC].dbo.PATDIAG D
--where EXISTS (select 1 from NUTR_DIAG where D.ICDCode = CODE)

--select *
--from NUTR_DIAG


--create view VW_DIAGHIST 
--as 
--select D.Hn,VisitDate,DocCode, N.[DES]
--from [DEVHC].dbo.PATDIAG D
--join NUTR_DIAG N on N.CODE = D.ICDCode

--select *
--from dbo.vwDiagHist

select * from VW_DIAGHIST
where Hn = '     13'

select *
from NUTR_FOOD_REQS R
join VW_DIAGHIST V on V.Hn = R.HN 


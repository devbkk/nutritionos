USE [AYHNUTR]
GO

/****** Object:  View [dbo].[VW_DIAGHIST]    Script Date: 1/9/2559 8:25:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[VW_DIAGHIST] 
as 
select D.Hn, D.VisitDate, D.DocCode, DC.docName+' '+DC.docLName as DocFullName, 
       D.ICDCode AS DIAGCODE, N.[DES] AS DIAGDESC,
       RTRIM(T.titleName)+RTRIM(P.firstName)+' '+RTRIM(P.lastName) AS PATNAME
from [AYH].dbo.PATDIAG D
join [AYH.dbo.DOCC DC on DC.docCode = D.DocCode
join [AYH].dbo.PATIENT P on P.hn = D.Hn
join [AYH].dbo.PTITLE T on T.titleCode = P.titleCode
join NUTR_DIAG N on N.CODE = D.ICDCode


GO



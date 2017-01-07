unit ShareQueryConst;

interface

const

QRY_UPD_RQEND =
'UPDATE NUTR_FOOD_REQS '+
'SET REQENDDATE = B.REQENDDATE, REQEND = ''Y'', REQENDTYPE = %S '+
'FROM '+
'(SELECT MIN(A.REQDATE) AS REQDATE, MAX(A.REQDATE) AS REQENDDATE '+
'FROM '+
'(SELECT TOP 2 REQDATE '+
'FROM NUTR_FOOD_REQS '+
'WHERE AN = %S '+
'ORDER BY REQID DESC) A) B '+
'WHERE NUTR_FOOD_REQS.AN = %S '+
'AND NUTR_FOOD_REQS.REQDATE = B.REQDATE';

implementation

end.

--delete NUTR_FMNU_ITMS
SELECT I.FDID+' '+F.FDNAME AS FDLIST
FROM NUTR_FMNU_ITMS I
JOIN NUTR_FOOD F ON F.FDID = I.FDID
WHERE I.MNUID LIKE '0000000001'

SELECT I.FDID+' '+F.FDNAME AS FDLIST FROM NUTR_FMNU_ITMS I JOIN NUTR_FOOD F ON F.FDID = I.FDID WHERE I.MNUID LIKE ''
select *
from NUTR_FACT

--update NUTR_FACT set FGRP = 'diag',FGRC='03', FTYC='001'
--where FTYP = '‚√§'

SELECT FDES
FROM NUTR_FACT
WHERE FGRP = 'diag'

select *
from NUTR_FOOD_REQS

SELECT 
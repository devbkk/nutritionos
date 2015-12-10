select ih.ladmit_n, ih.ward_id, admit_date, admit_time,
       p.hn, p.titleCode, p.firstName, p.lastName,
	   w.ward_name,
	   t.titleName
from Ipd_h ih
left join Ward w on w.ward_id = ih.ward_id
left join PATIENT p on p.hn = ih.hn
left join PTITLE t on t.titleCode = p.titleCode


--create view dbo.vw_patient
--as
--select ih.ladmit_n, ih.ward_id, admit_date, admit_time,
--       p.hn, p.titleCode, p.firstName, p.lastName,
--	   w.ward_name,
--	   t.titleName
--from Ipd_h ih
--left join Ward w on w.ward_id = ih.ward_id
--left join PATIENT p on p.hn = ih.hn
--left join PTITLE t on t.titleCode = p.titleCode

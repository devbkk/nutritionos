--select ih.ladmit_n, ih.ward_id, admit_date, admit_time,
--       p.hn, p.titleCode, p.firstName, p.lastName,
--	   w.ward_name,
--	   t.titleName
--from Ipd_h ih
--left join Ward w on w.ward_id = ih.ward_id
--left join PATIENT p on p.hn = ih.hn
--left join PTITLE t on t.titleCode = p.titleCode


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

--SELECT ih.ladmit_n, ih.ward_id, admit_date, admit_time,
--       p.hn, p.titleCode, p.firstName, p.lastName, p.birthDay,p.sex,
--	   w.ward_name,
--	   t.titleName,
--	   rtrim(t.titleName)+p.firstName+' '+p.lastName as patname
--FROM Ipd_h ih
--LEFT JOIN Ward w ON w.ward_id = ih.ward_id
--LEFT JOIN PATIENT p ON p.hn = ih.hn
--LEFT JOIN PTITLE t ON t.titleCode = p.titleCode
--WHERE p.firstName LIKE '·´ÊÍº%'

--ISDATE(p.birthDay)

--SELECT *
--FROM
--(SELECT p.hn               AS HN,
--       s.CardID           AS PID,
--	   RTRIM(t.titleName) AS TNAME,
--	   RTRIM(p.firstName) AS FNAME,
--	   RTRIM(p.lastName)  AS LNAME,
--	   CASE WHEN p.sex = 'ª' THEN 'M' ELSE 'F' END AS GENDER,
--       -----------------------------------------------------
--	   CASE WHEN (p.birthDay = null) 
--	        THEN '24000101' 
--	        ELSE CASE WHEN (SUBSTRING(p.birthDay,5,2)='00')OR(SUBSTRING(p.birthDay,7,2)='00') 
--			          THEN SUBSTRING(p.birthDay,1,4)+'0101'
--				      ELSE p.birthDay
--				 END
--       END AS BIRTH,       
--	   ih.ladmit_n        AS AN,
--	   ih.ward_id         AS WARDID,
--	   w.ward_name        AS WARDNAME,
--	   ISNULL(ih.admit_date,'')+ISnULL(admit_time,'')             AS ADMITDATE,
--	   ISNULL(ih.discharge_date,'')+ISNULL(ih.discharge_time,'')  AS DISCHDATE
--FROM Ipd_h ih
--LEFT JOIN Ward w ON w.ward_id = ih.ward_id
--LEFT JOIN PATIENT p ON p.hn = ih.hn
--LEFT JOIN PatSS s on s.hn = ih.hn
--LEFT JOIN PTITLE t ON t.titleCode = p.titleCode) A

--WHERE A.FNAME LIKE '·%'

--WHERE p.firstName LIKE '·%'

--select birthDay
--from PATIENT
--group by birthDay
--order by birthDay

--select convert(datetime,'23190000')

--SELECT    
--       p.hn               AS HN,
--       s.CardID           AS PID,
--	   RTRIM(t.titleName) AS TNAME,
--	   RTRIM(p.firstName) AS FNAME,
--	   RTRIM(p.lastName)  AS LNAME,
--	   CASE WHEN p.sex = 'ª' THEN 'M' ELSE 'F' END AS GENDER,
--	   CASE WHEN (p.birthDay = null)
--	        THEN '24000101'
--	        ELSE CASE WHEN (SUBSTRING(p.birthDay,5,2)='00')OR(SUBSTRING(p.birthDay,7,2)='00')
--			              THEN SUBSTRING(p.birthDay,1,4)+'0101'
--				            ELSE p.birthDay
--				       END
--       END AS BIRTH,
--	   ih.ladmit_n        AS AN,
--	   ih.ward_id         AS WARDID,
--	   w.ward_name        AS WARDNAME,
--	   ISNULL(ih.admit_date,'')+ISnULL(admit_time,'')             AS ADMITDATE,
--	   ISNULL(ih.discharge_date,'')+ISNULL(ih.discharge_time,'')  AS DISCHDATE,
--	   v.[Weight] AS [WEIGHT] , v.Height AS HEIGHT , 
--       RTRIM(t.titleName)+p.firstName+' '+p.lastName as PATNAME
--FROM Ipd_h ih
--LEFT JOIN Ward w ON w.ward_id = ih.ward_id
--LEFT JOIN PATIENT p ON p.hn = ih.hn
--LEFT JOIN PatSS s on s.hn = ih.hn
--LEFT JOIN PTITLE t ON t.titleCode = p.titleCode
--LEFT JOIN VitalSign v ON v.hn = ih.hn
--                     AND v.RegNo = ih.regist_flag 
--WHERE p.firstName LIKE %S


--select *
--from VitalSign

--SELECT
--     --PATIENT
--     p.hn               AS HN,
--     s.CardID           AS PID,
--	   RTRIM(t.titleName) AS TNAME,
--	   RTRIM(p.firstName) AS FNAME,
--	   RTRIM(p.lastName)  AS LNAME,
--	   CASE WHEN p.sex = 'ª' THEN 'M' ELSE 'F' END AS GENDER,
--	   CASE WHEN (p.birthDay = null)
--	        THEN '24000101'
--	        ELSE CASE WHEN (SUBSTRING(p.birthDay,5,2)='00')OR(SUBSTRING(p.birthDay,7,2)='00')
--			              THEN SUBSTRING(p.birthDay,1,4)+'0101'
--				            ELSE p.birthDay
--				       END
--     END AS BIRTH,
--     --ADMISSIION
--	   ih.ladmit_n        AS AN,
--	   ih.ward_id         AS WARDID,
--	   w.ward_name        AS WARDNAME,
--	   ISNULL(ih.admit_date,'')+ISNULL(admit_time,'')             AS ADMITDATE,
--	   ISNULL(ih.discharge_date,'')+ISNULL(ih.discharge_time,'')  AS DISCHDATE,
--     --VITALSIGN
--	 ISNULL(v.[Weight],0) AS WTS,
--     ISNULL(v.Height,0)   AS HTS,
--     --ROOM
--     ih.current_room AS ROOMNO,
--     ih.bed_no       AS BEDNO,
--     --CONCAT
--     RTRIM(t.titleName)+p.firstName+' '+p.lastName as PATNAME,
--	   g.REGCODE, g.REGDES,
--	   ih.regist_flag
--FROM Ipd_h ih
--LEFT JOIN Ward w ON w.ward_id = ih.ward_id
--LEFT JOIN PATIENT p ON p.hn = ih.hn
--LEFT JOIN PatSS s on s.hn = ih.hn
--LEFT JOIN PTITLE t ON t.titleCode = p.titleCode
--LEFT JOIN (SELECT TOP 1 hn, RegNo, [Weight], Height, VitalSignNo
--           FROM VitalSign
--           ORDER BY VitalSignNo DESC ) v ON v.hn = ih.hn
--                                   AND v.RegNo = ih.regist_flag
--LEFT JOIN Room r ON r.room_no = ih.current_room
--LEFT JOIN Religion g on g.REGCODE = p.religion
--WHERE ISNULL(ih.discharge_date,'') = ''
--AND 
--(
-- ((p.firstName LIKE '%')AND(1=2))OR
-- ((p.hn LIKE '%')AND(2=2))OR
-- ((w.ward_name LIKE '%')AND(3=2))
--)

--select top 1 hn, RegNo, [Weight], Height, VitalSignNo
--from VitalSign
--where hn = '    105'
--and RegNo = '0003'
--order by VitalSignNo desc

SELECT *, RTRIM(CODE)+':'+[DES] AS FULLDES
FROM ICD101
WHERE CODE BETWEEN 'E110' AND 'E119'
OR CODE = 'I10'
OR CODE BETWEEN 'E780' AND 'E789'
OR CODE = 'N179'
OR CODE = 'N19'
OR CODE BETWEEN 'N181' AND 'N185'
OR CODE BETWEEN 'M100' AND 'M109'
OR CODE BETWEEN 'I20.0' AND 'I25.9'
OR CODE LIKE 'C%'
OR CODE BETWEEN 'E660' AND 'E669'
OR CODE BETWEEN 'I630' AND 'I639'
OR CODE = 'I64'
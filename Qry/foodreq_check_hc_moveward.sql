select  ward_id, current_room, current_bed, bed_no, *
from Ipd_h
where hn = '1482123'
and regist_flag = '0001'

--select ward_id, room_no, hn, regist_flag, runno
--from Resident
--group by ward_id, room_no, hn, regist_flag, runno
--having hn = '1482123' and regist_flag = '0001'
--order by ward_id, room_no, hn, regist_flag, runno

select  top 1 ward_id, room_no, bed_no,* 
from Resident 
where hn = '1482123' and regist_flag = '0001'
order by check_in_date desc, check_in_time desc


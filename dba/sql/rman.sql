set echo off
set feed off
set veri off
set pagesize 2000
set linesize 200
set escape on
set serveroutput on

col status format A20
col owner format a30
col username format a30
col host format a30
col db_link format a30
select jd.input_type,
case when last_run.start_time > sysdate -8 and last_run.input_type = 'RECVR AREA' then jd.status
when last_run.start_time > sysdate -26/24  and last_run.input_type in ('ARCHIVELOG','DB INCR') then jd.status
when last_run.input_type not in ('ARCHIVELOG','DB INCR','RECVR AREA') then jd.status
else 'OVERDUE'
end as status
from V$RMAN_BACKUP_JOB_DETAILS jd
join
(select input_type,max(start_time) start_time
  FROM V$RMAN_BACKUP_JOB_DETAILS
  group by input_type) last_run
on jd.input_type = last_run.input_type and jd.start_time = last_run.start_time;


-- Image copies 

select * from
( select count(*) as DBF_COUNT from v$datafile ) ,
( select count(*) as IMG_COPY_COUNT from v$backup_copy_details),
( select count(*) as IMG_COPY_NOT_UPD from v$backup_copy_details where COMPLETION_TIME < sysdate - 1),
( select min(COMPLETION_TIME) as IMG_COPY_LAST_UPD_DATE from  v$backup_copy_details);

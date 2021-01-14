set echo off
set feed off
set veri off
set pagesize 2000 
set linesize 200
set escape on
set serveroutput on

ttitle off

col inst_id format a1 head "I|*"
col sid format 9999
col opname format a14 head "Operation Name"
col message format a82 wrap head "Message"
col lut head "Last|Update"
col pct_done format 999.9 head "Pct|Done"
col elapsed_seconds format 999,999 head "Elapsed|Seconds"
col time_remaining format 999,999 head "Seconds|to Go"
col total_seconds format 999,999 head "Projected|Seconds"

clear breaks
break on sid nodup

select ltrim(to_char(slop.inst_id,'9'),' ') inst_id,
       slop.sid,
       slop.message,
       round(slop.sofar*100/slop.totalwork,1) pct_done,
       slop.elapsed_seconds,
       slop.time_remaining,
       slop.elapsed_seconds + slop.time_remaining total_seconds
  from gv$session_longops slop,
       gv$session s
 where slop.sofar < slop.totalwork
   and slop.inst_id = s.inst_id
   and slop.sid = s.sid
   and slop.start_time >= s.logon_time
   and s.status = 'ACTIVE'
 order by slop.inst_id, slop.sid, slop.start_time;


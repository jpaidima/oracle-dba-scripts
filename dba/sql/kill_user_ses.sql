set echo off
set feed off
set veri off
set pagesize 2000 
set linesize 200
set escape on
set serveroutput on
col machine format a30
col service_name format a40
col service format a40
col osuser format A20
col program format A40

prompt Total Sessions by Instance 
select count(*) "Sessions",inst_id "Instance"
from gv$session
where username=upper('&1')
group by inst_id
order by inst_id;

prompt
prompt Session Details 

set linesize 100

select 'alter system kill session '||''''||sid||','||serial#||',@'||inst_id||''''|| '  immediate;' from gv$session where 
username=upper('&1') order by inst_id;

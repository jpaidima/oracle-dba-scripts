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

prompt
prompt Session Details

set linesize 200

select 'alter system kill session '||''''||sid||','||serial#||',@'||inst_id||''''|| ' immediate;' from gv$session
 where
sql_id='&1' order by inst_id;

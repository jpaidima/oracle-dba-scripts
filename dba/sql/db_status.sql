set echo off
set feed off
set veri off
set pagesize 32
set linesize 132
set escape on
set serveroutput on
column instance_name format a8
column status format a9
column database_status format a18
column instance_role format a16
column open_mode format a10
column database_role format a16
column protection_mode format a19
column remote_archive format a9
column switchover_status format a25
column host_name format a30
select sysdate as DATABASE_STATUS from dual;
SELECT
        inst_id
        ,open_mode
        ,database_role
        ,protection_mode
        ,remote_archive
        ,dataguard_broker broker
        ,switchover_status
FROM
        gv$database
ORDER BY
        inst_id
;

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
column startup_time format A20
select sysdate as INSTANCE_STATUS from dual;
SELECT
        instance_name
        ,status
        ,to_char(startup_time, 'DD-MON-YY HH24:MI:SS') startup_time
        ,database_status
        ,instance_role
        ,thread#
        ,host_name
FROM
        gv$instance
ORDER BY
        instance_name
;

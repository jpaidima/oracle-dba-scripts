set echo off
set feed off
set veri off
set pagesize 30 
set linesize 200 
set escape on
set serveroutput on
column running_instance format 99 
col OWNER format A30
column elapsed_time format a25
column job_name format a35
select sysdate as SCHEDULER_RUNNING_JOBS from dual;
SELECT
        owner
        ,job_name
        ,running_instance
        ,session_id
        ,elapsed_time
FROM
        dba_scheduler_running_jobs 
ORDER BY
        owner
        ,job_name
;

set echo off
set feed off
set veri off
set pagesize 30 
set linesize 200 
set escape on
set serveroutput on
column running_instance format 99 
col NAME format A10
col OWNER format A30
column elapsed_time format a25
column job_name format a35
select sysdate as SCHEDULER_RUNNING_JOBS from dual;
SELECT
        name
        ,owner
        ,job_name
        ,running_instance
        ,session_id
        ,elapsed_time
FROM
        v$containers a,
        cdb_scheduler_running_jobs b
WHERE   a.con_id = b.con_id
ORDER BY
        name
        ,owner
        ,job_name
;

set echo off
set feed off
set veri off
set pagesize 32
set linesize 132
set escape on
set serveroutput on
column  name format a12
column  SPACE_LIMIT_GB format 999,999
column  SPACE_USED_GB format 999,999
column  SPACE_RECLAIMABLE_GB format 999,999
select sysdate as V\$RECOVERY_FILE_DEST from dual;
SELECT
        name,
        SPACE_LIMIT / 1024/1024/1024 space_limit_gb,
        SPACE_USED / 1024/1024/1024 space_used_gb,
        SPACE_RECLAIMABLE / 1024/1024/1024 space_reclaimable_gb,
        NUMBER_OF_FILES
FROM
        v$recovery_file_dest
;
column  file_type format a35
column  PCT_SPACE_USED format 999
column  PCT_SPACE_reclaimable format 999
select sysdate as V$RECOVERY_AREA_USAGE from dual;
SELECT
        file_type,
        PERCENT_SPACE_USED pct_space_used,
        PERCENT_SPACE_RECLAIMABLE pct_space_reclaimable,
        NUMBER_OF_FILES
FROM
        v$recovery_area_usage
;

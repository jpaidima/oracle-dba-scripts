set echo off
set feed off
set veri off
set pagesize 32
set linesize 132

column NAME format a10
column TYPE format a6
column TOTAL_GB format 999,999,999 head 'TOTAL GB'
column total_w_redundancy_GB format 999,999 head 'TOTAL|with|REDUNDANCY|GB'
column free_w_redundancy_GB format 999,999 head 'FREE|with|REDUNDANCY|GB'
column USABLE_FILE_GB format 999,999 head 'USABLE|FILE GB|(*)'
column FREE_GB format 999,999 head 'FREE GB'
column USABLE_FILE_MB format 999,999,999
column USABLE_CALC format 999,999,999
column required_mirror_free_mb format 999,999,999
column required_mirror_free_gb format 999,999 head 'REQUIRED|MIRROR|FREE GB'
column Pct_Used format 999.9 head 'PCT|USED|(**)'
column MB_Free format 999,999,999
column STATE format a9
break on report
compute sum label TOTAL of TOTAL_GB total_w_redundancy_GB free_w_redundancy_GB FREE_GB USED_MB USABLE_FILE_GB required_mirror_free_gb on Report
SELECT
        name,
        type,
        state,
        total_mb/1024 total_gb,
        (case type
                when 'NORMAL' then (total_mb / 2) / 1024
                when 'HIGH' then (total_mb / 3) / 1024
         end ) total_w_redundancy_GB,
        free_mb/1024 free_gb,
        (case type
                when 'NORMAL' then (free_mb / 2) / 1024
                when 'HIGH' then (free_mb / 3) / 1024
         end ) free_w_redundancy_GB,
        usable_file_mb/1024 usable_file_gb,
        required_mirror_free_mb/1024 required_mirror_free_gb,
        (case type
                when 'NORMAL' then (( 1 - (usable_file_mb / (total_mb/2) )) * 100)
                when 'HIGH' then (( 1 - (usable_file_mb / (total_mb/3) )) * 100)
         end ) pct_used
FROM
        v$asm_diskgroup
ORDER BY
         1

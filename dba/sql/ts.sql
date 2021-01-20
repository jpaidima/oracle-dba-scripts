-- Tablespace sql
set echo off
set feed off
set veri off
set pagesize 32
set linesize 132

column Name format a20
column MB_Alloc format 999,999,999
column MB_Used format 999,999,999
column Pct_Used format 999.9
column MB_Free format 999,999,999
column Status format a7
column Data_File_Count  heading 'DATA|FILE|COUNT' format 9999
column Contents format a9
column extent_management heading 'EXTENT|MGMT' format a9
column segment_space_management heading 'SEG|SPACE|MGMT' format a9
break on report
compute sum label TOTAL of MB_Alloc MB_Used MB_Free on Report
SELECT /*+ first_rows */ 
        d.tablespace_name Name, 
        NVL((a.bytes - NVL(f.bytes, 0)) / a.bytes * 100, 0) Pct_Used, 
        NVL(a.bytes / 1024 / 1024, 0) MB_Alloc, 
        NVL(a.bytes - NVL(f.bytes, 0), 0)/1024/1024 MB_Used, 
        NVL(f.bytes, 0) / 1024 / 1024 MB_Free, 
        d.status Status, 
        a.count Data_File_Count, 
        d.contents Contents, 
        d.Encrypted Encrypted, 
        d.extent_management extent_management, 
        d.segment_space_management  segment_space_management
FROM 
        sys.dba_tablespaces d, 
        (select tablespace_name, sum(bytes) bytes, count(file_id) count from dba_data_files group by tablespace_name) a, 
        (select tablespace_name, sum(bytes) bytes from dba_free_space group by tablespace_name) f 
WHERE 
        d.tablespace_name = a.tablespace_name(+) 
        AND d.tablespace_name = f.tablespace_name(+) 
        AND NOT d.contents = 'UNDO' 
        AND NOT (d.extent_management = 'LOCAL' AND d.contents = 'TEMPORARY') 
UNION ALL 
        SELECT d.tablespace_name Name,  
        NVL(t.bytes / a.bytes * 100, 0), 
        NVL(a.bytes / 1024 / 1024, 0), 
        NVL(t.bytes, 0)/1024/1024, 
        (NVL(a.bytes ,0)/1024/1024 - NVL(t.bytes, 0)/1024/1024), 
        d.status, 
        a.count, 
        d.contents, 
        d.encrypted,
        d.extent_management, 
        d.segment_space_management 
FROM 
        sys.dba_tablespaces d , 
        (select tablespace_name, sum(bytes) bytes, 
        count(file_id) count from dba_temp_files group by tablespace_name) a, 
        (select ss.tablespace_name , sum((ss.used_blocks*ts.blocksize)) bytes from gv$sort_segment ss, 
        sys.ts$ ts where ss.tablespace_name = ts.name group by ss.tablespace_name) t 
WHERE 
        d.tablespace_name = a.tablespace_name(+) 
        AND d.tablespace_name = t.tablespace_name(+) 
        AND d.extent_management = 'LOCAL' 
        AND d.contents = 'TEMPORARY' 
UNION ALL 
        SELECT d.tablespace_name ,  
        NVL(u.bytes / a.bytes * 100, 0), 
        NVL(a.bytes / 1024 / 1024, 0), 
        NVL(u.bytes, 0) / 1024 / 1024, 
        NVL(a.bytes - NVL(u.bytes, 0), 0)/1024/1024, 
        d.status, 
        a.count, 
        d.contents, 
        d.encrypted,
        d.extent_management, 
        d.segment_space_management 
FROM 
        sys.dba_tablespaces d, 
        (SELECT tablespace_name, SUM(bytes) bytes, COUNT(file_id) count FROM dba_data_files GROUP BY tablespace_name) a, 
        (SELECT tablespace_name, SUM(bytes) bytes FROM (SELECT tablespace_name,sum (bytes) bytes,status 
                                                        from dba_undo_extents WHERE status ='ACTIVE' 
                                                        group by tablespace_name,status 
                                                        UNION ALL
                                                        SELECT tablespace_name,sum(bytes) bytes,status 
                                                        from dba_undo_extents WHERE status ='UNEXPIRED' 
                                                        group by tablespace_name,status ) group by tablespace_name ) u 
WHERE 
        d.tablespace_name = a.tablespace_name(+) 
        AND d.tablespace_name = u.tablespace_name(+) 
        AND d.contents = 'UNDO' 
ORDER BY 
         2 desc
;

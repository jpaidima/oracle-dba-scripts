break on segment_type

col SEGMENT_NAME for A40
select segment_type, SEGMENT_NAME, bytes/1024/1024 "Size MB" from dba_segments 
where TABLESPACE_NAME=upper('&1') order by 1,3 ;

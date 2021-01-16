col table_name format A60
col index_name format A60

select count(dt.TABLE_NAME)  
from dba_tables dt, dba_objects do
where 
dt.table_name=do.object_name and
dt.last_analyzed < do.last_ddl_time;

select count(dt.Index_NAME)
from dba_indexes dt, dba_objects do
where 
dt.index_name=do.object_name and
dt.last_analyzed < do.last_ddl_time;


select dt.TABLE_NAME, dt.LAST_ANALYZED, do.LAST_DDL_TIME 
from dba_tables dt, dba_objects do
where 
dt.table_name=do.object_name and
dt.last_analyzed < do.last_ddl_time
--and dt.owner in ('<owner>')
order by 2;

select dt.Index_NAME, dt.LAST_ANALYZED, do.LAST_DDL_TIME 
from dba_indexes dt, dba_objects do
where 
dt.index_name=do.object_name and
dt.last_analyzed < do.last_ddl_time
--and dt.owner in ('<owner>')
order by 2;

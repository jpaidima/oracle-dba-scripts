set linesize 200

-- View resource manager details 
col grantee format A30
col granted_group format A30
SELECT * FROM DBA_RSRC_CONSUMER_GROUP_PRIVS;

-- Sessions using which resource group 
col USERNAME format A40
col RESOURCE_CONSUMER_GROUP format a70
SELECT SID,SERIAL#,USERNAME,RESOURCE_CONSUMER_GROUP FROM V$SESSION;

select count(*) , RESOURCE_CONSUMER_GROUP 
from 
gv$session 
group by RESOURCE_CONSUMER_GROUP;

-- Plan cpu details 
select plan, group_or_subplan, type, cpu_p1, cpu_p2, cpu_p3, cpu_p4, status
   from dba_rsrc_plan_directives order by 1,2,3,4,5,6

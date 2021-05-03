-- List dir's
set linesize 200
col DIRECTORY_NAME format A40
col DIRECTORY_PATH format A80
col OWNER format A30

select OWNER,DIRECTORY_NAME,DIRECTORY_PATH from dba_directories;

-- Dir permission 
select GRANTOR,GRANTEE, PRIVILEGE
from all_tab_privs
where
   table_name in (select directory_name
   from dba_directories
   where directory_name='&1'
   );
 

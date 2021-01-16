-- 11g

select * from (SELECT ACTION_TIME||' '||comments||' '||BUNDLE_SERIES||' '|| VERSION||' '||id
FROM registry$history where comments like '%BP%'order by ACTION_TIME desc ) where rownum < 2;


-- 12c 

select PATCH_ID ||' '|| BUNDLE_SERIES ||' '||BUNDLE_ID||' ' || ACTION ||' '||STATUS||' '||ACTION_TIME as version 
      from dba_registry_sqlpatch
  where BUNDLE_SERIES  in ('DBBP','DBRU') and ACTION_TIME = ( select max(ACTION_TIME) from dba_registry_sqlpatch where BUNDLE_SERIES  in ('DBBP','DBRU') )
  and substr(version,1,instr(version,'.',2,2)) = (select substr(version,1,instr(version,'.',2,2)) from v$instance) 
union all
select 'No BP Applied' from dual 
   where not exists (select BUNDLE_SERIES  from dba_registry_sqlpatch
  where BUNDLE_SERIES  in ('DBBP','DBRU') and ACTION_TIME = ( select max(ACTION_TIME) from dba_registry_sqlpatch where BUNDLE_SERIES  in ('DBBP','DBRU') )
  and substr(version,1,instr(version,'.',2,2)) = (select substr(version,1,instr(version,'.',2,2)) from v$instance) );

-- 18c and above 
set linesize 150
col DESCRIPTION format A60
col action format A20
col status format A20
col action_time format A30
$MY_SET_PDB

select DESCRIPTION , action, status, action_time 
from dba_registry_sqlpatch 
where patch_type='RU' and  
ACTION_TIME = ( select max(ACTION_TIME) from dba_registry_sqlpatch where patch_type='RU');


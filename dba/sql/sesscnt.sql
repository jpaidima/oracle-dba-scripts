set echo off
set feed off
set veri off
set pagesize 2000
set linesize 200
set escape on
set serveroutput on
col machine format a40
col service_name format a40
col service format a40

prompt Total Sessions by Instance
select count(*) "Sessions",inst_id "Instance"
from gv$session
group by inst_id
order by inst_id;

prompt
prompt Total Sessions by Status
select count(*) "Sessions",inst_id "Instance", status
from gv$session
group by inst_id,status
order by inst_id;

set linesize 200

select machine "Machine",
  	    count(*) "Total Sessions",
  	    sum(decode(se.inst_id,1,1,0)) "Inst 1",
      sum(decode(se.inst_id,2,1,0)) "Inst 2",
      sum(decode(se.inst_id,3,1,0)) "Inst 3",
      sum(decode(se.inst_id,4,1,0)) "Inst 4",
      sum(decode(se.inst_id,5,1,0)) "Inst 5",
  	    sum(decode(se.inst_id,6,1,0)) "Inst 6",
          	    sum(decode(se.inst_id,7,1,0)) "Inst 7",
                  	    sum(decode(se.inst_id,8,1,0)) "Inst 8"
    from gv$session se
  group by machine
 order by machine;

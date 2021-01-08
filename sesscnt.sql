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

-- Check 
set linesize 150
  col TIME format A40
  col name format A50
  select time,name from v$restore_point;
  
  
-- Drop 
set serveroutput on 

declare

   cursor c_rp is
      select name from v$restore_point;

begin

   for j in c_rp loop
     begin
      dbms_output.put_line('Dropping restore point : '||j.name);
          execute immediate 'drop restore point '||j.name ; 
     end;
   end loop;

end;
/ 

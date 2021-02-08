select name from dba_services
minus
select name from gv$active_services;

-- To drop 

set serveroutput on
declare

cursor c_inactive_services is
select name from dba_services
minus
select name from gv$active_services;

begin

for j in c_inactive_services loop
begin
dbms_service.delete_service(j.name);
dbms_output.put_line('Removed inactive service: '||j.name);
exception when others then
dbms_output.put_line('Trying to remove service '||j.name ||'Got error: ' || SQLERRM(SQLCODE));
end;
end loop;

end;
/

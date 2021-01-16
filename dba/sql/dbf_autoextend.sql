-- Check autoextend stats
set feed off
repheader left 'Autoextensible count for dbf files' skip 2
select count(*), AUTOEXTENSIBLE from dba_data_files group by AUTOEXTENSIBLE; 

repheader left 'Autoextensible count for temp files' skip 2
select count(*), AUTOEXTENSIBLE from dba_temp_files group by AUTOEXTENSIBLE;



-- Turn on 
set serveroutput on
set feedback off
 
declare
   cursor c_files is
   select file_name from dba_data_files where AUTOEXTENSIBLE='NO';
   lv_cmd varchar2(300);
begin

   for j in c_files loop
     begin
      lv_cmd := 'alter database datafile '||''''||j.file_name||''''||' autoextend on';
      dbms_output.put_line('Executing '||lv_cmd);
      DBMS_UTILITY.EXEC_DDL_STATEMENT(lv_cmd);
     exception when others then
      dbms_output.put_line('ERROR '|| SQLERRM(SQLCODE));
     end;
   end loop;

end;
/

declare
   cursor c_files is
   select file_name from dba_temp_files where AUTOEXTENSIBLE='NO'; 
   lv_cmd varchar2(300);
begin

   for j in c_files loop
     begin
      lv_cmd := 'alter database tempfile '||''''||j.file_name||''''||' autoextend on';
      dbms_output.put_line('Executing '||lv_cmd);
      DBMS_UTILITY.EXEC_DDL_STATEMENT(lv_cmd);
     exception when others then
      dbms_output.put_line('ERROR '|| SQLERRM(SQLCODE));
     end;
   end loop;

end;
/


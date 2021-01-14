set feed off
set pagesize 2000
set linesize 200
set serveroutput on

declare

l_result varchar2(1000);
l_status number default null;
l_cursor integer;

begin
  
 execute immediate ('ALTER SESSION SET GLOBAL_NAMES=FALSE');
    for c1 in
     (  select      u.user_id ,
                      d.owner ,
                    d.db_link
        from
                dba_db_links d, 
                   dba_users u
        where d.owner=u.username
        order by d.owner
      ) loop
 
    begin
     
      l_cursor:=sys.dbms_sys_sql.open_cursor();

      sys.dbms_sys_sql.parse_as_user(l_cursor,'select * from global_name@'||c1.db_link,dbms_sql.native,c1.user_id);

      sys.dbms_sys_sql.define_column( l_cursor,1,l_result,1000);

      l_status:=sys.dbms_sys_sql.execute(l_cursor);
       
      if ( dbms_sys_sql.fetch_rows(l_cursor) > 0 )
          then
             dbms_sys_sql.column_value(l_cursor, 1,l_result );
      end if;
     
      dbms_output.put_line(c1.owner||':'||c1.db_link||':'||l_result);

      sys.dbms_sys_sql.close_cursor(l_cursor);

      commit;

    exception
       when others      then dbms_output.put_line(c1.owner||':'||c1.db_link||':'||SQLERRM);
     
     end;

  end loop;

end ;
/


set feed off
set pagesize 2000
set linesize 200
set serveroutput on

alter session set global_names=false;

declare
   cursor c_dblinks is
     select * from dba_db_links where owner='PUBLIC' order by 1;
   lv_cmd varchar2(200);
   lv_result varchar(200);

begin

   for j in c_dblinks loop

      begin

         lv_cmd := 'select * from global_name@'||j.db_link;

         execute immediate lv_cmd into lv_result ;

                 dbms_output.put_line(j.owner||':'||j.db_link||':'||lv_result);

         rollback;
         DBMS_SESSION.CLOSE_DATABASE_LINK(j.db_link);


      EXCEPTION
         when others then
            dbms_output.put_line(j.owner||':'||j.db_link||':'||SQLERRM);
      end;

   end loop;

end;
/

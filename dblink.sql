set echo off
set feed off
set veri off
set pagesize 2000
set linesize 200
set escape on
set serveroutput on
col owner format a30
col username format a30
col host format a40
col db_link format a30

prompt DB Links from dba_db_links
select * from dba_db_links order by owner,db_link;

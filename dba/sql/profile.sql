set linesize 2000
set serveroutput on size 50000
set echo off feed off veri off

col resource_name format A25
col resource_type format A10
col limit format A15
col profile format A30
col username format A30

select distinct profile from dba_profiles order by 1;


-- Profile info 
set linesize 2000
set serveroutput on size 50000
set echo off feed off veri off

col resource_name format A25
col resource_type format A10
col limit format A15

repheader left 'Profile Details' skip 2

select profile, RESOURCE_NAME, RESOURCE_TYPE,LIMIT
 from dba_profiles
 where profile='<profile name>';
 
- User and profiles 
select username , profile from dba_users
order by profile;

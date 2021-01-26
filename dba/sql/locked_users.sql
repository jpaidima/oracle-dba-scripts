set echo off
set feed off
set veri off
set pagesize 2000 
set linesize 200
set escape on
set serveroutput on
col machine format a30
col service_name format a40
col service format a40
col osuser format A20
col program format A40

repheader left 'WARN: Found locked users ' skip 2

col username format A30
col account_status format A30
col profile format A30

select username, account_status, profile,LOCK_DATE from dba_users 
where account_status like '%LOCK%' and username not in ('XS\$NULL','DVSYS');


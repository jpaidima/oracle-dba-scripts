set feedback off
set serveroutput on

set linesize 200
col WRL_TYPE format A8
col STATUS format A8
col WALLET_TYPE format A15
col FULLY_BACKED_UP format A10
col WALLET_ORDER format A10
col WRL_PARAMETER format A50

select * from gv$encryption_wallet;

repheader left 'WARN: Found tablespaces that are not Encrypted' skip 2

col TABLESPACE_NAME format A40

select TABLESPACE_NAME,CONTENTS , ENCRYPTED from dba_tablespaces
    where contents not in ('UNDO','TEMPORARY') and
  tablespace_name not in ('SYSTEM','SYSAUX') and ENCRYPTED='NO';

repheader left 'Checking encrypt_new_tablespaces init parameter ' skip 2
col NAME format a30
col value format a20

select name, value from v$parameter where name='encrypt_new_tablespaces';




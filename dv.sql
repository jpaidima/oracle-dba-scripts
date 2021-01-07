col comp_name format A30
col status format A30
col parameter format A30
col value format A30

select comp_name,status from dba_registry where comp_name in ('Oracle Database Vault','Oracle Label Security');

select * from v$option where parameter in ('Oracle Label Security','Oracle Database Vault');

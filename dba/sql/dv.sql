col comp_name format A30
col status format A30
col parameter format A30
col value format A30

select comp_name,status from dba_registry where comp_name in ('Oracle Database Vault','Oracle Label Security');

select * from v$option where parameter in ('Oracle Label Security','Oracle Database Vault');


col GRANTEE format A10
col GRANTED_ROLE format A40
select grantee , granted_role from dba_role_privs where granted_role='DV_PATCH_ADMIN' and grantee='SYS';

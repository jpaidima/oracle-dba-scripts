-- Check account and pwd versions 
select username , PASSWORD_VERSIONS , ACCOUNT_STATUS from dba_users where username='<username>';

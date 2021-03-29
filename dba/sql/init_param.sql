-- Check init parameters set at spfile level
col sid format A10
col name format A40
col value format A40

select sid, NAME,VALUE from v$spparameter where name like '%&&1%';


-- Check which init parameters are modifiable at pdb level 
select name, ispdb_modifiable
   from v$system_parameter
    where ispdb_modifiable = 'TRUE';
   
-- Change to pdb and set init parameter needed at pdb level 

-- As cdb run this query to verify pdb level parameters   
col db_uniq_name format a10
col name format a15
col value$ format a10
select db_uniq_name, pdb_uid, name, value$ from pdb_spfile$;

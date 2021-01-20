-- Table level 
exec DBMS_STATS.GATHER_TABLE_STATS('<schema name>', '<table name>'); 

-- Schema level 
exec DBMS_STATS.GATHER_SCHEMA_STATS('<schema name>');

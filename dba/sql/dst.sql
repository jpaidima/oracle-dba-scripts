set linesize 200
col filename format A50

select * from v$timezone_file;

col PROPERTY_NAME format A40
col VALUE format A20

SELECT PROPERTY_NAME, SUBSTR(property_value, 1, 30) value
FROM DATABASE_PROPERTIES
WHERE PROPERTY_NAME LIKE 'DST_%'
ORDER BY PROPERTY_NAME;

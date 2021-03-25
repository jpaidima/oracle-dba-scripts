SET LINESIZE 200
COLUMN time FORMAT A30
COLUMN name FORMAT A30
COLUMN cause FORMAT A30
COLUMN message FORMAT A120
set pagesize 100
SELECT time, name, cause, message
FROM   pdb_plug_in_violations
WHERE  status='PENDING'
ORDER BY time;

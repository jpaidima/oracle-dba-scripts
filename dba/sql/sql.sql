SET LINESIZE 32767
SET LONG 100000
SET LONGCHUNKSIZE 100000
SET PAGESIZE 0
SET VERIFY OFF
SET TRIMS ON
select '--'||sql_id
        ,SQL_FULLTEXT
from
        gv$sqlarea
where
      sql_id  = '&1'
;

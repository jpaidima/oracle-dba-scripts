set echo off

column open_mode format a10
col name format a20
col open_time format A40

SELECT
        inst_id, NAME,
        open_mode
FROM
        gv$CONTAINERS
ORDER BY
        name, inst_id
;

SELECT
        inst_id, NAME,
        open_mode, OPEN_TIME
FROM
        gv$pdbs
ORDER BY
        name, inst_id
;



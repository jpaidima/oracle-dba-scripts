set echo off

column open_mode format a10
col name format a20

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
        open_mode
FROM
        gv$pdbs
ORDER BY
        name, inst_id
;



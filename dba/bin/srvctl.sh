# listener examples 

srvctl add listener -listener listener_e -endpoints "TCP:1522"  -oraclehome $ORACLE_HOME 

srvctl setenv listener  -listener listener_e -env "TNS_ADMIN=/u01/app/19.0.0.0/grid/network/admin_enc"

srvctl getenv  listener  -listener listener_e

srvctl start listener -listener listener_e

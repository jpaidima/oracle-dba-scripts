select network_service_banner from v$session_connect_info where sid in (select distinct sid from v$mystat);

NETWORK_SERVICE_BANNER                                                          
--------------------------------------------------------------------------------
TCP/IP NT Protocol Adapter for Linux: Version 18.0.0.0.0 - Production           
Encryption service for Linux: Version 18.0.0.0.0 - Production                   
AES256 Encryption service adapter for Linux: Version 18.0.0.0.0 - Production    
Crypto-checksumming service for Linux: Version 18.0.0.0.0 - Production          
SHA1 Crypto-checksumming service adapter for Linux: Version 18.0.0.0.0 - Production                                                                             

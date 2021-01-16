#
# To create services for pdb 
#
srvctl add service -d < db uniq name> -s < service name> -pdb <pdb name> \
-preferred < instance list> \
-role PRIMARY,PHYSICAL_STANDBY,SNAPSHOT_STANDBY

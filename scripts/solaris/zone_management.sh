#!/bin/bash
# Solaris Zone Management Script

ZONE_NAME=$1
ACTION=$2

usage() {
    echo "Usage: $0 <zone_name> {create|clone|migrate|backup}"
    exit 1
}

if [ -z "$ZONE_NAME" ] || [ -z "$ACTION" ]; then
    usage
fi

case $ACTION in
    create)
        # Create a new zone
        zonecfg -z $ZONE_NAME 'create; set zonepath=/zones/'$ZONE_NAME'; commit'
        zoneadm -z $ZONE_NAME install
        zoneadm -z $ZONE_NAME boot
        ;;
    
    clone)
        # Clone existing zone
        SOURCE_ZONE=$3
        if [ -z "$SOURCE_ZONE" ]; then
            echo "Source zone required for cloning"
            exit 1
        fi
        zoneadm -z $SOURCE_ZONE halt
        zonecfg -z $ZONE_NAME 'create -t '$SOURCE_ZONE'; set zonepath=/zones/'$ZONE_NAME'; commit'
        zoneadm -z $ZONE_NAME clone $SOURCE_ZONE
        zoneadm -z $ZONE_NAME boot
        zoneadm -z $SOURCE_ZONE boot
        ;;
    
    migrate)
        # Prepare zone for migration
        zoneadm -z $ZONE_NAME detach
        tar -cf /export/zones/${ZONE_NAME}.tar /zones/$ZONE_NAME
        echo "Zone archived to /export/zones/${ZONE_NAME}.tar"
        ;;
    
    backup)
        # Backup zone configuration
        zonecfg -z $ZONE_NAME export > /export/backup/${ZONE_NAME}.cfg
        zfs snapshot rpool/zones/${ZONE_NAME}@backup_$(date +%Y%m%d)
        ;;
    
    *)
        usage
        ;;
esac

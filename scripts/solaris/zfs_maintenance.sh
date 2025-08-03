#!/bin/bash
# ZFS Maintenance Script for Solaris

# Function to check pool health
check_pool_health() {
    echo "=== ZFS Pool Health Check ==="
    zpool status -x
    echo
    
    for pool in $(zpool list -H -o name); do
        echo "Pool: $pool"
        zpool status $pool | grep -E "state:|errors:"
        echo
    done
}

# Function to create snapshots
create_snapshots() {
    POOL=$1
    if [ -z "$POOL" ]; then
        echo "Usage: create_snapshots <pool_name>"
        return 1
    fi
    
    DATE=$(date +%Y%m%d_%H%M%S)
    for fs in $(zfs list -H -o name -r $POOL); do
        echo "Creating snapshot: ${fs}@backup_${DATE}"
        zfs snapshot ${fs}@backup_${DATE}
    done
}

# Function to cleanup old snapshots
cleanup_snapshots() {
    DAYS=${1:-30}
    echo "Cleaning up snapshots older than $DAYS days"
    
    for snap in $(zfs list -H -t snapshot -o name); do
        SNAP_DATE=$(echo $snap | grep -oE '[0-9]{8}')
        if [ ! -z "$SNAP_DATE" ]; then
            SNAP_EPOCH=$(date -d $SNAP_DATE +%s 2>/dev/null || date -j -f "%Y%m%d" $SNAP_DATE +%s)
            CURRENT_EPOCH=$(date +%s)
            AGE_DAYS=$(( ($CURRENT_EPOCH - $SNAP_EPOCH) / 86400 ))
            
            if [ $AGE_DAYS -gt $DAYS ]; then
                echo "Destroying old snapshot: $snap"
                zfs destroy $snap
            fi
        fi
    done
}

# Main execution
case "$1" in
    health)
        check_pool_health
        ;;
    snapshot)
        create_snapshots $2
        ;;
    cleanup)
        cleanup_snapshots $2
        ;;
    *)
        echo "Usage: $0 {health|snapshot <pool>|cleanup [days]}"
        exit 1
        ;;
esac

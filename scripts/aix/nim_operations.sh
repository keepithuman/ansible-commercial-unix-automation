#!/usr/bin/ksh
# Common NIM operations script

usage() {
    echo "Usage: $0 {backup|restore|install|check} [options]"
    exit 1
}

case "$1" in
    backup)
        # Create mksysb backup via NIM
        nim -o define -t mksysb \
            -a server=master \
            -a location=/export/nim/mksysb/$(hostname).mksysb \
            -a source=$(hostname) \
            -a mk_image=yes \
            $(hostname)_mksysb
        ;;
    
    restore)
        # Restore from mksysb
        nim -o bos_inst \
            -a source=mksysb \
            -a mksysb=$(hostname)_mksysb \
            -a spot=aix73_spot \
            $(hostname)
        ;;
    
    install)
        # Install software from NIM
        nim -o cust \
            -a lpp_source=$2 \
            -a installp_flags="-agX" \
            $(hostname)
        ;;
    
    check)
        # Check NIM status
        nim -o check $(hostname)
        lsnim -l $(hostname)
        ;;
    
    *)
        usage
        ;;
esac

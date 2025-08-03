#!/bin/bash
# Useful ad-hoc commands for Commercial Unix management

# Check connectivity to all Unix hosts
ansible -i inventory/dev/hosts.yml all -m ping

# Get OS version info
ansible -i inventory/dev/hosts.yml all -m shell -a "uname -a"

# Check disk space on all systems
ansible -i inventory/dev/hosts.yml all -m shell -a "df -h 2>/dev/null || df -g 2>/dev/null || bdf"

# AIX specific commands
ansible -i inventory/dev/hosts.yml aix -m shell -a "oslevel -s"
ansible -i inventory/dev/hosts.yml aix -m shell -a "lparstat -i | grep -E 'Partition Name|Entitled Capacity|Online Memory'"
ansible -i inventory/dev/hosts.yml aix -m shell -a "errpt -d H | head -10"

# Solaris specific commands
ansible -i inventory/dev/hosts.yml solaris -m shell -a "pkg list -u"
ansible -i inventory/dev/hosts.yml solaris -m shell -a "zpool status -x"
ansible -i inventory/dev/hosts.yml solaris -m shell -a "svcs -x"

# HP-UX specific commands
ansible -i inventory/dev/hosts.yml hpux -m shell -a "swlist -l patch | tail -20"
ansible -i inventory/dev/hosts.yml hpux -m shell -a "kctune | grep -E 'maxdsiz|shmmax'"

# Check critical services across all platforms
ansible -i inventory/dev/hosts.yml all -m shell -a \
  "lssrc -a 2>/dev/null | grep -E 'sshd|cron' || svcs -H svc:/network/ssh:default svc:/system/cron:default 2>/dev/null || ps -ef | grep -E 'sshd|cron' | grep -v grep"

# Get memory usage
ansible -i inventory/dev/hosts.yml aix -m shell -a "svmon -G | grep memory"
ansible -i inventory/dev/hosts.yml solaris -m shell -a "echo '::memstat' | mdb -k | grep Total"
ansible -i inventory/dev/hosts.yml hpux -m shell -a "swapinfo -tam"

# Quick backup of critical configs
ansible -i inventory/dev/hosts.yml all -m shell -a \
  "tar -cf /tmp/quick_backup_$(date +%Y%m%d).tar /etc/passwd /etc/group /etc/hosts 2>/dev/null"

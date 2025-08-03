#!/usr/bin/sh
# HP-UX System Health Check Script

echo "=== HP-UX System Health Check ==="
echo "Date: $(date)"
echo "System: $(hostname)"
echo

# System Information
echo "== System Information =="
model
uname -a
echo

# CPU and Memory
echo "== CPU Information =="
ioscan -fnkC processor | grep processor
echo
echo "== Memory Information =="
/usr/contrib/bin/machinfo | grep -i memory
echo

# Disk Space
echo "== Disk Space =="
bdf
echo

# Volume Groups
echo "== Volume Groups =="
vgdisplay -v | grep "VG Name\|VG Status\|Total PE\|Free PE"
echo

# Network Interfaces
echo "== Network Interfaces =="
lanscan
echo

# Critical Services
echo "== Service Status =="
ps -ef | grep -E "sshd|cron|syslogd" | grep -v grep
echo

# System Logs
echo "== Recent System Errors =="
tail -20 /var/adm/syslog/syslog.log | grep -i error
echo

# Kernel Parameters
echo "== Key Kernel Parameters =="
kctune | grep -E "maxdsiz|maxssiz|shmmax|nproc"
echo

# Patch Level
echo "== Latest Patches =="
swlist -l patch | tail -10
echo

echo "=== Health Check Complete ==="

# Solaris Automation Guide

## Overview

Solaris-specific automation procedures and best practices.

## Prerequisites

### Python Installation
```bash
# Solaris 11
pkg install runtime/python-37

# Solaris 10
pkgadd -d http://get.opencsw.org/now
/opt/csw/bin/pkgutil -U
/opt/csw/bin/pkgutil -y -i python37
```

## Zone Management

### Create Zone
```yaml
ansible-playbook playbooks/provisioning/solaris-zone-setup.yml -e "zone_name=testzone"
```

### Zone Operations
- Clone zones
- Move zones
- Configure zone resources

## ZFS Management

### Create ZFS Pool
```bash
zpool create datapool c1t1d0 c1t2d0
```

### Snapshots
```bash
zfs snapshot rpool/export/home@backup
```

## Package Management

### IPS (Solaris 11)
```bash
pkg update
pkg install group/system/solaris-large-server
```

### Legacy (Solaris 10)
```bash
pkgadd -d /cdrom/Solaris_10/Product SUNWssh
```

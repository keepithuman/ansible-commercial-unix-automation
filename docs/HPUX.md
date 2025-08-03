# HP-UX Automation Guide

## Overview

HP-UX specific automation and management procedures.

## Prerequisites

### Python Installation
```bash
# Download from HP Software Depot
swinstall -s /tmp/python-3.7.depot python

# Set PATH
export PATH=/usr/local/bin:$PATH
```

### Required Software
- OpenSSH or HP-UX Secure Shell
- Python 2.7 or 3.x
- sudo (from HP-UX Internet Express)

## Software Management

### Using swinstall
```bash
# Install from depot
swinstall -s server:/depot/11.31 \*

# List installed software
swlist -l product
```

### Patch Management
```yaml
ansible-playbook playbooks/patch-management/hpux-patch-bundle.yml
```

## Ignite-UX

### Create System Recovery
```bash
make_net_recovery -s ignite_server -x inc_entire=vg00
```

## ServiceGuard

### Cluster Operations
- Package management
- Failover testing
- Node maintenance

## Kernel Parameters

### View Parameters
```bash
kctune
```

### Modify Parameters
```bash
kctune parameter=value
```

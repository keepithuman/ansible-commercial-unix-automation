# AIX Automation Guide

## Overview

This guide covers AIX-specific automation using Ansible.

## Prerequisites

### Python Installation
```bash
# Install Python 3 from AIX Toolbox
yum install python3 python3-pip

# Or from IBM repository
/usr/sbin/installp -aXYd https://public.dhe.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/python3/
```

### Required Packages
- OpenSSH
- sudo (optional)
- Python 3.x
- rpm.rte (for yum)

## Common Tasks

### LPAR Management
```yaml
ansible-playbook playbooks/provisioning/aix-lpar-setup.yml
```

### SUMA Patching
```yaml
ansible-playbook playbooks/patch-management/aix-suma-update.yml
```

### NIM Operations
- Configure NIM client
- Install from NIM
- Create mksysb backups

## Troubleshooting

### SSH Issues
```bash
# Check SSH config
lssrc -s sshd
startsrc -s sshd
```

### Python Path
```bash
export PATH=/opt/freeware/bin:$PATH
```

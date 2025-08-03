# Ansible Commercial Unix Automation

Comprehensive Ansible automation for commercial Unix systems (AIX, Solaris, HP-UX) covering provisioning, day-2 operations, patch management, and upgrades.

## Supported Platforms

- **IBM AIX** 7.1, 7.2, 7.3
- **Oracle Solaris** 10, 11
- **HP-UX** 11i v3

## Quick Start

```bash
# Clone repository
git clone https://github.com/keepithuman/ansible-commercial-unix-automation.git
cd ansible-commercial-unix-automation

# Install requirements
ansible-galaxy install -r requirements.yml

# Configure inventory
cp inventory/dev/hosts.yml.example inventory/dev/hosts.yml
# Edit with your servers

# Test connectivity
ansible -i inventory/dev/hosts.yml all -m ping

# Run health check
ansible-playbook -i inventory/dev/hosts.yml playbooks/day2-operations/health-check.yml
```

## Repository Structure

```
├── playbooks/
│   ├── provisioning/      # Initial system setup
│   ├── day2-operations/   # Daily operations
│   ├── patch-management/  # Patching and updates
│   └── upgrades/          # Major upgrades
├── roles/
│   ├── common/           # Cross-platform roles
│   ├── aix/              # AIX-specific roles
│   ├── solaris/          # Solaris-specific roles
│   └── hpux/             # HP-UX-specific roles
├── scripts/              # Native shell scripts
├── templates/            # Configuration templates
└── docs/                 # Platform-specific documentation
```

## Key Features

### Provisioning
- Initial OS configuration
- Network setup
- Storage configuration (LVM, VxVM, ZFS)
- Security baseline

### Day-2 Operations
- Health monitoring
- Log management
- Performance tuning
- Backup automation
- User management

### Patch Management
- AIX: SUMA integration, fix management
- Solaris: IPS updates, patch clusters
- HP-UX: Software depot, patch bundles

### Upgrades
- AIX: Technology Level updates
- Solaris: Version upgrades
- HP-UX: OS updates

## Documentation

- [AIX Automation Guide](docs/AIX.md)
- [Solaris Automation Guide](docs/SOLARIS.md)
- [HP-UX Automation Guide](docs/HPUX.md)
- [Common Tasks](docs/COMMON.md)

## Requirements

- Ansible 2.9+
- Python 2.7 or 3.x on Unix hosts
- SSH access with sudo/root privileges
- Platform-specific requirements in docs

## Contributing

Contributions welcome! Please read our contributing guidelines and submit PRs.

## License

MIT License - See LICENSE file for details

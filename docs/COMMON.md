# Common Tasks Across Unix Platforms

## User Management

### Create User
```yaml
- name: Create user across all Unix systems
  user:
    name: appuser
    group: staff
    shell: "{{ default_shell }}"
    home: /home/appuser
```

## Service Management

### Platform Detection
```yaml
- name: Start service based on OS
  service:
    name: "{{ item }}"
    state: started
  with_items: "{{ common_services }}"
  when: ansible_os_family in ['AIX', 'Solaris', 'HP-UX']
```

## Health Checks

### Universal Health Check
```yaml
ansible-playbook playbooks/day2-operations/health-check.yml
```

Checks:
- Disk space
- Memory usage
- CPU utilization
- Service status
- Log errors

## Backup Strategies

### AIX mksysb
```yaml
- name: Create mksysb backup
  command: mksysb -i /backup/{{ inventory_hostname }}.mksysb
```

### Solaris Flash Archive
```yaml
- name: Create flash archive
  command: flarcreate -n {{ inventory_hostname }} /backup/{{ inventory_hostname }}.flar
```

### HP-UX make_net_recovery
```yaml
- name: Create Ignite backup
  command: make_net_recovery -s {{ ignite_server }}
```

## Security Hardening

### Common Security Tasks
1. SSH configuration
2. Password policies
3. Audit logging
4. Service hardening
5. Kernel parameters

## Performance Tuning

### Memory Tuning
- AIX: vmo command
- Solaris: projects and resource controls
- HP-UX: kctune parameters

### Network Tuning
- Buffer sizes
- TCP parameters
- Interface settings

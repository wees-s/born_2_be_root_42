<img width="2000" height="1000" alt="image" src="https://github.com/user-attachments/assets/a3d63ed3-0e46-4451-a1f6-c1f8c8a125fb" />

# Born to be Root

A 42 School project focused on system administration and server configuration.

## 📋 About

This project introduces the basics of system administration by setting up a virtual machine with specific security and configuration requirements. The goal is to understand how operating systems work at a fundamental level, implement strict security policies, and automate system monitoring.

## 🖥️ Monitoring Script

The `monitoring.sh` script is a bash automation that collects and displays real-time system information. It runs automatically every 10 minutes via cron and broadcasts the data to all terminals using the `wall` command.

### Script Breakdown

#### System Information
- **Architecture** (`uname -a`): Displays complete system information including kernel version and architecture
- **Physical CPUs** (`lscpu`): Counts the number of physical processors
- **Virtual CPUs** (`nproc`): Shows the number of virtual processors available

#### Resource Usage
- **Memory Usage** (`free --mega`): 
  - Calculates used vs total RAM
  - Displays usage percentage
  - Values shown in MB

- **Disk Usage** (`df -m`):
  - Aggregates all partitions (excluding `/boot`)
  - Calculates total and used disk space
  - Shows usage percentage in GB

- **CPU Load** (`mpstat`):
  - Monitors processor load in real-time
  - Calculates active CPU usage (100% - idle%)

#### System Status
- **Last Boot** (`who -b`): Timestamp of the last system restart
- **LVM Status** (`lvdisplay`): Checks if Logical Volume Manager is active or disabled
- **TCP Connections** (`ss -t`): Counts active ESTABLISHED connections
- **Logged Users** (`users`): Number of currently active users

#### Network Information
- **IP Address** (`hostname -I`): System's network IP
- **MAC Address** (`ip link`): Physical network adapter address

#### Security Monitoring
- **Sudo Commands** (`journalctl`): Total count of executed sudo commands logged in the system journal

### Output Example

```
-> Architecture:        Linux debian 5.10.0-23-amd64 #1 SMP Debian x86_64 GNU/Linux
-> CPU(s):              2
-> vCPU(s):             2
-> Memory Usage:        157/987MB (15.92%)
-> Disk Usage:          1532/8.0Gb (19.11%)
-> CPU load:            6.7%
-> Last boot:           2024-01-15 09:45
-> LVM status:          active
-> Connections TCP:     3 ESTABLISHED
-> Users Logged:        1
-> Network:             IP: 10.0.2.15 MAC: (08:00:27:51:4b:4d)
-> Sudo CMD:            42
```

## 🚀 Usage

The script runs automatically via cron. To execute manually:

```bash
bash monitoring.sh
```

To set up the cron job (runs every 10 minutes):
```bash
sudo crontab -e
# Add: */10 * * * * /path/to/monitoring.sh
```

## 🎯 Project Skills

- Virtual machine setup and configuration
- Partition management with LVM
- SSH configuration and security hardening
- UFW firewall implementation
- Sudo policies and user management
- Bash scripting and system monitoring
- Cron job automation

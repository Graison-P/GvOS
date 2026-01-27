# GvOS Installer Quick Start Guide

This guide will help you get started with the GvOS installer.

## Prerequisites

Before running the installer:

1. Boot into a Linux environment with root access
2. Ensure you have at least 10GB of free disk space
3. (Optional) Have a network connection for downloading packages

## Quick Installation

### Step 1: Run the Installer

```bash
sudo /usr/bin/gvos-installer
```

### Step 2: Follow the Prompts

The installer will guide you through:

1. **Welcome**: Introduction to the installer
2. **Network**: Select and connect to Wi-Fi (or skip)
3. **Disk**: Choose installation disk
4. **User**: Set hostname, username, and passwords
5. **Packages**: Select software to install
6. **Custom**: Run additional commands (optional)
7. **Install**: Confirm and begin installation

### Step 3: Reboot

Once installation completes:

1. Remove installation media
2. Reboot your system
3. Log in with your credentials

## Example Installation

Here's a typical installation workflow:

### Network Configuration
```
Available Wi-Fi networks:
  1) HomeNetwork
  2) OfficeWiFi
  3) Skip network configuration

Select a network (1-3): 1
Enter password for 'HomeNetwork': ********
✓ Connected successfully
```

### Disk Selection
```
Available disks:
  /dev/sda - 500GB
  /dev/sdb - 1TB

Enter the disk to install GvOS on: sda
WARNING: All data on /dev/sda will be DESTROYED!
Are you sure you want to continue? [y/N]: y
```

### User Configuration
```
Enter hostname for this system [gvos]: myserver
Enter username for the primary user [gvos]: john
Enter password for john: ********
Confirm password: ********
Set a separate root password? [y/N]: n
Enter timezone [UTC]: America/New_York
```

### Package Selection
```
Install development tools? [y/N]: y
Install desktop environment? [y/N]: n
Install server packages? [y/N]: y
Install multimedia applications? [y/N]: n
```

### Custom Commands
```
Do you want to run custom commands? [y/N]: y

Enter your commands (one per line). Type 'done' when finished.

Command> apt-get install htop
[QUEUED] apt-get install htop
Command> systemctl enable ssh
[QUEUED] systemctl enable ssh
Command> done

Executing custom commands...
→ apt-get install htop
→ systemctl enable ssh
✓ Custom commands executed
```

## Customization

### Pre-configure Settings

Edit `/etc/gvos-installer.conf` to set defaults:

```bash
INSTALLER_HOSTNAME="myserver"
INSTALLER_USERNAME="admin"
INSTALLER_TIMEZONE="America/New_York"
INSTALLER_DEFAULT_PACKAGES="base,network,server"
```

### Add Custom Package Groups

Edit `/usr/bin/gvos-installer` and modify the `PACKAGE_GROUPS` array:

```bash
declare -A PACKAGE_GROUPS=(
    ["base"]="systemd udev bash coreutils util-linux"
    ["mygroup"]="package1 package2 package3"
)
```

### Add Preset Post-Installation Commands

The installer can automatically run commands after Debian is installed. Edit the `POST_INSTALL_COMMANDS` array in `/usr/bin/gvos-installer`:

```bash
declare -a POST_INSTALL_COMMANDS=(
    # Install additional packages
    "apt-get install -y docker.io"
    "apt-get install -y nodejs npm"
    
    # Enable services
    "systemctl enable ssh"
    "systemctl enable docker"
    
    # Configure system
    "echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf"
)
```

These commands run automatically in the chroot environment after package installation. Comments and empty lines are skipped.

## Troubleshooting

### Cannot Connect to Wi-Fi

- Double-check your password
- Ensure wireless adapter is enabled
- Try skipping network setup and configure manually later

### Installer Won't Start

- Verify you're running as root: `sudo -i`
- Check script is executable: `chmod +x /usr/bin/gvos-installer`
- Check for missing dependencies

### Installation Fails

- Check log file: `cat /var/log/gvos-installer.log`
- Verify sufficient disk space: `df -h`
- Ensure network connectivity: `ping -c 3 google.com`

## Advanced Usage

### Automated Installation

Create a wrapper script:

```bash
#!/bin/bash
# auto-install.sh

# Set environment variables
export INSTALLER_HOSTNAME="autoserver"
export INSTALLER_USERNAME="auto"

# Run installer
/usr/bin/gvos-installer
```

### Batch Custom Commands

Create a file with commands:

```bash
# custom-commands.txt
apt-get update
apt-get install -y nginx
systemctl enable nginx
ufw allow 80/tcp
```

Then reference it during installation in the custom commands section.

## Getting Help

- Full documentation: `/usr/bin/INSTALLER-README.md`
- Configuration: `/etc/gvos-installer.conf`
- Log file: `/var/log/gvos-installer.log`
- GitHub Issues: https://github.com/Graison-P/GvOS/issues

## What's Next?

After installation:

1. **Update the system**: `sudo apt-get update && sudo apt-get upgrade`
2. **Configure services**: Enable/disable services with `systemctl`
3. **Install additional software**: Use `apt-get install <package>`
4. **Customize desktop**: If you installed a desktop environment
5. **Set up users**: Add additional users with `adduser`

## Tips

- The installer creates detailed logs at `/var/log/gvos-installer.log`
- You can press Ctrl+C to cancel at most prompts
- Custom commands run in the installation root context
- Review the summary screen carefully before proceeding
- Most destructive actions require explicit confirmation

Enjoy your GvOS installation! 🎉

# GvOS Fullscreen Installer

The GvOS Installer is a fullscreen, kernel-based installation program designed to mimic the functionality and aesthetics of the Ubuntu Server installer. It provides a user-friendly, text-based interface for installing and configuring GvOS based on the latest Debian release.

## Features

### 1. Fullscreen TTY Interface
- Runs entirely in a kernel TTY environment
- No reliance on graphical utilities
- Clean, intuitive text-based UI with color support
- Progress indicators and menu-driven navigation

### 2. Debian Base System Installation
- **Automatically detects the latest Debian stable release**
- Uses `debootstrap` to install a minimal Debian base system
- Configures APT repositories for the detected Debian version
- Downloads and installs packages directly from Debian mirrors
- Supports both UEFI and BIOS boot modes

### 3. Network Configuration
- Automatic scanning for available Wi-Fi networks
- Easy network selection from a list (no manual SSID entry required)
- Uses NetworkManager (`nmcli`) for reliable network management
- Configures network for package installations and updates
- Option to skip network configuration for offline installations

### 4. Disk Partitioning
- Interactive disk selection
- **Automatic partitioning with GPT (UEFI) or MBR (BIOS)**
- Creates EFI partition (512MB) for UEFI systems
- Creates root partition using remaining disk space
- Formats partitions with appropriate filesystems (FAT32 for EFI, ext4 for root)
- Safe partitioning with confirmation prompts
- Support for various disk types (HDD, SSD, NVMe)

### 5. Base System Installation
- Downloads and installs the latest Debian stable release
- Progress tracking during installation
- Configures package repositories automatically
- Mounts necessary filesystems for chroot operations
- Modular package group system
- Efficient package management using APT

### 6. User Configuration
- Custom hostname setup
- User account creation with sudo privileges
- Secure password entry (hidden input)
- Optional separate root password
- Timezone configuration
- Locale generation (en_US.UTF-8)

### 7. Package Selection
- **Base System**: Essential packages (required)
- **Development Tools**: Compilers, build tools, version control
- **Desktop Environment**: LXDE desktop with X.org
- **Server Packages**: SSH, web servers, databases
- **Multimedia Applications**: Media players, editors

### 8. Bootloader Installation
- **Automatic GRUB installation** to the selected disk
- Detects UEFI vs BIOS mode and installs appropriate bootloader
- Generates GRUB configuration automatically
- Creates `/etc/fstab` with correct UUIDs

### 9. Custom Commands Section
- Interactive terminal-like environment
- **Execute custom commands in the chroot environment**
- Useful for:
  - Installing additional packages
  - Enabling/disabling services
  - Custom system configurations
  - Running scripts
- Commands are executed in the actual installation (not simulated)

### 10. Installation Summary
- Review all settings before installation
- Shows installation mode (Actual or Simulation)
- Displays detected Debian release
- Comprehensive overview of selections
- Ability to go back and change settings
- Final confirmation before proceeding

## Installation Modes

### Actual Installation Mode
When all required tools (`debootstrap`, `fdisk`, `mkfs.ext4`, `mount`, `chroot`) are available, the installer runs in **Actual Installation Mode**:
- Downloads and installs the latest Debian stable release
- Actually partitions and formats the selected disk
- Installs GRUB bootloader
- Configures the system for first boot
- **WARNING: This will DESTROY all data on the selected disk!**

### Simulation Mode
If required tools are missing, the installer runs in **Simulation Mode**:
- Demonstrates the installation flow
- Does not make any changes to disks
- Safe for testing and learning
- Shows what would happen during actual installation

## Usage

### Prerequisites

For **Actual Installation**, you need:
```bash
apt-get install debootstrap fdisk e2fsprogs parted
```

For **Network Configuration** (optional):
```bash
apt-get install network-manager
```

### Running the Installer

The installer must be run with root privileges:

```bash
sudo /usr/bin/gvos-installer
```

Or if you're already root:

```bash
/usr/bin/gvos-installer
```

### Installation Flow

1. **Welcome Screen**: Introduction and overview
2. **Prerequisites Check**: Verify system requirements
3. **Network Configuration**: Select and connect to Wi-Fi
4. **Disk Partitioning**: Choose installation disk
5. **Base Installation**: Install core system
6. **User Configuration**: Set up hostname, user, passwords
7. **Package Selection**: Choose software to install
8. **Custom Commands**: Run additional setup commands
9. **Installation Summary**: Review and confirm
10. **Installation**: Perform the installation
11. **Completion**: Success message and next steps

### Network Configuration

The installer supports Wi-Fi network configuration through NetworkManager:

1. The installer scans for available networks
2. Networks are displayed in a numbered list
3. Select your network by number
4. Enter the password when prompted
5. The installer attempts to connect automatically

If NetworkManager is not available or you want to skip network setup, you can proceed without network configuration.

### Custom Commands Examples

In the Custom Commands section, you can run any command that you would normally run with `sudo`. Here are some examples:

```bash
# Install additional packages
apt-get install htop tmux neofetch

# Enable a service
systemctl enable ssh

# Install Python packages
apt-get install python3-pip python3-venv

# Configure firewall
ufw enable
ufw allow ssh

# Install Docker
apt-get install docker.io docker-compose
```

### Package Groups

The installer includes predefined package groups:

- **base**: `systemd`, `udev`, `bash`, `coreutils`, `util-linux`
- **network**: `network-manager`, `iproute2`, `iputils-ping`, `wireless-tools`, `wpasupplicant`
- **development**: `build-essential`, `git`, `vim`, `gcc`, `make`
- **desktop**: `xorg`, `lightdm`, `lxde`, `firefox-esr`
- **server**: `openssh-server`, `apache2`, `nginx`, `mysql-server`
- **multimedia**: `vlc`, `gimp`, `inkscape`, `audacity`

## Customization

The installer script is designed to be easily customizable. All configuration is centralized at the top of the script:

### Editing Package Groups

To modify package groups, edit the `PACKAGE_GROUPS` associative array:

```bash
declare -A PACKAGE_GROUPS=(
    ["base"]="systemd udev bash coreutils util-linux"
    ["custom"]="your-package-1 your-package-2"
)
```

### Changing Default Values

Modify the default configuration variables:

```bash
DEFAULT_HOSTNAME="gvos"
DEFAULT_USERNAME="gvos"
DEFAULT_TIMEZONE="UTC"

# Debian release settings
DEBIAN_RELEASE="stable"  # stable, testing, unstable, or codename (e.g., bookworm)
DEBIAN_MIRROR="http://deb.debian.org/debian"
DEBIAN_SECURITY_MIRROR="http://security.debian.org/debian-security"
```

### Customizing Debian Release

By default, the installer uses the latest Debian stable release. You can customize this by editing the `DEBIAN_RELEASE` variable:

- `stable` - Latest stable release (recommended)
- `testing` - Testing release
- `unstable` or `sid` - Unstable release
- Specific codename - e.g., `bookworm`, `bullseye`, `trixie`

The installer automatically detects the codename for the stable release by checking debootstrap scripts.

### Adding New Installation Steps

To add a new step:

1. Create a function named `step_your_step_name()`
2. Add it to the main installation flow in the `main()` function
3. Use the provided utility functions for UI consistency

### Customizing Colors

Edit the color definitions at the top of the script:

```bash
readonly COLOR_RESET='\033[0m'
readonly COLOR_BOLD='\033[1m'
readonly COLOR_RED='\033[0;31m'
# Add more colors as needed
```

## Logging

The installer creates a detailed log file at:

```
/var/log/gvos-installer.log
```

This log includes:
- Timestamps for all actions
- User selections
- Command execution details
- Errors and warnings

## Requirements

### System Requirements

- Root or sudo access
- Terminal with ANSI color support
- Minimum 2GB RAM (recommended 4GB+)
- 10GB free disk space (minimum)

### Software Dependencies

The installer checks for and uses these commands:

- `nmcli` - Network management (optional)
- `fdisk` - Disk partitioning
- `mkfs.ext4` - Filesystem creation
- `mount` - Mounting filesystems
- `apt-get` - Package management
- `chroot` - Change root for installation

If any required commands are missing, the installer will warn you and allow you to continue at your own risk.

## Safety Features

The installer includes several safety mechanisms:

1. **Confirmation Prompts**: All destructive actions require explicit confirmation
2. **Disk Warning**: Clear warning before partitioning disks
3. **Password Verification**: Passwords must be entered twice
4. **Summary Review**: Final review before installation begins
5. **Simulation Mode**: Critical sections include simulation mode for testing
6. **Logging**: All actions are logged for troubleshooting
7. **Error Handling**: Graceful error handling and cleanup

## Troubleshooting

### Network Connection Issues

If you cannot connect to Wi-Fi:
- Verify the password is correct
- Check that your wireless adapter is enabled
- Try skipping network setup and configure later
- Check `/var/log/gvos-installer.log` for details

### Missing Commands

If required commands are not found:
- Install NetworkManager: `apt-get install network-manager`
- Install partitioning tools: `apt-get install fdisk parted`
- Install filesystem tools: `apt-get install e2fsprogs`

### Installation Fails

If installation fails:
1. Check the log file: `/var/log/gvos-installer.log`
2. Verify disk has enough space
3. Ensure you have a working internet connection (if required)
4. Try running the installer again

## Development and Testing

### Testing in Simulation Mode

Many critical sections of the installer run in simulation mode by default to prevent accidental data loss during development. Look for messages like:

```
[SIMULATION MODE] Partitioning would happen here
```

### Running Unit Tests

The installer is designed to be testable. Each step function can be tested independently:

```bash
# Source the installer script
source /usr/bin/gvos-installer

# Test individual functions
step_welcome
```

### Contributing

To contribute improvements:

1. Fork the repository
2. Make your changes to `/usr/bin/gvos-installer`
3. Test thoroughly (especially in simulation mode)
4. Submit a pull request with a clear description

## Advanced Usage

### Automated Installation

For automated installations, you can pre-configure settings by modifying the global variables before calling `main()`:

```bash
#!/bin/bash
source /usr/bin/gvos-installer

# Override defaults
HOSTNAME="myserver"
USERNAME="admin"
TIMEZONE="America/New_York"
INSTALL_PACKAGES=("base" "network" "server")

# Run automated installation
# Note: This still requires manual input for passwords and confirmations
```

### Scripted Installation

For fully unattended installation, you would need to modify the installer to accept command-line arguments or a configuration file.

## Security Considerations

- Passwords are read with `-s` flag (not displayed on screen)
- Passwords are stored in memory only and not logged
- Network passwords are cleared after use
- The installer requires explicit root access (no SUID)
- All disk operations require explicit user confirmation

## License

See the main GvOS LICENSE file for licensing information.

## Support

For issues, questions, or contributions:
- GitHub Issues: https://github.com/Graison-P/GvOS/issues
- Documentation: See README.md files in the repository

## Credits

Developed by the GvOS Development Team.
Inspired by the Ubuntu Server installer and Debian installer.

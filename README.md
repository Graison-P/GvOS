# GvOS

GvOS is a custom operating system based on Debian, designed for flexibility and customization.

## Overview

This repository contains the foundational structure for GvOS, including a Debian-compatible filesystem hierarchy, configuration files, and customizable boot and sound components.

## Directory Structure

GvOS follows the Filesystem Hierarchy Standard (FHS) commonly used in Linux/Unix systems:

### Core Directories

- **`/bin`** - Essential command binaries (for all users)
- **`/boot`** - Boot loader files (kernel, initrd, GRUB configuration)
- **`/dev`** - Device files
- **`/etc`** - System configuration files
- **`/home`** - User home directories
- **`/lib`** - Essential shared libraries and kernel modules
- **`/opt`** - Optional/add-on application software packages
- **`/proc`** - Virtual filesystem providing process and kernel information
- **`/run`** - Run-time variable data
- **`/srv`** - Data for services provided by the system
- **`/sys`** - Virtual filesystem for system information
- **`/tmp`** - Temporary files
- **`/usr`** - User binaries and read-only data
  - **`/usr/bin`** - Non-essential command binaries
  - **`/usr/lib`** - Libraries for binaries in /usr/bin
  - **`/usr/share`** - Architecture-independent data
  - **`/usr/share/sounds`** - System sound files
- **`/var`** - Variable data (logs, caches, temporary files)
  - **`/var/log`** - Log files
  - **`/var/tmp`** - Temporary files preserved between reboots
  - **`/var/cache`** - Application cache data

## Key Features

### 1. Configuration Files

Essential system configuration files are located in `/etc`:

- **`/etc/fstab`** - Filesystem mount table
- **`/etc/hostname`** - System hostname
- **`/etc/hosts`** - Static hostname-to-IP mappings
- **`/etc/os-release`** - Operating system identification
- **`/etc/network/interfaces`** - Network interface configuration
- **`/etc/default/grub`** - GRUB bootloader settings

See `/etc/README.md` for detailed information about configuration files.

### 2. Custom Boot Process

The boot process is managed through GRUB (Grand Unified Bootloader):

- **`/boot/grub/grub.cfg`** - GRUB menu configuration
- **`/etc/default/grub`** - GRUB settings (timeout, default entry, kernel parameters)
- **`/boot/vmlinuz-placeholder`** - Kernel placeholder
- **`/boot/initrd.img-placeholder`** - Initial RAM disk placeholder

See `/boot/README.md` for detailed information about the boot process.

### 3. Custom Sounds

System event sounds are located in `/usr/share/sounds`:

- **`boot.ogg`** - Startup sound
- **`shutdown.ogg`** - Shutdown sound
- **`error.ogg`** - Error notification sound
- **`notification.ogg`** - General notification sound

See `/usr/share/sounds/README.md` for information on customizing sounds.

## Customization Guide

### Configuring the System

1. **Set Hostname**: Edit `/etc/hostname` to set your system name
2. **Configure Network**: Modify `/etc/network/interfaces` for network settings
3. **Filesystem Mounts**: Update `/etc/fstab` with your filesystem mount points

### Customizing Boot

1. Edit `/etc/default/grub` to change boot parameters:
   - `GRUB_TIMEOUT` - Boot menu timeout in seconds
   - `GRUB_DEFAULT` - Default boot entry
   - `GRUB_CMDLINE_LINUX_DEFAULT` - Kernel boot parameters
2. Update `/boot/grub/grub.cfg` for advanced menu customization

### Adding Custom Sounds

1. Create or obtain OGG Vorbis audio files
2. Replace placeholder files in `/usr/share/sounds/` with your audio files
3. Ensure files use the `.ogg` extension and recommended format:
   - Format: OGG Vorbis
   - Sample Rate: 44100 Hz
   - Channels: Stereo
   - Duration: 1-5 seconds

## Installation

GvOS includes a comprehensive fullscreen installer that provides an Ubuntu Server-like installation experience and automatically installs the latest Debian release.

### GvOS Installer

The GvOS Installer is a kernel-based, text-mode installation program featuring:

- **Fullscreen TTY Interface**: Clean, intuitive text-based UI
- **Debian Installation**: Automatically downloads and installs the latest Debian stable release using debootstrap
- **Network Configuration**: Automatic Wi-Fi network scanning and selection
- **Disk Partitioning**: Automatic partitioning with UEFI/BIOS support
- **User Configuration**: Creates user accounts with custom home directories (Music, Videos, Code, Other, Documents)
- **Package Selection**: Choose from predefined package groups or customize
- **Custom Commands**: Run commands in chroot during installation for advanced customization
- **Bootloader Installation**: Automatic GRUB installation and configuration

#### Prerequisites

For actual installation (required):
```bash
apt-get install debootstrap fdisk e2fsprogs parted
```

For network configuration (optional):
```bash
apt-get install network-manager
```

#### Running the Installer

```bash
sudo /usr/bin/gvos-installer
```

The installer will detect available tools and run in either:
- **Actual Installation Mode**: When all required tools are available (performs real installation)
- **Simulation Mode**: When tools are missing (demonstrates the installation flow)

For detailed documentation, see [/usr/bin/INSTALLER-README.md](/usr/bin/INSTALLER-README.md).

## Development Status

This is the foundational structure for GvOS. Current status:

✅ Filesystem hierarchy created  
✅ Configuration file placeholders added  
✅ Boot directory structure established  
✅ Custom sound placeholders included  
✅ Documentation provided  
✅ Fullscreen installer implemented  
✅ XFCE desktop environment with Windows 11-inspired UI  
✅ Custom GRUB and Plymouth boot themes  
✅ Sound theme integration  
✅ Automated ISO building with GitHub Actions  

## XFCE Desktop Environment

GvOS now includes a fully customized XFCE desktop environment with:

### Features
- **Windows 11-inspired UI** - Rounded taskbar with dark theme
- **Custom Branding** - GvOS icon throughout (Start button, boot screen)
- **Dark Mode** - Adwaita-dark GTK theme and Papirus-Dark icons
- **Boot Themes** - Custom GRUB and Plymouth themes with GvOS branding
- **Sound Theme** - Mapped system sounds for desktop events
- **Automated Building** - GitHub Actions workflow for ISO generation

### Building the ISO

See the [XFCE Customization Summary](XFCE-CUSTOMIZATION-SUMMARY.md) for complete documentation.

**Quick build:**
```bash
mkdir build && cd build
lb config
cp -r ../config/* config/
chmod +x config/hooks/live/*.hook.chroot
sudo lb build
```

**Or use GitHub Actions** - Push to main/develop branch and the ISO will be built automatically.

### Configuration

All customization files are in the `config/` directory:
- `config/includes.chroot/` - Files copied to the live system
- `config/hooks/live/` - Customization scripts
- `config/package-lists/` - Package definitions

See [config/README.md](config/README.md) for detailed documentation.

### Next Steps

- Add actual kernel and initrd images
- Implement custom init system or systemd configuration
- Complete package management integration
- Develop custom system services

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

Please refer to the LICENSE file for licensing information.

## Support

For issues and questions, please use the [GitHub Issues](https://github.com/Graison-P/GvOS/issues) page.
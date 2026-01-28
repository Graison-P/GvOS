# GvOS

GvOS is a OS based off of Debian, designed for flexibility and customization.

## Overview

This repository contains the foundational structure for GvOS, including a Debian-compatible filesystem hierarchy (which is completly useless as debian already installs it soo.....), configuration files, and customizable boot and sound components.

## Directory Structure

GvOS follows the Filesystem Hierarchy Standard (FHS) commonly used in Linux/Unix systems:

### Core File includes
Sounds

Wallpapers

Pixmaps
## Key Features

### 1. Configuration Files

Essential system configuration files are located in `config`.

They are simple, so they will not be listed here.


### 2. Custom Boot Process

The boot process is managed through GRUB (Grand Unified Bootloader). GRUB is configured by defualt on Debian's installation.

### 3. Custom Sounds

System event sounds are located in `/config/includes.chroot/usr/share/sounds`.


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
(This is depricated due to it not likely working.)

A GUI installer in ISO build is included.
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


## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License
The license supplied with this software is BSD-3, which is what Debian reccommend for modifications.

Please refer to the LICENSE file for licensing information.

## Support

For issues and questions, please use the [GitHub Issues](https://github.com/Graison-P/GvOS/issues) page.

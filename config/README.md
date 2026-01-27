# GvOS Build Configuration

This directory contains the configuration files for building the GvOS ISO using Debian live-build.

## Directory Structure

```
config/
├── includes.chroot/          # Files to be included in the live system
│   ├── boot/                 # Boot-related files
│   │   └── grub/             # GRUB bootloader theme
│   ├── etc/                  # System configuration files
│   │   └── xdg/              # XDG configuration
│   │       └── xfce4/        # XFCE desktop environment settings
│   └── usr/                  # User-space files
│       └── share/            # Shared data files
│           ├── pixmaps/      # Application icons
│           ├── plymouth/     # Plymouth boot splash theme
│           └── sounds/       # Sound theme files
├── hooks/                    # Customization hooks
│   └── live/                 # Live system hooks (run during build)
└── package-lists/            # Package lists for installation
```

## Components

### 1. XFCE Desktop Customization

**Location:** `config/includes.chroot/etc/xdg/xfce4/`

The XFCE configuration provides a Windows 11-inspired user interface with:
- **Rounded taskbar** with dark theme
- **Custom Start button** using the GvOS icon
- **Dark mode** enabled by default (Adwaita-dark theme)
- **Modern panel layout** with system tray, clock, and application menu

**Key files:**
- `xfce-perchannel-xml/xfce4-panel.xml` - Panel configuration
- `xfce-perchannel-xml/xfwm4.xml` - Window manager settings
- `xfce-perchannel-xml/xsettings.xml` - UI theme and appearance settings

### 2. Sound Theme

**Location:** `config/includes.chroot/usr/share/sounds/gvos/`

The GvOS sound theme maps system sound files (located in `/usr/share/sounds/`) to various desktop events using symbolic links:
- Login/logout sounds
- Error and warning notifications
- System shutdown sounds
- Battery events

**Key files:**
- `index.theme` - Sound theme metadata
- `stereo/` - Symbolic links to sound files for various events

### 3. GRUB Boot Theme

**Location:** `config/includes.chroot/boot/grub/themes/gvos/`

Custom GRUB theme with Windows 11-inspired dark aesthetic:
- **GvOS logo** centered on boot screen
- **Dark background** with subtle gradient effects
- **Modern progress bar** for boot timeout
- **Clean, minimalist** menu design

**Key files:**
- `theme.txt` - GRUB theme configuration
- `gvosicon.png` - GvOS logo
- `background.png` - Boot screen background
- `select_*.png` - Menu selection highlights

### 4. Plymouth Boot Splash

**Location:** `config/includes.chroot/usr/share/plymouth/themes/gvos/`

Plymouth boot splash theme with animated GvOS logo:
- **Centered logo** with smooth animations
- **Progress bar** showing boot progress
- **Dark background** matching the overall theme

**Key files:**
- `gvos.plymouth` - Plymouth theme metadata
- `gvos.script` - Boot animation script
- `gvosicon.png` - GvOS logo
- `progress_*.png` - Progress bar graphics

### 5. Branding Assets

**GvOS Icon:** The main branding icon (`gvosicon.png`) is placed in multiple locations:
- `/usr/share/pixmaps/` - For general application use
- `/usr/share/icons/hicolor/256x256/apps/` - For icon theme integration
- `/boot/grub/themes/gvos/` - For GRUB theme
- `/usr/share/plymouth/themes/gvos/` - For Plymouth theme

## Build Hooks

**Location:** `config/hooks/live/`

Hooks are executed during the build process to apply system customizations:

1. **0100-configure-xfce.hook.chroot** - Configures XFCE and LightDM
   - Sets XFCE as default desktop session
   - Configures LightDM greeter with dark theme
   
2. **0200-configure-sound.hook.chroot** - Configures sound system
   - Enables PulseAudio
   - Sets GvOS sound theme as default
   
3. **0300-configure-boot.hook.chroot** - Configures boot themes
   - Applies GRUB theme
   - Sets Plymouth splash screen

## Package Lists

**Location:** `config/package-lists/`

- **desktop.list.chroot** - Desktop environment and essential packages
  - XFCE and related components
  - Display server and graphics drivers
  - GTK themes (Adwaita-dark, Papirus icons)
  - Sound system (PulseAudio)
  - Boot splash (Plymouth)
  - Network Manager
  - Basic applications (Firefox ESR)

## Building the ISO

The ISO is built using GitHub Actions (see `.github/workflows/build-iso.yml`), which:

1. Sets up an Ubuntu build environment
2. Installs live-build and dependencies
3. Configures the build with Debian Bookworm base
4. Copies customization files from this directory
5. Executes the build process
6. Generates a bootable ISO file

### Manual Build

To build manually:

```bash
# Install dependencies
sudo apt-get install live-build debootstrap squashfs-tools xorriso \
  isolinux syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools

# Create build directory
mkdir build && cd build

# Initialize configuration
lb config \
  --architectures amd64 \
  --distribution bookworm \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer live \
  --bootappend-live "boot=live components quiet splash" \
  --iso-application "GvOS" \
  --binary-images iso-hybrid

# Copy customization files
cp -r ../config/* config/

# Make hooks executable
chmod +x config/hooks/live/*.hook.chroot

# Build the ISO
sudo lb build
```

## Customization Guide

### Modifying the XFCE Theme

Edit the XML files in `config/includes.chroot/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/`:
- Change colors in `xfce4-panel.xml`
- Adjust window manager behavior in `xfwm4.xml`
- Modify theme settings in `xsettings.xml`

### Changing the Icon

Replace `gvosicon.png` files in:
- `config/includes.chroot/usr/share/pixmaps/`
- `config/includes.chroot/usr/share/icons/hicolor/256x256/apps/`
- `config/includes.chroot/boot/grub/themes/gvos/`
- `config/includes.chroot/usr/share/plymouth/themes/gvos/`

### Adding Sound Files

1. Copy your sound files (.wav or .ogg) to the repository's `/usr/share/sounds/` directory
2. Create symbolic links in `config/includes.chroot/usr/share/sounds/gvos/stereo/` that point to your sound files using relative paths (e.g., `../../../sounds/yourfile.wav`)
3. Follow the XDG Sound Theme naming convention (e.g., `dialog-error.wav`, `desktop-login.wav`, etc.)

### Adding Packages

Edit `config/package-lists/desktop.list.chroot` and add package names (one per line).

### Modifying Boot Theme

- Edit GRUB theme: `config/includes.chroot/boot/grub/themes/gvos/theme.txt`
- Edit Plymouth script: `config/includes.chroot/usr/share/plymouth/themes/gvos/gvos.script`
- Replace background images as needed

## Testing

After building, test the ISO:
1. Use a virtual machine (VirtualBox, QEMU, VMware)
2. Boot from the ISO
3. Verify:
   - Boot splash appears with GvOS branding
   - GRUB menu shows GvOS theme
   - Desktop environment loads with XFCE
   - Panel has the GvOS icon as Start button
   - Dark theme is applied
   - Sound events work properly

## License

See the main repository LICENSE file for licensing information.

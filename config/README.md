# GvOS Customization Configuration

This directory contains the folder structure and configuration needed for customizing GvOS with user-provided assets (images and sounds) during the ISO build process.

## Directory Structure

### 1. `includes.chroot/`
Files and directories placed here will be included in the live system's root filesystem.

#### `includes.chroot/etc/skel/`
- **Purpose**: Assets and configuration meant for the default user home directory
- **Usage**: Files placed here will be copied to every new user's home directory created on the OS
- **Examples**: 
  - Default user configuration files
  - Desktop shortcuts
  - User-specific settings

#### `includes.chroot/usr/share/backgrounds/`
- **Purpose**: Default wallpapers and background images
- **Usage**: Place your custom wallpapers here
- **File naming**: Use descriptive names (e.g., `gvos-background1.jpg`, `gvos-background2.jpg`)
- **Supported formats**: JPG, PNG (files can have any appropriate extension)
- **Current files**:
  - `gvos-background1.jpg` - Primary default wallpaper (wide format)
  - `gvos-background2.jpg` - Secondary wallpaper (4:3 format)

#### `includes.chroot/usr/share/sounds/`
- **Purpose**: Custom notification sounds, boot sounds, and system event sounds
- **Usage**: Store `.ogg` or `.wav` files here for system sound customization
- **Supported formats**: OGG Vorbis (`.ogg`), WAV (`.wav`)
- **Recommended specifications**:
  - Format: OGG Vorbis
  - Sample Rate: 44100 Hz
  - Channels: Stereo
  - Duration: 1-3 seconds for notifications, up to 10 seconds for boot sounds

#### `includes.chroot/usr/share/themes/`
- **Purpose**: Custom XFCE themes for taskbar, start button, and window styling
- **Usage**: Add your custom XFCE theme directories here
- **Structure**: Each theme should be a directory containing the theme files
- **Examples**: 
  - `MyCustomTheme/xfwm4/` - Window manager theme
  - `MyCustomTheme/gtk-3.0/` - GTK3 theme
  - `MyCustomTheme/xfce4-panel/` - Panel theme

#### `includes.chroot/usr/share/pixmaps/`
- **Purpose**: System icons and images
- **Usage**: Place custom icons for start button, boot screen, and applications
- **Current files**:
  - `gvosicon.png` - GvOS icon for start button and boot screen animation
- **Supported formats**: PNG, SVG, XPM

### 2. `hooks/live/`
- **Purpose**: Custom hook scripts that run inside the OS during the build process
- **Usage**: Place executable shell scripts here to apply customizations
- **Naming convention**: `##-description.hook.chroot` (e.g., `01-customize-gui.hook.chroot`)
- **Execution order**: Scripts are executed in numerical/alphabetical order
- **Current scripts**:
  - `01-customize-gui.hook.chroot` - Applies XFCE customizations (wallpaper, theme settings)

## How to Customize

### Adding Custom Wallpapers
1. Place your wallpaper files in `includes.chroot/usr/share/backgrounds/`
2. Name them descriptively (e.g., `my-wallpaper.jpg`)
3. Update the hook script to reference your wallpaper if setting as default

### Adding Custom Sounds
1. Create or obtain OGG/WAV audio files
2. Place them in `includes.chroot/usr/share/sounds/`
3. Reference them in your configuration or hook scripts

### Adding Custom Themes
1. Create or download an XFCE theme
2. Place the theme directory in `includes.chroot/usr/share/themes/`
3. Update the hook script to set the theme as default

### Adding Custom Icons
1. Place your icon files in `includes.chroot/usr/share/pixmaps/`
2. Reference them in your configuration files or hook scripts

### Creating Custom Hook Scripts
1. Create a new `.hook.chroot` file in `hooks/live/`
2. Make it executable: `chmod +x hooks/live/##-yourscript.hook.chroot`
3. Add your customization commands using shell script syntax
4. Scripts run in the chroot environment during build

## Sample Hook Script

The included `01-customize-gui.hook.chroot` demonstrates:
- Setting a default wallpaper for XFCE
- Configuring XFCE theme and icon theme
- Creating default configuration files in `/etc/skel/`

## Build Process Integration

During the GvOS ISO build process:
1. Files in `includes.chroot/` are copied to the live system's root filesystem
2. Hook scripts in `hooks/live/` are executed in order
3. Customizations are applied before the ISO is finalized
4. New users created on the installed system will inherit settings from `/etc/skel/`

## Notes

- All paths in hook scripts are relative to the chroot environment
- Ensure hook scripts are executable (`chmod +x`)
- Test your customizations before building the final ISO
- Keep file sizes reasonable to avoid bloating the ISO image
- Use appropriate image formats (PNG for icons, JPG for photos, OGG for sounds)

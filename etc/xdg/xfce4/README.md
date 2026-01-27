# GvOS XFCE4 Configuration

This directory contains the default XFCE4 desktop environment configuration for GvOS.

## Configuration Files

### Panel Configuration (`xfce4-panel.xml`)

Defines the taskbar/panel with GvOS customizations:

- **Rounded Taskbar**: Configured with transparency and rounded aesthetic
- **Custom Start Button**: Uses the GvOS icon (`/usr/share/pixmaps/gvosicon.png`)
- **Panel Plugins**:
  - Applications Menu (with GvOS icon)
  - Task List (window buttons)
  - System Tray
  - PulseAudio Volume Control
  - Clock
  - Actions Menu (logout, shutdown, etc.)

- **Styling**:
  - Background: Semi-transparent dark blue (#1e3a8a with 80% opacity)
  - Size: 48px height
  - Position: Bottom of screen
  - Auto-hide: Disabled

### Desktop Configuration (`xfce4-desktop.xml`)

Defines the desktop background and icon settings:

- **Default Wallpaper**: `/usr/share/backgrounds/gvos-wallpaper-1.png`
- **Image Style**: Scaled to fit screen
- **Icon Size**: 48px
- **Custom Font Size**: 12pt

### Window Manager Configuration (`xfwm4.xml`)

Window manager settings optimized for GvOS:

- **Compositor**: Enabled for smooth animations and effects
- **Focus Mode**: Click to focus
- **Window Decorations**: Centered title, modern button layout
- **Workspaces**: 4 virtual desktops
- **Shadows**: Enabled for windows and docks
- **Snap Behavior**: Snap to borders enabled

## Installation

These configuration files are automatically applied when XFCE4 is installed on GvOS.

For manual installation:

```bash
# Copy configuration files to system config directory
sudo cp -r etc/xdg/xfce4 /etc/xdg/

# Copy to user's home directory for immediate effect
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
cp etc/xdg/xfce4/xfconf/xfce-perchannel-xml/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/
```

## Customization

To customize the XFCE configuration:

1. **Change Start Button Icon**: Edit `xfce4-panel.xml` and modify the `button-icon` property
2. **Change Panel Colors**: Modify the `background-rgba` array values in `xfce4-panel.xml`
3. **Change Default Wallpaper**: Edit `xfce4-desktop.xml` and update the `last-image` property
4. **Adjust Panel Size**: Modify the `size` property in `xfce4-panel.xml`

## Notes

- These settings apply system-wide to all users
- Users can override these settings through the XFCE Settings Manager
- Changes to XML files require restarting the XFCE session to take effect
- The panel configuration provides a modern, rounded aesthetic matching the GvOS theme

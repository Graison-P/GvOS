# GvOS Sounds Directory

This directory contains sound files for various system events in GvOS.

## Sound Files

### Placeholder Files (OGG Format)

The following placeholder files are included for basic system sounds:

- `boot.ogg` - Plays when GvOS starts up
- `shutdown.ogg` - Plays when GvOS shuts down
- `error.ogg` - Plays when a system error occurs
- `notification.ogg` - Plays for system notifications

### WM/GUI Sound Files (WAV Format)

The following WAV files are provided for window manager and GUI events:

- `startup.wav` - System startup sound
- `shutdown.wav` - System shutdown sound
- `login.wav` - User login sound
- `logout.wav` - User logout sound
- `critical.wav` - Critical alert sound
- `error.wav` - Error notification sound
- `warning.wav` - Warning notification sound
- `notice.wav` - General notice sound
- `charging.wav` - Battery charging sound
- `lowbattery.wav` - Low battery warning sound

## Customization

To customize the placeholder OGG sounds:

1. Create or obtain OGG Vorbis audio files
2. Replace the placeholder files with your custom audio files
3. Ensure files maintain the `.ogg` extension
4. Recommended audio properties:
   - Format: OGG Vorbis
   - Sample Rate: 44100 Hz
   - Channels: Stereo
   - Duration: 1-5 seconds (depending on the event)

## Sound Event Handling

### For Window Managers and Desktop Environments

GvOS provides sound event handling through two methods:

#### 1. Sound Theme Configuration (`index.theme`)

The `index.theme` file follows the XDG Sound Theme Specification and maps sound events to audio files. This file can be used by:
- Desktop environments (GNOME, KDE, XFCE, etc.)
- Notification daemons
- System configuration tools

#### 2. Sound Event Handler Script (`sound-events.sh`)

The `sound-events.sh` script provides shell functions for playing sounds. It can be:
- Sourced by window manager configuration files
- Called from systemd services
- Integrated into custom scripts

**Usage example:**
```bash
# Source the sound event handler
source /usr/share/sounds/sound-events.sh

# Play sounds for specific events
user_login          # Play login sound
notify_warning      # Play warning sound
battery_low         # Play low battery sound
```

**Available functions:**
- `system_startup()` - Play startup sound
- `system_shutdown()` - Play shutdown sound
- `user_login()` - Play login sound
- `user_logout()` - Play logout sound
- `notify_error()` - Play error sound
- `notify_warning()` - Play warning sound
- `notify_notice()` - Play notice sound
- `notify_critical()` - Play critical alert sound
- `battery_low()` - Play low battery sound
- `battery_charging()` - Play charging sound

### Integration Examples

**For i3/Sway WM:**
Add to your config file:
```
exec --no-startup-id /usr/share/sounds/sound-events.sh && system_startup
```

**For LightDM/GDM:**
Create a script in `/etc/X11/Xsession.d/` that sources the sound events.

**For systemd services:**
Create unit files that call the sound event functions at appropriate times.

## Additional Sounds

You can add additional sound files for other system events as needed.

# GvOS Systemd Services

This directory contains custom systemd service units for GvOS.

## Sound Event Services

### gvos-startup-sound.service
Plays the system startup sound when GvOS boots.

**To enable:**
```bash
systemctl enable gvos-startup-sound.service
```

### gvos-shutdown-sound.service
Plays the system shutdown sound when GvOS shuts down.

**To enable:**
```bash
systemctl enable gvos-shutdown-sound.service
```

## Adding Custom Services

You can add additional systemd service units here to customize GvOS behavior:
- Login/logout sound services
- Battery monitoring services
- Custom notification handlers
- System event triggers

See `systemd.service(5)` man page for service unit file format.

# GvOS Plymouth Boot Theme

This directory contains the GvOS boot animation theme for Plymouth.

## Files

- `gvos.plymouth` - Plymouth theme configuration file
- `gvos.script` - Plymouth script for boot animation
- `gvosicon.png` - GvOS logo displayed during boot
- `progress_box.png` - Progress bar background
- `progress_bar.png` - Progress bar fill

## Installation

To set this as the default Plymouth theme:

```bash
# Copy theme to system Plymouth themes directory
sudo cp -r /usr/share/plymouth/themes/gvos /usr/share/plymouth/themes/

# Set as default theme
sudo plymouth-set-default-theme gvos

# Update initramfs to include the new theme
sudo update-initramfs -u
```

## Features

- Centered GvOS logo
- Smooth gradient background (blue theme)
- Progress bar showing boot progress
- Message display at bottom of screen

## Customization

You can customize the theme by:

1. Replacing `gvosicon.png` with your own logo
2. Modifying the gradient colors in `gvos.script`
3. Changing the progress bar appearance by replacing the progress images
4. Adjusting positioning and layout in the script file

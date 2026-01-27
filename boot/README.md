# GvOS Boot Directory

This directory contains files necessary for booting GvOS.

## Contents

- `grub/` - GRUB bootloader configuration
  - `grub.cfg` - GRUB menu configuration
- `vmlinuz-placeholder` - Placeholder for the Linux kernel
- `initrd.img-placeholder` - Placeholder for the initial RAM disk

## Customization

In a real GvOS installation, this directory would contain:

1. **Linux Kernel** (`vmlinuz-*`): The actual Linux kernel binary
2. **Initial RAM Disk** (`initrd.img-*`): The initial filesystem loaded at boot
3. **GRUB Configuration**: Bootloader settings and menu entries

## GRUB Configuration

The GRUB configuration is split into:
- `/etc/default/grub` - User-editable settings
- `/boot/grub/grub.cfg` - Generated configuration (usually auto-generated)

To customize boot options, edit `/etc/default/grub` and regenerate the GRUB configuration.

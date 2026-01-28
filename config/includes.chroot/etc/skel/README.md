# User Skeleton Directory

This directory contains files and directories that will be copied to every new user's home directory created on GvOS.

## Usage

Place any default user configuration files, desktop shortcuts, or user-specific settings here. Examples:

- `.bashrc` - Bash shell configuration
- `.profile` - User profile settings  
- `.config/` - User application configurations
- `Desktop/` - Desktop shortcuts and files
- `.local/share/` - User-specific data files

## Example Structure

```
etc/skel/
├── .bashrc
├── .profile
├── Desktop/
│   └── Welcome.desktop
└── .config/
    └── xfce4/
        └── xfconf/
            └── xfce-perchannel-xml/
```

All files placed here will be automatically copied to each new user's home directory during user creation.

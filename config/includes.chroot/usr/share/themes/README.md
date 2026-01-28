# XFCE Themes Directory

Add your custom XFCE themes here for taskbar, window manager, and GTK styling.

## Theme Structure

Each theme should be a directory containing appropriate subdirectories:

```
MyTheme/
├── gtk-2.0/          # GTK2 theme files
├── gtk-3.0/          # GTK3 theme files
├── xfwm4/            # Window manager theme
├── xfce4-panel/      # Panel theme (optional)
└── index.theme       # Theme metadata
```

## Setting Default Theme

To set a theme as default, update the hook script `config/hooks/live/01-customize-gui.hook.chroot` to reference your theme name.

## Finding Themes

- Download themes from [xfce-look.org](https://www.xfce-look.org/)
- Create your own custom theme
- Copy existing themes and modify them

Place complete theme directories here for inclusion in the GvOS build.

# Personal Dotfiles

Personal configuration files managed with GNU Stow for easy deployment and theme switching.

## Quick Start

```bash
# Install all configs
./install.sh

# Install specific configs
stow git zsh nvim hypr foot waybar mako scripts
```

## Structure

This directory uses GNU Stow for managing dotfiles. Each subdirectory represents a "package" that can be installed independently.

```
dotfiles/
├── git/          # Git configuration
│   └── .gitconfig
├── zsh/          # Zsh shell configuration  
│   ├── .zshrc
│   └── .zimrc
├── nvim/         # Neovim configuration
│   └── .config/nvim/
├── hypr/         # Hyprland window manager
│   └── .config/hypr/
├── foot/         # Foot terminal
│   └── .config/foot/
├── waybar/       # Waybar status bar
│   └── .config/waybar/
├── mako/         # Mako notification daemon
│   └── .config/mako/
├── scripts/      # Personal utility scripts
│   ├── .local/bin/
│   └── .config/systemd/user/
├── themes/       # Theme configurations
│   ├── gruvbox/
│   ├── catppuccin/
│   └── current -> gruvbox
└── install.sh    # Install script
```

## Theme System

Switch themes with:
```bash
geoloc-theme-set gruvbox
geoloc-theme-set catppuccin
```

## Scripts Package

The `scripts` package includes personal utility scripts and systemd user services:

### Battery Monitor
The battery monitor is automatically enabled when installing the scripts package. It will:
- Check battery level every 30 seconds
- Send a notification when battery drops below 15%
- Only run on systems with a battery (laptops)

Check status with:
```bash
systemctl --user status geoloc-battery-monitor.timer
```

## Requirements

- GNU Stow: `sudo pacman -S stow`
- Geoloc-OS utilities for theme management
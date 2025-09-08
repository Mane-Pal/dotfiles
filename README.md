# Personal Dotfiles

Personal configuration files managed with GNU Stow for easy deployment and theme switching.

## Quick Start

```bash
# Install all configs
./install.sh

# Install specific configs  
stow git zsh nvim hypr foot waybar mako
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

## Requirements

- GNU Stow: `sudo pacman -S stow`
- Geoloc-OS utilities for theme management
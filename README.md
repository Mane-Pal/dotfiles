# Personal Dotfiles

Personal configuration files managed with GNU Stow.

## Quick Start

```bash
# Install all configs
./install.sh

# Install specific configs
stow git zsh nvim hypr kitty waybar mako scripts
```

## Structure

Each subdirectory is a stow "package" that can be installed independently.

```
dotfiles/
├── btop/         # System monitor
├── fastfetch/    # System info
├── fontconfig/   # Font configuration
├── git/          # Git configuration
├── hypr/         # Hyprland window manager
├── kitty/        # Kitty terminal
├── lazygit/      # Git TUI
├── mako/         # Notification daemon
├── nvim/         # Neovim configuration
├── opencode/     # OpenCode config
├── scripts/      # Utility scripts & systemd services
├── starship/     # Shell prompt
├── tmux/         # Terminal multiplexer
├── waybar/       # Status bar
├── zsh/          # Zsh shell
└── install.sh    # Install script
```

## Scripts Package

The `scripts` package includes utility scripts in `~/.local/bin/` and systemd user services.

### Battery Monitor
Automatically enabled when installing the scripts package:
- Checks battery level every 30 seconds
- Sends notification when battery drops below 15%
- Only runs on systems with a battery

Check status:
```bash
systemctl --user status geoloc-battery-monitor.timer
```

## Requirements

- GNU Stow: `sudo pacman -S stow`

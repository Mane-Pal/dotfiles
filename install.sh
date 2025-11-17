#!/bin/bash
# Install dotfiles using GNU Stow

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
  echo -e "${GREEN}[DOTFILES] $*${NC}"
}

info() {
  echo -e "${BLUE}[INFO] $*${NC}"
}

warn() {
  echo -e "${YELLOW}[WARNING] $*${NC}"
}

# Check if stow is installed
if ! command -v stow &>/dev/null; then
  warn "GNU Stow not found. Installing..."
  if command -v pacman &>/dev/null; then
    sudo pacman -S --needed --noconfirm stow
  else
    echo "Please install GNU Stow manually: sudo pacman -S stow"
    exit 1
  fi
fi

cd "$(dirname "$0")"

# Available packages
PACKAGES=(
  "git"
  "zsh"
  "nvim"
  "tmux"
  "hypr"
  "kitty"
  "mako"
  "waybar"
  "themes"
  "scripts"
  "starship"
  "fastfetch"
  "fontconfig"
  "btop"
  "lazygit"
)

install_package() {
  local package="$1"
  if [[ -d "$package" ]]; then
    info "Installing $package..."
    stow -t ~ "$package"

    # Post-install actions for specific packages
    case "$package" in
      "themes")
        # Create default theme symlink if it doesn't exist
        if [[ ! -e "$HOME/.config/themes/current" ]]; then
          info "Creating default theme symlink (gruvbox)..."
          ln -sf gruvbox "$HOME/.config/themes/current"
        fi
        # Create nvim theme symlink
        if [[ -d "$HOME/.config/nvim/lua/plugins" ]]; then
          info "Linking nvim theme file..."
          ln -sf "$HOME/.config/themes/current/nvim.lua" "$HOME/.config/nvim/lua/plugins/theme.lua"
        fi
        ;;
      "scripts")
        info "Enabling systemd user services..."
        # Reload systemd user daemon to pick up new services
        systemctl --user daemon-reload

        # Enable and start battery monitor if available
        if [[ -f "$HOME/.config/systemd/user/geoloc-battery-monitor.timer" ]]; then
          systemctl --user enable --now geoloc-battery-monitor.timer
          info "Battery monitor enabled and started"
        fi
        ;;
    esac
  else
    warn "Package $package not found, skipping"
  fi
}

show_help() {
  cat << EOF
Usage: $0 [PACKAGES...]

Install dotfiles using GNU Stow

OPTIONS:
  (none)          Install all packages
  PACKAGES...     Install specific packages

AVAILABLE PACKAGES:
  $(printf "  %s\n" "${PACKAGES[@]}")

EXAMPLES:
  $0              # Install everything
  $0 git zsh      # Install just git and zsh configs
  $0 nvim hypr    # Install neovim and hyprland configs

EOF
}

main() {
  log "Installing dotfiles with GNU Stow..."
  
  if [[ $# -eq 0 ]]; then
    # Install all packages
    for package in "${PACKAGES[@]}"; do
      install_package "$package"
    done
  else
    # Install specified packages
    for package in "$@"; do
      case "$package" in
        --help|-h|help)
          show_help
          exit 0
          ;;
        *)
          install_package "$package"
          ;;
      esac
    done
  fi
  
  log "Dotfiles installation complete!"
  info "To uninstall a package: stow -D PACKAGE_NAME"
}

main "$@"
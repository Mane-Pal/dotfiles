# Theme System

Simple theme management for consistent visual styling across all applications.

## Structure

Each theme directory contains configuration snippets for different applications:

```
themes/
├── gruvbox/
│   ├── foot.ini          # Terminal colors
│   ├── waybar.css        # Status bar theme
│   ├── hyprland.conf     # Window manager colors
│   ├── mako.conf         # Notification colors
│   └── nvim.lua          # Editor theme
├── catppuccin/
├── tokyo-night/
└── current -> gruvbox    # Symlink to active theme
```

## Usage

```bash
# Switch themes (requires geoloc-theme-set from system/bin/)
geoloc-theme-set gruvbox
geoloc-theme-set catppuccin

# Check current theme
readlink themes/current
```

## How It Works

1. Theme files contain only color/styling configurations
2. Main config files import from `themes/current/`
3. `geoloc-theme-set` changes the symlink and reloads apps
4. All applications switch themes simultaneously

## Adding a New Theme

1. Create directory: `mkdir themes/new-theme`
2. Add config files for each application
3. Use existing themes as templates
4. Test: `geoloc-theme-set new-theme`
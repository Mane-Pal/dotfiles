#!/usr/bin/env sh

set -e

#
# plugin.sh.tmux: initializes the plugin when tmux is started.
#
# TPM loads the plugin by executing all *.tmux files in the root directory, so
# this file has the "tmux" extension despite being a shell script.
#

root_dir="$(dirname "$(readlink -f "$0")")"
config_file="$root_dir/config.yaml"
plugin_dir="$root_dir/plugin"
init_file="$plugin_dir/init.tmux"

# Copy the default configs to the root directory if they don't exist yet. The
# root files are gitignored so users can customize them without breaking git
# updates.
if [ ! -f "$config_file" ]; then
    cp "$root_dir/config.example.yaml" "$config_file"
fi
if [ ! -f "$init_file" ]; then
    cp "$plugin_dir/init.example.tmux" "$init_file"
fi

# If enabled, rebuild the menu from the user config.
case "$(tmux show-option -gvq @tmux-which-key-disable-autobuild)" in
1 | true) ;;
*)
    echo "[tmux-which-key] Rebuilding menu ..."
    if command -v python3 >/dev/null; then
        "$plugin_dir/build.py" "$config_file" "$init_file"
    else
        echo "[tmux-which-key] python3 not found"
    fi
    ;;
esac

# Load the plugin.
tmux source-file "$init_file"

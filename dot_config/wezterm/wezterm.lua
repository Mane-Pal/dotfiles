local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

config = {
	-- Terminal type optimized for tmux
	term = "wezterm",
	
	-- Color scheme
	color_scheme = "Catppuccin Mocha",
	
	-- Tab bar disabled since we use tmux
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	
	-- Font configuration with ligatures
	font = wezterm.font_with_fallback({
		{
			family = "JetBrains Mono",
			weight = "Medium",
			harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		},
		"Noto Color Emoji",
		"Symbols Nerd Font Mono",
	}),
	font_size = 12.0,
	line_height = 1.1,
	
	-- Performance
	max_fps = 120,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	
	-- Window configuration
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 1.0,
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,
	
	-- Padding optimized for tmux status bar
	window_padding = {
		left = 4,
		right = 4,
		top = 8,
		bottom = 4,
	},
	
	-- Cursor configuration
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 500,
	
	-- Scrollback
	scrollback_lines = 10000,
	
	-- Mouse and clipboard integration
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("Line"),
		},
	},
	
	-- Minimal keybindings - let tmux handle everything else
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		-- Quick reload config
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
		-- Copy/paste that works well with tmux
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
	},
	
	-- Disable default assignments to avoid conflicts with tmux
	disable_default_key_bindings = true,
}

-- Start tmux automatically with zsh shell
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({
		args = { "tmux", "new-session", "-A", "-s", "main", "zsh" },
	})
end)

return config

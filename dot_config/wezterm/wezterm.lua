local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

config = {
	term = "xterm-256color",
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false, -- Hide tab bar since we'll use tmux
	font_size = 12.0,
	font = wezterm.font("JetBrains Mono"),
	max_fps = 120,

	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 1.0,
	window_decorations = "RESIZE",

	window_padding = {
		left = 3,
		right = 3,
		top = 15,
		bottom = 0,
	},

	-- Remove all previous key bindings
	keys = {
		-- Keep only fullscreen toggle if desired
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}

-- Start tmux automatically
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({
		args = { "tmux", "new-session", "-A", "-s", "main" },
	})
end)

return config

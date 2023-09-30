local term = require("wezterm")

local M = {}

---- Appearance
-- Color pallete
M.colors = {
	transparent = "rgba(0,0,0,0)",
}

function M.options(config)
	config.status_update_interval = 1000
	config.color_scheme = "Catppuccin Mocha"

	config.animation_fps = 240
	config.max_fps = 240

	config.initial_cols = 117
	config.initial_rows = 32
	config.font = term.font({
		family = "JetBrainsMono Nerd Font",
		weight = "Medium",
		stretch = "Normal",
		style = "Normal",
		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		-- scale = 1.0
	})
	config.font_size = 14
	config.enable_scroll_bar = false
	config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
	config.window_padding = { left = "1px", right = "1px", top = "0.1cell", bottom = "0.1cell" }

	----- Misc
	config.adjust_window_size_when_changing_font_size = false
	config.audible_bell = "Disabled"
	config.exit_behavior = "Close"
	config.window_close_confirmation = "NeverPrompt"
	config.scrollback_lines = 50000
	config.tab_max_width = 9999
	config.hide_tab_bar_if_only_one_tab = true
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.allow_win32_input_mode = true
	config.disable_default_key_bindings = true

	config.window_background_opacity = 0.9
	config.macos_window_background_blur = 50
end

return M

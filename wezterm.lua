-- Pull in the wezterm API
------------------------------------------------------
--               Wezterm configuration
------------------------------------------------------

local wezterm = require("wezterm")

local terminal = require("terminal")
local keymaps = require("keymaps")
local ssh = require("ssh")
local update_right_status = require("update-right-status")

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

terminal.options(config)
keymaps.options(config)
ssh.options(config)
update_right_status.init(wezterm, terminal)

-- This is where you actually apply your config choices
config.default_domain = 'WSL:Ubuntu-22.04'

-- and finally, return the configuration to wezterm
return config

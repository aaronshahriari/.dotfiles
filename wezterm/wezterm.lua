-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- setup color_scheme
-- config.color_scheme = 'Pastel White (terminal.sexy)'
config.color_scheme = '3024 (base16)'

-- tabbar
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

-- keybindings
config.keys = {
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = false },
    },
    {
        key = 'Backspace',
        mods = 'CTRL',
        action = wezterm.action.SendString("\x17"),
    },
}

-- setup padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- define file to set font-size
local file = io.open("/tmp/setup_display", "r")

-- reading & setting the font-size
local mode = file and file:read("*line") or ""

-- close the file if it was successfully opened
if file then file:close() end

mode = mode:gsub("\n", "") -- this specifically removes newline characters
mode = mode:gsub("%s+$", "") -- this removes any trailing whitespace (including spaces)

-- check for specific values
if mode == "home-two" then
  config.font_size = 11
elseif mode == "laptop" then
  config.font_size = 7
else
  config.font_size = 9
end

-- Log the current font size
wezterm.log_info("Current font size is: " .. config.font_size)

-- fonts
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'

-- cursor
config.cursor_blink_rate = 0
config.hide_mouse_cursor_when_typing = true

-- tabs settings
config.window_frame = {
  font = wezterm.font 'CaskaydiaCove Nerd Font Mono',
  font_size = 9.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

return config

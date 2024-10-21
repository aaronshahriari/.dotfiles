-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- create datetime bottom right
wezterm.on('update-right-status', function(window)
    local date = wezterm.strftime '%m-%d-%Y %H:%M'

    -- Make it italic and underlined
    window:set_right_status(wezterm.format {
        { Text = date },
    })
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- setup color_scheme
-- config.color_scheme = 'Pastel White (terminal.sexy)'
config.color_scheme = '3024 (base16)'

config.window_close_confirmation = 'NeverPrompt'

-- TABBAR
-- config.enable_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_frame = {
    font = wezterm.font 'CaskaydiaCove Nerd Font Mono',
    font_size = 12.0,
    active_titlebar_bg = '#333333',
    inactive_titlebar_bg = '#333333',
}

-- keybindings

config.leader = { key = "Space", mods = "CTRL" }

-- active copy mode via Ctrl+Shift+x
config.keys = {
    -- tmux like commands to use wezterm
    -- testing
    { key = "c", mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
    { key = "h", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
    { key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
    { key = "s", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "v", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "1", mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
    { key = "2", mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
    { key = "3", mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
    { key = "4", mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
    { key = "5", mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
    { key = "6", mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
    { key = "7", mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
    { key = "8", mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
    { key = "9", mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
    { key = "d", mods = "LEADER",       action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { key = "x", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
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

mode = mode:gsub("\n", "")   -- this specifically removes newline characters
mode = mode:gsub("%s+$", "") -- this removes any trailing whitespace (including spaces)

-- check for specific values
if mode == "home-two" then
    config.font_size = 14
elseif mode == "laptop" then
    config.font_size = 10
else
    config.font_size = 12
end

-- use this for logging
-- wezterm.log_info("Current font size is: " .. config.font_size)

-- fonts
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'

-- cursor
config.cursor_blink_rate = 0
config.hide_mouse_cursor_when_typing = true

return config

local vars               = require("main.user_vars")

local dpi                = vars.dpi
-- local config_path         = vars.config_path

local theme              = {}

-- set wallpaper
-- theme.wallpaper           = config_path .. "awesome_wallpaper.png"

theme.useless_gap        = dpi(0)
theme.border_width       = dpi(1)

theme.font               = "JetBrainsMono Nerd Font Bold 10"
-- theme.font               = "CaskaydiaCove Nerd Font 10"
theme.tasklist_bg_focus  = "#000000"
theme.tasklist_fg_focus  = "#ffffff"
theme.tasklist_bg_normal = "#000000"
theme.tasklist_fg_normal = "#636363"
theme.taglist_bg_focus   = "#ffffff"
theme.taglist_fg_focus   = "#000000"
theme.border_normal      = "#000000"
theme.border_focus       = "#ffffff"
theme.border_marked      = "#000000"
theme.tag_square_sel     = "#000000"
theme.tag_square_normal  = "#ffffff"
theme.fg_normal          = "#ffffff"
theme.fg_focus           = "#ffffff"
theme.fg_urgent          = "#ffffff"
theme.fg_minimize        = "#ffffff"

-- wibar colors
theme.close_span         = "</span>"
-- icon
theme.nixos              = "#5a90db"
theme.nixos              = "<span color='" .. theme.nixos .. "'>"
-- clock
theme.white              = "#ffffff"
theme.clock              = "<span color='" .. theme.white .. "'>"
-- volume
theme.mute               = "#ff5555"
theme.mute_span          = "<span color='" .. theme.mute .. "'>"
-- battery
theme.battery0           = "#4CAF50"
theme.battery0_span      = "<span color='" .. theme.battery0 .. "'>"
theme.battery1           = "#8BC34A"
theme.battery1_span      = "<span color='" .. theme.battery1 .. "'>"
theme.battery2           = "#FFEB3B"
theme.battery2_span      = "<span color='" .. theme.battery2 .. "'>"
theme.battery3           = "#FFC107"
theme.battery3_span      = "<span color='" .. theme.battery3 .. "'>"
theme.battery4           = "#FF9800"
theme.battery4_span      = "<span color='" .. theme.battery4 .. "'>"
theme.battery5           = "#FF5722"
theme.battery5_span      = "<span color='" .. theme.battery5 .. "'>"
-- wifi
theme.wifi0              = "#4CAF50"
theme.wifi0_span         = "<span color='" .. theme.wifi0 .. "'>"
theme.wifi1              = "#FFEB3B"
theme.wifi1_span         = "<span color='" .. theme.wifi1 .. "'>"
theme.wifi2              = "#FF9800"
theme.wifi2_span         = "<span color='" .. theme.wifi2 .. "'>"
theme.wifi3              = "#FF5722"
theme.wifi3_span         = "<span color='" .. theme.wifi3 .. "'>"
-- audio
theme.audio              = "#636363"
theme.audio_span         = "<span color='" .. theme.audio .. "'>"

return theme

local vars              = require("main.user_vars")

local dpi               = vars.dpi
-- local config_path         = vars.config_path

local theme             = {}

-- set wallpaper
-- theme.wallpaper           = config_path .. "awesome_wallpaper.png"

theme.useless_gap       = dpi(0)
theme.border_width      = dpi(1)

theme.font              = "CaskaydiaCove Nerd Font 10"
theme.tasklist_bg_focus = "#000000"
theme.tasklist_fg_focus = "#ffffff"
theme.taglist_bg_focus  = "#ffffff"
theme.taglist_fg_focus  = "#000000"
theme.border_normal     = "#000000"
theme.border_focus      = "#ffffff"
theme.border_marked     = "#000000"

-- FIXME: change these
theme.fg_normal         = "#a9b1d6"
theme.fg_focus          = "#c8d3f5"
theme.fg_urgent         = "#ffffff"
theme.fg_minimize       = "#ffffff"

theme.gray              = "#3b4261"
theme.html_white        = "<span color='" .. theme.fg_focus .. "'>"
theme.html_gray         = "<span color='" .. theme.gray .. "'>"

return theme

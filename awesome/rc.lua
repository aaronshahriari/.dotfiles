pcall(require, "luarocks.loader")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")

-- THEME
local vars = require("main.user_vars")
local config_path = vars.config_path

beautiful.init(config_path .. "/theme.lua")
beautiful.maximized_hide_border = true

-- ERRORS
require("main.error")

-- LAYOUT & RULES
local layouts = require("main.layout")
local rules = require("main.rule")

-- Order matters: it should follow that of the default rc.lua config
awful.layout.layouts = layouts
-- require("main.tag")
awful.rules.rules = rules

require("appearance.wibox")

-- KEYS
-- Set keys
local globalkeys = require("key.globalkeys")
local globalbuttons = require("key.globalbuttons")

root.keys(globalkeys)
root.buttons(globalbuttons)

-- FIXME: do later
require("main.signal")
-- require("module.autostart")

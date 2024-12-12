require("colorbuddy").colorscheme('aaron')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

Color.new('white', '#d9d9d9')
Color.new('light_white', '#424242')
Color.new('red', '#cc6666')
Color.new('pink', '#fef601')
Color.new('green', '#99cc99')
Color.new('yellow', '#f8fe7a')
Color.new('blue', '#81a2be')
Color.new('aqua', '#8ec07c')
Color.new('cyan', '#8abeb7')
Color.new('purple', '#8e6fbd')
Color.new('violet', '#b294bb')
Color.new('orange', '#de935f')
Color.new('brown', '#a3685a')
Color.new('seagreen', '#698b69')
Color.new('turquoise', '#698b69')
Color.new("background", '#000000')

-- DIAGNOSTICS
Group.new("DiagnosticError", c.red)
Group.new("DiagnosticOk", c.green)
Group.new("DiagnosticWarn", c.orange)
Group.new("DiagnosticHint", c.violet)
Group.new("DiagnosticInfo", c.purple)

-- CURSORS
Group.new("CursorLine", c.white, c.background)

-- floats
Group.new("NormalFloat", c.superwhite)
Group.new("NormalNC", c.superwhite:dark(), c.background)

-- nvim groups set
Group.new("Normal", c.superwhite, c.background)
Group.new("Visual", c.none, c.light_white, s.none)
Group.new("Conceal", c.none, c.none, s.none)
Group.new("LineNr", c.light_white, c.black, s.none)
Group.new("Substitute", c.black, c.aqua, s.none)
Group.new("IncSearch", c.black, c.blue, s.none)

-- treesitter groups set
Group.new("@constant", c.orange, nil, s.none)
Group.new("@function", c.yellow, nil, s.none)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@keyword", c.violet, nil, s.none)
Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
Group.new("@property", c.blue)
Group.new("@variable", c.superwhite, nil)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

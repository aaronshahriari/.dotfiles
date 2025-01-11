require("colorbuddy").colorscheme('aaron')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

Color.new('white', '#d9d9d9')
Color.new('light_white', '#424242')
Color.new('dark_grey', '#212121')
Color.new('red', '#cc6666')
Color.new('pink', '#fef601')
Color.new('green', '#99cc99')
Color.new('yellow', '#f8fe7a')
Color.new('blue', '#81a2be')
Color.new('dark_blue', '#070738')
Color.new('aqua', '#8ec07c')
Color.new('cyan', '#8abeb7')
Color.new('purple', '#8e6fbd')
Color.new('violet', '#b294bb')
Color.new('orange', '#de935f')
Color.new('brown', '#a3685a')
Color.new('seagreen', '#698b69')
Color.new('turquoise', '#698b69')
Color.new("background", '#000000')

-- MARKDOWN
Group.new("@text.title.1.markdown", c.green)
Group.new("@text.title.2.markdown", c.orange)
Group.new("@text.title.3.markdown", c.purple)

-- COMPLETION
Group.new("PmenuSel", c.black, c.white)
Group.new("Pmenu", c.none, c.dark_grey)

-- DIAGNOSTICS
Group.new("DiagnosticError", c.red)
Group.new("DiagnosticOk", c.green)
Group.new("DiagnosticWarn", c.orange)
Group.new("DiagnosticHint", c.violet)
Group.new("DiagnosticInfo", c.purple)
Group.new("QuickFixLine", c.red, c.background)

-- CURSORS
Group.new("CursorLine", c.white, c.background)

-- FLOATS
Group.new("NormalFloat", c.white)
Group.new("FloatBorder", c.white)
Group.new("lspfloatwinborder", c.white)
Group.new("NormalNC", c.superwhite:dark(), c.background)

-- nvim groups set
Group.new("Title", c.white, nil, s.none)
Group.new("Normal", c.superwhite, c.background)
Group.new("Visual", c.none, c.light_white, s.none)
Group.new("Conceal", c.none, c.none, s.none)
Group.new("LineNr", c.light_white, c.black, s.none)
Group.new("Substitute", c.black, c.aqua, s.none)
Group.new("IncSearch", c.black, c.blue, s.none)

-- groups
Group.new("@text.title", c.white, nil, s.none)
Group.new("@constant", c.orange, nil, s.none)
Group.new("@function", c.yellow, nil, s.none)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@keyword", c.violet, nil, s.none)
Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
Group.new("@property", c.blue)
Group.new("@variable", c.superwhite, nil)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

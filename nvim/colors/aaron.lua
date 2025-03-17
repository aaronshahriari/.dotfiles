require("colorbuddy").colorscheme('aaron')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

-- basic colors (muted and eye-friendly)
Color.new('white', '#c0c0c0')
Color.new('light_white', '#7a7a7a')
Color.new('highlight_col', '#424242')
Color.new('dark_grey', '#212121')
Color.new('grey', '#888888')
Color.new('red', '#b07b7b')
Color.new('pink', '#f0b0b0')
Color.new('green', '#99cc99')
Color.new('yellow', '#d4b16e')
Color.new('blue', '#7a9fbf')
Color.new('dark_blue', '#070738')
Color.new('aqua', '#8ec07c')
Color.new('cyan', '#8abeb7')
Color.new('purple', '#8e6fbd')
Color.new('violet', '#a294bb')
Color.new('orange', '#d18a6b')
Color.new('brown', '#a3685a')
Color.new('seagreen', '#698b69')
Color.new('turquoise', '#698b69')
Color.new("background", '#000000')
Color.new("magenta", "#cc66cc")

-- MARKDOWN
Group.new("@text.title.1.markdown", c.green)
Group.new("@text.title.2.markdown", c.orange)
Group.new("@text.title.3.markdown", c.purple)

-- COMPLETION
Group.new("PmenuSel", c.black, c.white)
Group.new("Pmenu", c.none, c.dark_grey)

-- COLORCOLUMN
Group.new("ColorColumn", c.none, c.dark_grey)

-- DIAGNOSTICS
Group.new("DiagnosticError", c.red)
Group.new("DiagnosticOk", c.green)
Group.new("DiagnosticWarn", c.orange)
Group.new("DiagnosticHint", c.violet)
Group.new("DiagnosticInfo", c.purple)
Group.new("QuickFixLine", c.red, c.background)

-- CURSORS
Group.new("CursorLine", c.light_white, c.background)

-- FLOATS
Group.new("NormalFloat", c.white)
Group.new("FloatBorder", c.white)
Group.new("lspfloatwinborder", c.white)
Group.new("NormalNC", c.white:dark(), c.background)

-- Neovim Default Groups
Group.new("Title", c.white, nil, s.none)
Group.new("Normal", c.white, c.background)
Group.new("Visual", c.none, c.highlight_col, s.none)
Group.new("visualmode", c.none, c.highlight_col, s.none)
Group.new("visuallinemode", c.none, c.highlight_col, s.none)
Group.new("Conceal", c.none, c.none, s.none)
Group.new("LineNr", c.light_white, c.black, s.none)
Group.new("Substitute", c.black, c.aqua, s.none)
Group.new("IncSearch", c.black, c.blue, s.none)

-- Additional Groups

-- Comments (using new grey for clarity, yet distinct on the black background)
Group.new("Comment", c.grey, nil, s.italic)

-- Search Highlights
Group.new("Search", c.black, c.grey, s.none)
Group.new("CurSearch", c.black, c.yellow, s.none)
Group.new("VisualNOS", c.none, c.dark_grey, s.none)

-- Status Line
Group.new("StatusLine", c.light_white, c.dark_grey, s.none)
Group.new("StatusLineNC", c.light_white, c.dark_grey, s.none)

-- Cursor Line Number
Group.new("CursorLineNr", c.yellow, c.dark_grey, s.bold)

-- Splits and Tab Lines
Group.new("VertSplit", c.dark_grey, c.background, s.none)
Group.new("TabLine", c.light_white, c.dark_grey, s.none)
Group.new("TabLineSel", c.yellow, c.background, s.none)
Group.new("TabLineFill", c.none, c.dark_grey, s.none)

-- Folded Text
Group.new("Folded", c.purple, c.dark_grey, s.none)

-- Diff Highlights
Group.new("DiffAdd", c.green, c.dark_grey, s.none)
Group.new("DiffChange", c.blue, c.dark_grey, s.none)
Group.new("DiffDelete", c.red, c.dark_grey, s.none)
Group.new("DiffText", c.yellow, c.dark_grey, s.none)

-- Matching Parentheses
Group.new("MatchParen", c.orange, c.dark_blue, s.bold)

-- Message Types
Group.new("WarningMsg", c.orange, c.background, s.none)
Group.new("ErrorMsg", c.red, c.background, s.bold)
Group.new("Question", c.blue, c.background, s.none)
Group.new("MoreMsg", c.green, c.background, s.none)

-- Cursor Styles
Group.new("Cursor", c.white, c.dark_grey, s.none)
Group.new("TermCursor", c.white, c.dark_grey, s.none)
Group.new("TermCursorNC", c.light_white, c.dark_grey, s.none)

-- NonText (for filler lines or end-of-buffer symbols)
Group.new("NonText", c.dark_grey, nil, s.none)

-- Directory Listing in netrw etc.
Group.new("Directory", c.aqua, nil, s.none)

-- Special Keys and Operators
Group.new("Special", c.pink, nil, s.none)
Group.new("SpecialKey", c.pink, nil, s.none)
Group.new("Operator", c.orange, nil, s.none)

-- Syntax Highlighting Groups
Group.new("String", c.green, nil, s.none)
Group.new("Boolean", c.orange, nil, s.none)
Group.new("Number", c.purple, nil, s.none)
Group.new("Type", c.yellow, nil, s.none)
Group.new("Include", c.blue, nil, s.none)

-- Treesitter Enhancements (reusing some of your existing ones)
Group.new("@constant", c.orange, nil, s.none)
Group.new("@function", c.yellow, nil, s.none)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@keyword", c.violet, nil, s.none)
Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
Group.new("@property", c.blue)
Group.new("@variable", c.white, nil)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

local awful = require("awful")

local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

local tags = awful.screen.focused().selected_tags

awful.screen.connect_for_each_screen(function(s)
  awful.tag(names, s, awful.layout.suit.tile)

  if s.index == 2 then
    for _, t in ipairs(s.tags) do
      awful.layout.set(awful.layout.suit.tile, t)
      t.master_width_factor = 1
      t.master_count = 0
    end
  end
end)

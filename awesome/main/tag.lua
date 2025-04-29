local awful = require("awful")
local sharedtags = require("awesome-sharedtags")

local tags = sharedtags({
  -- Screen 1 tags
  { name = "1",  screen = 1, layout = awful.layout.suit.tile },
  { name = "2",  screen = 1, layout = awful.layout.suit.tile },
  { name = "3",  screen = 1, layout = awful.layout.suit.tile },
  { name = "4",  screen = 1, layout = awful.layout.suit.tile },
  { name = "5",  screen = 1, layout = awful.layout.suit.tile },

  -- Screen 2 tags
  { name = "6",  screen = 2, layout = awful.layout.suit.tile, master_width_factor = 1, master_count = 0 },
  { name = "7",  screen = 2, layout = awful.layout.suit.tile, master_width_factor = 1, master_count = 0 },
  { name = "8",  screen = 2, layout = awful.layout.suit.tile, master_width_factor = 1, master_count = 0 },
  { name = "9",  screen = 2, layout = awful.layout.suit.tile, master_width_factor = 1, master_count = 0 },
  { name = "10", screen = 2, layout = awful.layout.suit.tile, master_width_factor = 1, master_count = 0 },
})

return tags

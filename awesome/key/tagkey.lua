local awful = require("awful")
local gears = require("gears")
local vars = require("main.user_vars")
local sharedtags = require("awesome-sharedtags")

local modkey = vars.modkey

local tags = sharedtags({
  -- Screen 1 tags
  { name = "1",  screen = 1, layout = awful.layout.layouts[1] },
  { name = "2",  screen = 1, layout = awful.layout.layouts[1] },
  { name = "3",  screen = 1, layout = awful.layout.layouts[1] },
  { name = "4",  screen = 1, layout = awful.layout.layouts[1] },
  { name = "5",  screen = 1, layout = awful.layout.layouts[1] },

  -- Screen 2 tags
  { name = "6",  screen = 2, layout = awful.layout.layouts[1], master_width_factor = 1, master_count = 0 },
  { name = "7",  screen = 2, layout = awful.layout.layouts[1], master_width_factor = 1, master_count = 0 },
  { name = "8",  screen = 2, layout = awful.layout.layouts[1], master_width_factor = 1, master_count = 0 },
  { name = "9",  screen = 2, layout = awful.layout.layouts[1], master_width_factor = 1, master_count = 0 },
  { name = "10", screen = 2, layout = awful.layout.layouts[1], master_width_factor = 1, master_count = 0 },
})

local tagkeys = {}

for i = 1, 10 do
  tagkeys = gears.table.join(tagkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = tags[i]
        if tag then
          -- sharedtags.viewonly(tag, screen)
          sharedtags.jumpto(tag)
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = tags[i]
        if tag then
          sharedtags.viewtoggle(tag, screen)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = tags[i]
          if tag then
            client.focus:move_to_tag(tag)
            sharedtags.jumpto(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

return tagkeys

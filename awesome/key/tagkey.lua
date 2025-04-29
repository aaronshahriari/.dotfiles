local awful = require("awful")
local gears = require("gears")
local vars = require("main.user_vars")
local sharedtags = require("awesome-sharedtags")
local tags = require("main.tag")

local modkey = vars.modkey

local tagkeys = {}

for i = 1, 10 do
  tagkeys = gears.table.join(tagkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = tags[i]
        if tag then
          -- don't use this
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

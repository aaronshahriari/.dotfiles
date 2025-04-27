local awful = require("awful")
local gears = require("gears")

local vars = require("main.user_vars")
local modkey = vars.modkey

local clientkeys = gears.table.join(
  awful.key({ modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ modkey, }, "space", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" })
)

return clientkeys

local awful = require("awful")
local gears = require("gears")

local vars = require("main.user_vars")
local modkey = vars.modkey

local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c, nil, { warp_pointer = false })
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c, nil, { warp_pointer = false })
  end)
)

return clientbuttons

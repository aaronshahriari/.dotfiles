local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

beautiful.tasklist_disable_task_name = false

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
  awful.button({}, 4, function() awful.client.focus.byidx(1) end),
  awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

local widget_template_tasklist = {
  {
    {
      {
        {
          id     = 'icon_role',
          widget = wibox.widget.imagebox,
        },
        margins = 2,
        widget  = wibox.container.margin,
      },
      {
        id     = 'text_role',
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
      spacing = 7,
    },
    left   = 10,
    right  = 15,
    widget = wibox.container.margin
  },
  id     = 'background_role',
  widget = wibox.container.background,
}

local function tasklist(s)
  return awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = tasklist_buttons,
    layout          = wibox.layout.fixed.horizontal(),

    widget_template = widget_template_tasklist,
  }
end

return tasklist

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local theme = require("theme")

local vars = require("main.user_vars")
local modkey = vars.modkey
local dpi = vars.dpi

local taglist_square_size = dpi(4)
-- beautiful.taglist_squares_sel = beautiful.theme_assets.taglist_squares_sel(taglist_square_size, theme.tag_square_sel)
beautiful.taglist_squares_unsel = beautiful.theme_assets.taglist_squares_unsel(taglist_square_size,
  theme.tag_square_normal)

-- create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function taglist(s)
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }
end

return taglist

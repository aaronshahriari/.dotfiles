local awful = require("awful")
local wibox = require("wibox")

local appearance = { -- my library
  set_wallpaper = require("appearance.wallpaper"),
  mytaglist = require("appearance.taglist"),
  mytasklist = require("appearance.tasklist"),
  mytraywidgets = require("appearance.tray"),
  mypadding = require("appearance.padding"),
}

awful.screen.connect_for_each_screen(function(s)
  appearance.set_wallpaper(s)

  s.mypromptbox = awful.widget.prompt(s)
  s.mylayoutbox = awful.widget.layoutbox(s)

  s.mypopup = appearance.mypopup

  s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })

  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,

    -- LEFT WIDGETS
    {
      layout = wibox.layout.fixed.horizontal,

      appearance.mytraywidgets.nixos(s),
      appearance.mytaglist(s),
    },

    -- MIDDLE WIDGETS
    appearance.mytasklist(s),

    -- RIGHT WIDGETS
    {
      layout = wibox.layout.fixed.horizontal,

      appearance.mytraywidgets.myaudio(s),
      appearance.mytraywidgets.myvolume(s),
      appearance.mytraywidgets.mywifi(s),
      appearance.mytraywidgets.mybattery(s),
      appearance.mytraywidgets.mytextclock(s),
      -- FIXME: only showing on screen 2 when setup with two monitors
      -- wibox.container.margin(appearance.mytraywidgets.mysystray(s), 2, 2, 2, 2),
    },
  }
end)

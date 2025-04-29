local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local vars = require("main.user_vars")

-- System tray stuff
local dpi = vars.dpi
beautiful.systray_icon_spacing = dpi(4)

-- NOTE: Widgets library
local widgets = {}

-- NIXOS
function widgets.nixos(s)
  return wibox.widget {
    markup = beautiful.nixos .. " " .. beautiful.close_span,
    widget = wibox.widget.textbox,
    screen = s,
  }
end

-- CLOCK
function widgets.mytextclock(s)
  return wibox.widget {
    format = beautiful.clock .. "%m/%d/%y %I:%M%p" .. beautiful.close_span,
    widget = wibox.widget.textclock,
    screen = s,
  }
end

-- BATTERY
function widgets.mybattery(s)
  local battery_init = require("signals.battery_signal")
  local batterywidget = wibox.widget {
    widget = wibox.widget.textbox(),
    screen = s,
  }

  awesome.connect_signal("laptop::battery", function(display_text)
    if display_text then
      batterywidget.markup = display_text .. " | "
    end
  end)

  gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true,
    callback = function()
      battery_init.battery_emit()
    end
  }

  return wibox.widget {
    batterywidget,
    fg = beautiful.yellow,
    widget = wibox.container.background
  }
end

-- WIFI
function widgets.mywifi(s)
  local wifi_init = require("signals.wifi_signal")
  local wifiwidget = wibox.widget {
    widget = wibox.widget.textbox(),
    screen = s,
  }

  awesome.connect_signal("laptop::wifi", function(display_text)
    if display_text then
      wifiwidget.markup = display_text .. " | "
    end
  end)

  wifiwidget:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.spawn("ghostty -e nmtui")
    end)
  ))

  gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true,
    callback = function()
      wifi_init.wifi_emit()
    end
  }

  return wibox.widget {
    wifiwidget,
    fg = beautiful.yellow,
    widget = wibox.container.background
  }
end

-- VOLUME
function widgets.myvolume(s)
  local volume_init = require("signals.volume_signal")
  local volumewidget = wibox.widget {
    widget = wibox.widget.textbox(),
    screen = s,
  }

  awesome.connect_signal("laptop::volume", function(percentage, status)
    volumewidget.markup = percentage .. status .. " | "
  end)

  volumewidget:buttons(gears.table.join(
    awful.button({}, 1, function()
      volume_init.volume_emit("toggle")
    end),
    awful.button({}, 4, function()
      volume_init.volume_emit("1%+")
    end),
    awful.button({}, 5, function()
      volume_init.volume_emit("1%-")
    end)
  ))

  return wibox.widget({
    volumewidget,
    fg = beautiful.border_focus,
    widget = wibox.container.background
  })
end

-- AUDIO
function widgets.myaudio(s)
  local audio_init = require("signals.audio_signal")
  local audiowidget = wibox.widget {
    widget = wibox.widget.textbox(),
    screen = s,
  }

  awesome.connect_signal("laptop::audio", function(display_text)
    if display_text then
      audiowidget.markup = display_text .. " | "
    end
  end)

  audiowidget:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.spawn("playerctl play-pause")
    end)
  ))

  gears.timer {
    timeout = 30,
    autostart = true,
    call_now = true,
    callback = function()
      audio_init.audio_emit()
    end
  }

  return wibox.widget {
    audiowidget,
    fg = beautiful.yellow,
    widget = wibox.container.background
  }
end

function widgets.mysystray(s)
  return wibox.widget {

    widget = wibox.widget.systray,
    screen = s,
  }
end

return widgets

local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local vars = require("main.user_vars")

local config_path = vars.config_path
local terminal = vars.terminal
local default_layout = vars.defaut_layout
local modkey = vars.modkey

local tagkey = require("key.tagkey")

-- {{{ Key bindings
local globalkeys = gears.table.join(tagkey,
  -- AWESOME COMMANDS
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }
  ),

  -- MOVEMENT
  awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, }, "w", function() mymainmenu:show() end,
    { description = "show main menu", group = "awesome" }),

  -- LAYOUT MANIPULATION
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    { description = "go back", group = "client" }),

  -- TILE WINDOW COMMANDS
  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),

  -- CUSTOM COMMANDS --

  -- APP ACTIONS
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),

  -- FIXME: use rofi script launcher
  -- awful.key({ modkey }, "d", function()
  --   awful.spawn("~/.config/rofi/launchers/type-2/launcher.sh")
  -- end, { description = "run my script", group = "custom" })
  awful.key({ modkey }, "d", function()
    awful.spawn("rofi -show drun")
  end, { description = "run my script", group = "layout" }),
  awful.key({ modkey, }, "s", function() awful.spawn("rofi -show window") end,
    { description = "rofi window mode", group = "launcher" }),
  awful.key({ modkey, }, "a",
    function()
      awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/audio-sessionizer.sh")
      -- volumewidget:update()
    end),

  -- AUDIO
  ---- sound ----
  -- FIXME update volume widget here
  awful.key({ modkey, }, "a",
    function()
      awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/audio-sessionizer.sh")
      -- volumewidget:update()
    end),
  awful.key({ modkey, "Shift" }, "m",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      -- volumewidget:update()
    end),
  awful.key({}, "XF86AudioMute",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      -- volumewidget:update()
    end),
  awful.key({ modkey }, "equal",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
      awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+")
    end),
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
      awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+")
    end),
  awful.key({ modkey }, "minus",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
      awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
      -- volumewidget:update()
    end),
  awful.key({}, "XF86AudioLowerVolume",
    function()
      awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
      awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
      -- volumewidget:update()
    end),

  ---- play/pause ----
  awful.key({ modkey }, "v",
    function()
      awful.spawn("pavucontrol")
    end),
  awful.key({}, "XF86AudioPlay",
    function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/play-pause.sh") end),
  awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl next") end),
  awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl next") end),
  awful.key({ "Shift" }, "XF86AudioNext", function() awful.spawn("playerctl previous") end),

  ---- actions ----
  awful.key({ modkey }, "c", function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/fix-devices.sh") end),
  -- FIXME: add flameshot
  -- awful.key({modkey, "Shift"}, "s", function() awful.spawn("flameshot") end),
  awful.key({ modkey, "Shift" }, "e",
    function() awful.spawn(os.getenv("HOME") .. "/.config/rofi/powermenu/type-2/powermenu.sh") end),
  awful.key({ modkey }, "g", function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/dmenu-search.sh") end)
)

return globalkeys

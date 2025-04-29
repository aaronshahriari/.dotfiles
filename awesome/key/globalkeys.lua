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

-- WIGET INITIALIZE
local volume_init = require("signals.volume_signal")
volume_init.volume_emit("+")
local audio_init = require("signals.audio_signal")
audio_init.audio_emit("+")

-- {{{ Key bindings
local globalkeys = gears.table.join(tagkey,
  -- AWESOME COMMANDS
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "t", function() awful.layout.set(awful.layout.suit.tile) end,
    { description = "set layout to tile", group = "layout" }),


  -- MOVEMENT
  awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
    { description = "focus next by index", group = "client" }),
  awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, }, "l", function() awful.screen.focus_relative(1) end,
    { description = "focus next screen", group = "screen" }),
  awful.key({ modkey, }, "h", function() awful.screen.focus_relative(-1) end,
    { description = "focus previous screen", group = "screen" }),

  -- LAYOUT MANIPULATION
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = "client" }),

  -- RESIZING
  awful.key({ modkey }, ".", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, ",", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, ".", function() awful.client.incwfact(0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, ",", function() awful.client.incwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),

  ---- CUSTOM COMMANDS ----

  -- APP ACTIONS
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),

  -- FIXME: update rofi to be centered properly on the screen
  awful.key({ modkey }, "d", function()
    awful.spawn(os.getenv("HOME") .. "/.config/rofi/launchers/type-2/launcher.sh")
  end, { description = "run my script", group = "custom" }),
  -- FIXME: use rofi launcher for this too, allow icons
  awful.key({ modkey, }, "s", function() awful.spawn("rofi -show window") end,
    { description = "rofi window mode", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "d",
    function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/display-sessionizer.sh") end,
    { description = "display sessionizer", group = "launcher" }),

  -- AUDIO
  ---- sound ----
  -- FIXME update volume widget here
  awful.key({ modkey, }, "a",
    function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/audio-sessionizer.sh") end),
  awful.key({ modkey, "Shift" }, "m", function() volume_init.volume_emit("toggle") end),
  awful.key({}, "XF86AudioMute", function() volume_init.volume_emit("toggle") end),
  awful.key({ modkey }, "equal", function() volume_init.volume_emit("1%+") end),
  awful.key({}, "XF86AudioRaiseVolume", function() volume_init.volume_emit("1%+") end),
  awful.key({ modkey }, "minus", function() volume_init.volume_emit("1%-") end),
  awful.key({}, "XF86AudioLowerVolume", function() volume_init.volume_emit("1%-") end),

  ---- play/pause ----
  awful.key({ modkey }, "v",
    function()
      awful.spawn("pavucontrol")
    end),
  awful.key({}, "XF86AudioPlay",
    function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/play-pause.sh") end),
  awful.key({}, "XF86AudioNext", function() audio_init.audio_emit("next") end),
  awful.key({}, "XF86AudioPrev", function() audio_init.audio_emit("previous") end),
  awful.key({ "Shift" }, "XF86AudioNext", function() audio_init.audio_emit("previous") end),

  ---- actions ----
  awful.key({ modkey }, "c", function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/fix-devices.sh") end),
  awful.key({ modkey, "Shift" }, "d",
    function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/display-sessionizer.sh") end),
  awful.key({ modkey, "Shift" }, "s", function() awful.spawn("flameshot gui") end),
  awful.key({ modkey, "Shift" }, "e",
    function() awful.spawn(os.getenv("HOME") .. "/.config/rofi/powermenu/type-2/powermenu.sh") end),
  awful.key({ modkey }, "g", function() awful.spawn(os.getenv("HOME") .. "/.local/bin/scripts/rofi/dmenu-search.sh") end)
)

return globalkeys

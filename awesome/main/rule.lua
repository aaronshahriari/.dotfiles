local awful = require("awful")
local beautiful = require("beautiful")
local clientkeys = require("key.clientkey")
local clientbuttons = require("key.clientbutton")
local tags = require("main.tag")

local rules = {
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },
  {
    rule = { class = "pavucontrol" },
    properties = {
      screen = 1,
      floating = true,
      width = 1100,
      height = 600,
      placement = function(c)
        awful.placement.centered(c, { honor_workarea = true })
      end
    }
  },
  {
    rule = { class = ".gimp-2.10-wrapped_" },
    properties = {
      tag = tags[5],
      focus = false,
    }
  },
  {
    rule = { class = "obs" },
    properties = {
      tag = tags[8],
      focus = false,
    }
  },
  {
    rule = { class = "Spotify" },
    properties = {
      tag = tags[6],
      focus = false,
    }
  },
  {
    rule = { class = "1Password" },
    properties = {
      tag = tags[6],
      focus = false,
    }
  },
}

return rules

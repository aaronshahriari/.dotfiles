local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.volume_emit(arg)
  local command
  if arg == "toggle" then
    command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  else
    command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. arg
  end

  awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
      local volume = tonumber(string.match(stdout, "(%d+%.%d+)"))
      local muted_bool = string.match(stdout, "%[MUTED%]") ~= nil
      local muted = muted_bool and "" or ""

      if volume then
        local percentage = math.floor(volume * 100)
        local display_text
        local icon

        if muted_bool then
          percentage = 0
          icon = beautiful.mute_span .. " " .. beautiful.close_span
          display_text = icon
        else
          if percentage == 0 then
            icon = ""
          elseif percentage <= 20 then
            icon = ""
          elseif percentage <= 40 then
            icon = ""
          elseif percentage <= 60 then
            icon = ""
          elseif percentage <= 80 then
            icon = ""
          else
            icon = ""
          end
          display_text = icon .. " " .. percentage .. "%"
        end

        awesome.emit_signal("laptop::volume", display_text, muted)
      end
    end)
  end)
end

return M

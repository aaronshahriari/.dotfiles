local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.audio_emit(arg)
  local command
  if arg == "play-pause" then
    command = "playerctl play-pause"
  elseif arg == "next" then
    command = "playerctl next"
  elseif arg == "previous" then
    command = "playerctl previous"
  else
    command = nil
  end

  awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell("playerctl metadata --format '{{ artist }} - {{ title }}'",
      function(stdout)
        local song = stdout:gsub("%s+$", "")
        local display_text
        if song and song ~= "" then
          display_text = song
          display_text = beautiful.audio_span .. display_text .. beautiful.close_span
        else
          display_text = ""
        end

        awesome.emit_signal("laptop::audio", display_text)
      end)
  end)
end

return M

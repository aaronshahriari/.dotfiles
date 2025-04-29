local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.audio_emit()
  awful.spawn.easy_async_with_shell(
    "playerctl metadata --format '{{ artist }} - {{ title }}'",
    function(stdout)
      local song = stdout:gsub("%s+$", "")
      if song == "" then
        song = ""
      end

      song = beautiful.audio_span .. song .. beautiful.close_span
      awesome.emit_signal("laptop::audio", song)
    end
  )
end

return M

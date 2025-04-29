local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.wifi_emit()
  awful.spawn.easy_async_with_shell(
    [[
    if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = "up" ]; then
      awk '/^\s*w/ { print int($3 * 100 / 70) }' /proc/net/wireless
      nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2
    else
      echo "down"
    fi
    ]],
    function(stdout)
      local lines = {}
      for line in stdout:gmatch("[^\r\n]+") do
        table.insert(lines, line)
      end

      local wifisignal = tonumber(lines[1])
      local network = lines[2] or ""

      local iconstrength = ""

      if lines[1] == "down" then
        iconstrength = beautiful.wifi3_span .. "󰤭" .. beautiful.close_span
        network = ""
      else
        if wifisignal >= 90 then
          iconstrength = beautiful.wifi0_span .. "󰤨 " .. beautiful.close_span
        elseif wifisignal >= 80 then
          iconstrength = beautiful.wifi0_span .. "󰤥 " .. beautiful.close_span
        elseif wifisignal >= 60 then
          iconstrength = beautiful.wifi1_span .. "󰤢 " .. beautiful.close_span
        elseif wifisignal >= 40 then
          iconstrength = beautiful.wifi2_span .. "󰤟 " .. beautiful.close_span
        elseif wifisignal >= 20 then
          iconstrength = beautiful.wifi3_span .. "󰤯 " .. beautiful.close_span
        else
          iconstrength = beautiful.wifi3_span .. "󰤯 " .. beautiful.close_span
        end
      end

      local display_text = iconstrength .. network
      awesome.emit_signal("laptop::wifi", display_text)
    end
  )
end

return M

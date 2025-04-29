local awful = require("awful")
local beautiful = require("beautiful")

local M = {}

function M.battery_emit()
  local battery = "/sys/class/power_supply/BAT1/"

  awful.spawn.easy_async_with_shell("cat " .. battery .. "status; cat " .. battery .. "capacity", function(stdout)
    local status, capacity = stdout:match("(%w+)%s+(%d+)")
    capacity = tonumber(capacity)

    local icon
    local color_capacity
    local display_text
    if status == "Full" then
      icon = beautiful.battery0_span .. "󰁹 " .. beautiful.close_span
      color_capacity = beautiful.battery0_span .. capacity .. "%" .. beautiful.close_span
    elseif status == "Discharging" then
      if capacity >= 99 then
        icon = beautiful.battery1_span .. "󰁹 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 90 then
        icon = beautiful.battery1_span .. "󰂂 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 80 then
        icon = beautiful.battery1_span .. "󰂁 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 70 then
        icon = beautiful.battery2_span .. "󰂀 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 60 then
        icon = beautiful.battery2_span .. "󰁿 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 50 then
        icon = beautiful.battery2_span .. "󰁾 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 40 then
        icon = beautiful.battery3_span .. "󰁽 " .. beautiful.close_span
        color_capacity = beautiful.battery3_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 30 then
        icon = beautiful.battery3_span .. "󰁼 " .. beautiful.close_span
        color_capacity = beautiful.battery3_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 20 then
        icon = beautiful.battery4_span .. "󰁻 " .. beautiful.close_span
        color_capacity = beautiful.battery4_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 10 then
        icon = beautiful.battery4_span .. "󰁻 " .. beautiful.close_span
        color_capacity = beautiful.battery4_span .. capacity .. "%" .. beautiful.close_span
      else
        icon = beautiful.battery5_span .. "󰂎 " .. beautiful.close_span
        color_capacity = beautiful.battery5_span .. capacity .. "%" .. beautiful.close_span
      end
    elseif status == "Charging" then
      if capacity >= 99 then
        icon = beautiful.battery1_span .. "󰂅 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 90 then
        icon = beautiful.battery1_span .. "󰂋 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 80 then
        icon = beautiful.battery1_span .. "󰂊 " .. beautiful.close_span
        color_capacity = beautiful.battery1_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 70 then
        icon = beautiful.battery2_span .. "󰢞 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 60 then
        icon = beautiful.battery2_span .. "󰂉 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 50 then
        icon = beautiful.battery2_span .. "󰢝 " .. beautiful.close_span
        color_capacity = beautiful.battery2_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 40 then
        icon = beautiful.battery3_span .. "󰂈 " .. beautiful.close_span
        color_capacity = beautiful.battery3_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 30 then
        icon = beautiful.battery3_span .. "󰂇 " .. beautiful.close_span
        color_capacity = beautiful.battery3_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 20 then
        icon = beautiful.battery4_span .. "󰂆 " .. beautiful.close_span
        color_capacity = beautiful.battery4_span .. capacity .. "%" .. beautiful.close_span
      elseif capacity >= 10 then
        icon = beautiful.battery4_span .. "󰢜 " .. beautiful.close_span
        color_capacity = beautiful.battery4_span .. capacity .. "%" .. beautiful.close_span
      else
        icon = beautiful.battery5_span .. "󰢟 " .. beautiful.close_span
        color_capacity = beautiful.battery5_span .. capacity .. "%" .. beautiful.close_span
      end
    elseif status == "Not charging" then
      icon = beautiful.battery5_span .. "󱉝 " .. beautiful.close_span
      color_capacity = beautiful.battery5_span .. capacity .. "%" .. beautiful.close_span
    elseif status == "Unknown" then
      icon = beautiful.battery5_span .. "󰂑 " .. beautiful.close_span
      color_capacity = beautiful.battery5_span .. capacity .. "%" .. beautiful.close_span
    else
      icon = ""
    end

    display_text = icon .. color_capacity
    awesome.emit_signal("laptop::battery", display_text)
  end)
end

return M

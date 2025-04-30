local awful = require("awful")
local vars = require("main.user_vars")

local config_path = vars.config_path
-- local home_path = vars.home_path

-- scripts
awful.spawn.with_shell("picom -b")
awful.spawn.with_shell(
  'feh --bg-fill "$HOME/Pictures/Wallpapers/wallpaper.jpg" --bg-fill "$HOME/Pictures/Wallpapers/wallpaper.jpg"')
awful.spawn.with_shell('xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8')
awful.spawn.with_shell('xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0')
awful.spawn.with_shell('xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50')
awful.spawn.with_shell("xsetroot -cursor_name left_ptr")
awful.spawn.with_shell('xss-lock -- i3lock -n -i "$HOME/Pictures/Wallpapers/lockscreen.png"')
awful.spawn.with_shell("xset s 900 900")

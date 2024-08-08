#!/usr/bin/env bash

# set the primary display - because it will be used no matter what
monitors=$(xrandr --listmonitors | awk '{print $4}' | uniq | grep -v '^$')
num_monitors=$(echo "$monitors" | wc -l)
primary_display=$(echo "$monitors" | dmenu -l $num_monitors -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "Select Primary Monitor:")

case "$(printf "Home Setup\nTwo-Display\nSingle-Display\n" | dmenu -l 10 -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "Display Setup:")" in
    "Home Setup") 
        xrandr --output "$primary_display" --primary
        xrandr --output eDP-1 --mode 1920x1080 --left-of "$primary_display"
        xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
    "Two-Display")
        # get the list of connected monitors
        monitors=$(xrandr --listmonitors | awk '{print $4}' | uniq | grep -v '^$')
        
        # check if there are at least two monitors
        num_monitors=$(echo "$monitors" | wc -l)
        if [ "$num_monitors" -lt 2 ]; then
            echo "At least two monitors are required for this option."
            exit 1
        fi

        # prompt user to select secondary monitors
        secondary_display=$(echo "$monitors" | grep -v "^$primary_display" | dmenu -l $num_monitors -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "Select Secondary Monitor:")

        # check if both displays were selected
        if [ -z "$primary_display" ] || [ -z "$secondary_display" ]; then
            echo "Both monitors must be selected."
            exit 1
        fi

        # might need to edit this to set --mode if becomes a hassle to change alot
        position=$(printf "Right\nLeft\nAbove\nBelow\n" | dmenu -l 4 -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "Secondary Monitor Position:")
        case "$position" in
            "Right") xrandr --output "$secondary_display" --auto --right-of "$primary_display" ;;
            "Left") xrandr --output "$secondary_display" --auto --left-of "$primary_display" ;;
            "Above") xrandr --output "$secondary_display" --auto --above "$primary_display" ;;
            "Below") xrandr --output "$secondary_display" --auto --below "$primary_display" ;;
            *) echo "Invalid position selected." ;;
        esac ;;
    "Single-Display")
        monitor_type=$(printf "Laptop\nHome\nOther\n" | dmenu -l 4 -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "Secondary Monitor Type:")
        case "$monitor_type" in
            "Laptop")
                echo "Laptop - set xrandr command here"
                # xrandr --output "$primary_display" --primary --mode 1920x1080
            ;;
            "Home")
                echo "Home - set xrandr command here"
                # xrandr --output "$primary_display" --primary --mode 1920x1080
            ;;
            "Other")
                echo "Other - set xrandr command here"
                # xrandr --output "$primary_display" --primary --mode 1920x1080
            ;;
            *) echo "Invalid monitor type selected." ;;
        esac ;;
    *) exit 1 ;;
esac

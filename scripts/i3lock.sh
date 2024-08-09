#!/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#000000'
TEXT='#000000'
WRONG='#67A86C'
VERIFYING='#67A86C'

i3lock-color \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--image ~/.local/bin/scripts/wallpapers/i3lock.png \
--screen 1                   \
--blur 5                     \
--clock                      \
--indicator                  \
--time-str="%H:%M"        \
--date-str="%A, %Y-%m-%d"    \
--tiling                     \

#!/usr/bin/env sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set $NAME icon="$(date '+%Y-%m-%d')" label="$(date '+%H:%M')" icon.font="Hack Nerd Font:Bold:14.0" icon.color=0xffcccccc


#!/usr/bin/env bash

update() {
  FLOATING="$(yabai -m query --windows --window | jq '.["is-floating"]')"  
  case "$FLOATING" in
    "false")
    sketchybar -m --set yabai_float label=""
    ;;
    "true")
    sketchybar -m --set yabai_float label=""
    ;;
  esac
}

click() {
  yabai -m window --toggle float
  sketchybar -m --trigger float_change
}

case "$SENDER" in
  "mouse.clicked") click
  ;;
  "routine"|"forced"|"float_change"|"front_app_switched") update
  ;;
esac
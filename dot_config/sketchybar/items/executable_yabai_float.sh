#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

sketchybar -m --add       item        yabai_float left \
              --add       event       window_focus \
              --add       event       float_change \
              --set       yabai_float script="$PLUGIN_DIR/yabai_float.sh" \
                                      label.font="Hack Nerd Font:Regular:16.0" \
                                      associated_display=active \
              --subscribe yabai_float front_app_switched window_focus float_change mouse.clicked

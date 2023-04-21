#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add slider status.volume right                          \
           --set status.volume script="$PLUGIN_DIR/volume.sh"        \
                        updates=on                            \
                        icon.drawing=off                      \
                        label.drawing=off                     \
                        padding_left=0                        \
                        padding_right=0                       \
                        slider.highlight_color=$BLUE          \
                        slider.background.height=5            \
                        slider.background.corner_radius=3     \
                        slider.background.color=$BACKGROUND_2 \
                        slider.knob=􀀁                         \
           --subscribe status.volume volume_change mouse.clicked

sketchybar --add alias "Control Center,Sound" right                      \
           --rename "Control Center,Sound" status.volume_alias                  \
           --set status.volume_alias icon.drawing=off                           \
                              label.drawing=off                          \
                              alias.color=$WHITE                         \
                              padding_right=0                            \
                              padding_left=-5                            \
                              width=50                                   \
                              align=right                                \
                              click_script="$PLUGIN_DIR/volume_click.sh"

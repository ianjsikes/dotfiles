#!/usr/bin/env sh

# WiFi
sketchybar --add alias  "Control Center,WiFi" right                      \
           --rename     "Control Center,WiFi" status.wifi_alias                 \
           --set        status.wifi_alias    icon.drawing=off                   \
                                      alias.color="$YELLOW"              \
                                      background.padding_right=0         \
                                      icon.padding_right=0               \
                                      align=right                        \
                                      click_script="$POPUP_CLICK_SCRIPT" \
                                      update_freq=1                      \
                                      script="$PLUGIN_DIR/wifi.sh"       \
           --subscribe  status.wifi_alias    mouse.entered                      \
                                      mouse.exited                       \
                                      mouse.exited.global                \
                                                                         \
            --add       item          wifi.details popup.status.wifi_alias      \
            --set       wifi.details  background.corner_radius=12        \
                                      background.padding_left=7          \
                                      background.padding_right=7         \
                                      icon.background.height=2           \
                                      icon.background.y_offset=-12       \
                                      click_script="sketchybar --set status.wifi_alias popup.drawing=off"

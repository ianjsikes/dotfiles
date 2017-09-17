local awful = require("awful")
local beautiful = require("beautiful")
local util = require("dsk.util")

local brightnessbar = require("dsk.notify_bar")

local brightness = {}
local defaults = { down=false, step=5 }

local function default_style()
  local style = {
    notify = {
      -- geometry        = { width = 36, height = 160 },
      -- screen_gap      = 20,
      -- set_position    = nil,
      -- border_margin   = { 5, 5, 5, 5 },
      -- elements_margin = { 10, 10, 10, 10 },
      -- bar_width       = 8,
      -- border_width    = 1,
      -- timeout         = 10.5,
      icon = os.getenv("HOME") .. "/.config/awesome/dsk/icons/brightness.png",
      color = { border = "#575757", background = "#202020", bar = "#f9ee1f" },
    },
  }
  -- Allow theme overriding style
  return util.merge(style, util.check(beautiful, "widget.brightness") or {})
end

function brightness.up(args)
  local args = util.merge(defaults, args or {})
  awful.spawn.easy_async("xbacklight -time 0 -steps 1 -inc " .. args.step, brightness.notify)
end

function brightness.down(args)
  local args = util.merge(defaults, args or {})
  awful.spawn.easy_async("xbacklight -time 0 -steps 1 -dec " .. args.step, brightness.notify)
end

function brightness.notify()
  if not brightness.style then brightness.style = default_style() end
  awful.spawn.easy_async("xbacklight -get", function (stdout)
    local brightness_level = tonumber(stdout)

    brightnessbar:show(util.merge(
      { value = brightness_level / 100 },
      brightness.style.notify
    ))
  end)
end

return brightness

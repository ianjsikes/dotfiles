local awful = require("awful")
local beautiful = require("beautiful")
local util = require("dsk.util")

local bar = require("dsk.notify_bar")

local volume = {}
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
      icon = os.getenv("HOME") .. "/.config/awesome/dsk/icons/volume.png",
      color = { border = "#575757", background = "#202020", bar = "#f9ee1f" },
    },
  }
  -- Allow theme overriding style
  return util.merge(style, util.check(beautiful, "widget.volume") or {})
end

function volume.up(args)
  local args = util.merge(defaults, args or {})
  awful.spawn.easy_async("amixer -D pulse sset Master " .. args.step .. "%+", volume.notify)
end

function volume.down(args)
  local args = util.merge(defaults, args or {})
  awful.spawn.easy_async("amixer -D pulse sset Master " .. args.step .. "%-", volume.notify)
end

function volume.notify(stdout)
  if not volume.style then volume.style = default_style() end
  local volume_level = tonumber(string.gsub(string.match(stdout, "%d%%"), "%%", ""))
  bar:show(util.merge(
    { value = volume_level / 100 },
    volume.style.notify
  ))
end

return volume

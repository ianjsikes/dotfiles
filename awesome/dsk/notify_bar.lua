----------------------------------------
-- notify_bar
--
-- A floating bar indicator with icon
--
-- Usage:
-- local bar = require("dsk.notify_bar")
-- bar:show({ value = 0.75 })
----------------------------------------

local unpack = unpack

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local color = require("gears.color")
local timer = require("gears.timer")

local util = require("dsk.util")
local placement = require("dsk.placement")
local progressbar = require("dsk.bar")

local notify_bar = {}

local function default_style()
	local style = {
		geometry        = { width = 36, height = 160 },
		screen_gap      = 20,
		set_position    = nil,
		border_margin   = { 5, 5, 5, 5 },
		elements_margin = { 10, 10, 10, 10 },
		bar_width       = 8,
		border_width    = 1,
		timeout         = 1.5,
		icon            = nil,
		progressbar     = { vertical = true, flip = true },
		color           = { border = "#575757", background = "#202020", bar = "#b1222b" }
	}
	return style
end

-- Initialize notify_bar widget
-----------------------------------------------------------------------------------------------------------------------
function notify_bar:init(args)

	local style = util.merge(default_style(), args or {})

	self.style = style

	-- Construct layouts
	--------------------------------------------------------------------------------
	local area = wibox.layout.align.vertical()

	local bar = progressbar(util.merge({color={main=style.color.bar, gray=style.color.border}}, style.progressbar))
  local image = wibox.widget.imagebox(style.icon)
	local text = wibox.widget.textbox("100%")

  area:set_top(image)
	area:set_bottom(wibox.container.margin(bar, unpack(style.elements_margin)))

	-- Create floating wibox for notify_bar widget
	--------------------------------------------------------------------------------
	self.wibox = wibox({
		ontop        = true,
		bg           = style.color.background,
		border_width = style.border_width,
		border_color = style.color.border
	})

	self.wibox:set_widget(wibox.container.margin(area, unpack(style.border_margin)))
	self.wibox:geometry(style.geometry)

	-- Set info function
	--------------------------------------------------------------------------------
	function self:set(args)
		local args = args or {}

		if args.value then
			bar:set_value(args.value)
		end

    image.image = args.icon ~= nil and args.icon or style.icon

    self.hidetimer.timeout = args.timeout ~= nil and args.timeout or style.timeout
	end

	-- Set autohide timer
	--------------------------------------------------------------------------------
	self.hidetimer = timer({ timeout = style.timeout })
	self.hidetimer:connect_signal("timeout", function() self:hide() end)

	-- Signals setup
	--------------------------------------------------------------------------------
	self.wibox:connect_signal("mouse::enter", function() self:hide() end)
end

-- Hide notify_bar widget
-----------------------------------------------------------------------------------------------------------------------
function notify_bar:hide()
	self.wibox.visible = false
	self.hidetimer:stop()
end

-- Show notify_bar widget
-----------------------------------------------------------------------------------------------------------------------
function notify_bar:show(args)
	if not self.wibox then self:init(args) end
	self:set(args)

	-- TODO: add placement update if active screen changed
	if not self.wibox.visible then
		if self.style.set_position then self.wibox:geometry(self.style.set_position()) end
		placement.no_offscreen(self.wibox, self.style.screen_gap, mouse.screen.workarea)
		self.wibox.visible = true
	end

	self.hidetimer:again()
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return notify_bar

-----------------------------------------------------------------------------------------------------------------------
--                                            RedFlat progressbar widget                                             --
-----------------------------------------------------------------------------------------------------------------------
-- Horizontal progresspar
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
-----------------------------------------------------------------------------------------------------------------------
local setmetatable = setmetatable
local wibox = require("wibox")
local beautiful = require("beautiful")
local color = require("gears.color")

local util = require("dsk.util")

-- Initialize tables for module
-----------------------------------------------------------------------------------------------------------------------
local progressbar = { mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		color = { main = "#b1222b", gray = "#404040" },
		vertical = false,
    flip = false,
	}
	return util.merge(style, util.check(beautiful, "gauge.graph.bar") or {})
 end

-- Create a new progressbar widget
-- @param style Table containing colors and geometry parameters for all elemets
-----------------------------------------------------------------------------------------------------------------------
function progressbar.new(style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	local style = util.merge(default_style(), style or {})

	-- updating values
	local data = {
		value = 0
	}

	-- Create custom widget
	--------------------------------------------------------------------------------
	local widg = wibox.widget.base.make_widget()

	-- User functions
	------------------------------------------------------------
	function widg:set_value(x)
		data.value = x < 1 and x or 1
		self:emit_signal("widget::updated")
	end

	-- Fit
	------------------------------------------------------------
	function widg:fit(context, width, height)
		return width, height
	end

	-- Draw
	------------------------------------------------------------
	function widg:draw(context, cr, width, height)
		cr:set_source(color(style.color.gray))
		cr:rectangle(0, 0, width, height)
		cr:fill()
		cr:set_source(color(style.color.main))

    if style.flip then
      if style.vertical then
        cr:rectangle(0, height - data.value * height, width, height)
      else
        cr:rectangle(width - data.value * width, 0, width, height)
      end
    else
      if style.vertical then
        cr:rectangle(0, 0, width, data.value * height)
      else
        cr:rectangle(0, 0, data.value * width, height)
      end
    end

		cr:fill()
	end

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call progressbar module as function
-----------------------------------------------------------------------------------------------------------------------
function progressbar.mt:__call(...)
	return progressbar.new(...)
end

return setmetatable(progressbar, progressbar.mt)

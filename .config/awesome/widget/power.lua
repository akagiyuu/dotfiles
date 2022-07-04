--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("themes.colorschemes.extent")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local hover_signal = require("util.signal").hover_signal

-- Icon directory path
local icondir = Paths.icon .. "others/"

local power_widget = wibox.widget {
    {
        {
            {
                {
                    {
                        id = "icon",
                        image = gears.color.recolor_image(icondir .. "power.svg", color["Grey900"]),
                        widget = wibox.widget.imagebox,
                        resize = false
                    },
                    id = "icon_layout",
                    widget = wibox.container.place
                },
                id = "icon_margin",
                top = dpi(2),
                widget = wibox.container.margin
            },
            id = "power_layout",
            layout = wibox.layout.fixed.horizontal
        },
        id = "container",
        left = dpi(4),
        right = dpi(4),
        widget = wibox.container.margin
    },
    bg = color["Red200"],
    fg = color["Grey800"],
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.corner_radius)
    end,
    widget = wibox.container.background
}

-- Signals
hover_signal(power_widget, color["Red200"], color["Grey900"])

power_widget:connect_signal(
    "button::release",
    function()
        awesome.emit_signal("module::powermenu:show")
    end
)

return power_widget

local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
local create_button = function(name, icon, bg_color, callback)
    local item = wibox.widget {
        {
            {
                {
                    {
                        {
                            -- TODO: using gears.color to recolor a SVG will make it look super low res
                            -- currently I recolor it in the .svg file directly, but later implement
                            -- a better way to recolor a SVG
                            -- image = gears.color.recolor_image(icon, color["Grey900"]),
                            image = icon,
                            resize = true,
                            forced_height = dpi(30),
                            widget = wibox.widget.imagebox
                        },
                        margins = dpi(0),
                        widget = wibox.container.margin
                    },
                    {
                        {
                            text = name,
                            font = "Cascadia Code Bold 30",
                            widget = wibox.widget.textbox
                        },
                        margins = dpi(0),
                        widget = wibox.container.margin
                    },
                    widget = wibox.layout.fixed.horizontal
                },
                margins = dpi(10),
                widget = wibox.container.margin
            },
            fg = "#212121",
            bg = bg_color,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            widget = wibox.container.background,
            id = 'background'
        },
        spacing = dpi(0),
        layout = wibox.layout.align.vertical
    }

    item:connect_signal(
        "button::release",
        function()
            callback()
        end
    )

    return item
end
return create_button
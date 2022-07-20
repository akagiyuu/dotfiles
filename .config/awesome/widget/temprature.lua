-- ## Temprature ##
-- ~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local temprature = wibox.widget.textbox()
temprature.font = beautiful.font

watch('bash -c "sensors | awk \'/Core 0/ {print substr($3, 2) }\'"', 30, function(_, stdout)
    temprature.text = stdout
end)

--return temprature
local temprature_icon = wibox.widget {
	markup = '<span font="' .. beautiful.icon_font .. '"> </span>',
	widget = wibox.widget.textbox,
}
return wibox.widget {
	wibox.widget{
		temprature_icon,
		fg = colors.brightred,
		widget = wibox.container.background
	},
    wibox.widget{
        temprature,
        fg = colors.brightred,
        widget = wibox.container.background
    },
    spacing = dpi(2),
    layout = wibox.layout.fixed.horizontal
}

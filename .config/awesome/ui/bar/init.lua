local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local barcontainer = require("widget.barcontainer")
local clock_widget = require('widget.clock')
local mem_widget = require('widget.memory')
local cpu_widget = require('widget.cpu-gragh') {}
local temprature_widget = require('widget.temprature')
local updates_widget = require('widget.updates')
local fs_widget = require('widget.fs-widget') { mounts = { '/', '/home' } }
local powerbutton = require('widget.power')
local network = require('widget.net_speed') {}
local quake = require('modules.quake')


awful.screen.connect_for_each_screen(function(screen)
    screen.quake = quake {
        app = "kitty",
        argname = '--class %s',
        height = 0.4,
        screen = screen
    }
    screen.promptbox = awful.widget.prompt()
    screen.notification_center = require("ui.notification_center")(screen)
    screen.layoutbox = wibox.widget {
        {
            screen = screen,
            visible = true,
            buttons = {
                awful.button({}, 1, function() awful.layout.inc(1) end),
                awful.button({ mod }, 1, function() awful.layout.inc(-1) end),
            },
            widget = awful.widget.layoutbox,
        },
        margins = dpi(7),
        widget = wibox.container.margin,
    }
    screen.taglist = require('ui.bar.taglist')(screen)
    screen.tasklist = require('ui.bar.tasklist')(screen)
    screen.systray = require('widget.systray')
    require("ui.powermenu")(screen)

    screen.wibar = awful.wibar {
        position = "top",
        type = "dock",
        ontop = false,
        stretch = false,
        visible = true,
        height = dpi(35),
        width = screen.geometry.width - dpi(20),
        screen = screen,
        bg = colors.transparent,
    }
    awful.placement.top(screen.wibar, { margins = beautiful.useless_gap * 2 })
    screen.wibar:struts { top = dpi(50) }

    screen.wibar:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                {
                    powerbutton,
                    screen.taglist,
                    {
                        screen.tasklist,
                        right = 15,
                        widget = wibox.container.margin
                    },
                    spacing = dpi(10),
                    bg = colors.black,
                    layout = wibox.layout.fixed.horizontal,
                },
                bg = colors.black,
                shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius) end,
                widget = wibox.container.background,
            },
            {
                {
                    {
                        clock_widget,
                        left = 20,
                        right = 20,
                        widget = wibox.container.margin
                    },
                    bg = colors.black,
                    layout = wibox.layout.align.horizontal,
                },
                bg = colors.black,
                shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius) end,
                widget = wibox.container.background,
            },
            {
                {
                    {
                        barcontainer(updates_widget),
                        left = 15,
                        widget = wibox.container.margin
                    },
                    barcontainer(cpu_widget),
                    barcontainer(mem_widget),
                    barcontainer(fs_widget),
                    barcontainer(network),
                    barcontainer(temprature_widget),
                    screen.systray,
                    screen.layoutbox,
                    {
                        screen.notification_center,
                        right = 15,
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                bg = colors.black,
                shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius) end,
                widget = wibox.container.background,
            }
        },
        -- left = beautiful.useless_gap,
        -- right = beautiful.useless_gap,
        widget = wibox.container.margin,
    }

end)

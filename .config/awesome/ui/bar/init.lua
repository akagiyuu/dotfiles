local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato = require("modules.rubato")
local clickable_container = require('widget.clickable-container')

local barcontainer = require("widget.barcontainer")

-- Tags
-- awful.util.tagnames =  { "1", "2" , "3", "4", "5", "6", "7", "8", "9" }
-- awful.util.tagnames =  { "", " ", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "dev",  "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx" }
-- awful.util.tagnames =  { "", "", " ", "","", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
awful.util.tagnames = { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames = { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", ""}

-- Pacman Taglist :
-- awful.util.tagnames = {"●", "●", "●", "●", "●", "●", "●", "●", "●", "●"}
-- awful.util.tagnames = {"", "", "", "", "", "", "", "", "", ""}
-- awful.util.tagnames = {"•", "•", "•", "•", "•", "•", "•", "•", "•", "•"}
-- awful.util.tagnames = { "", "", "", "", "", "", "", "", "", "" }
-- awful.util.tagnames =  { "", "", "", "", "", "", "", "", "",  "" }

local clock_widget = require('widget.clock')
-- local keyboardlayout_widget = require('widget.keyboardlayout')
local mem_widget = require('widget.memory')
local cpu_widget = require('widget.cpu-gragh')
local temprature_widget = require('widget.temprature')
local updates_widget = require('widget.updates')
local fs_widget = require('widget.fs-widget')({ mounts = { '/', '/home' } })
local powerbutton = require("widget.power")


awful.screen.connect_for_each_screen(function(screen)

    awful.tag(awful.util.tagnames, screen, awful.layout.layouts[1])
    screen.mypromptbox = awful.widget.prompt()
    local launcher = wibox.container.margin(launcher, dpi(0), dpi(0), dpi(4), dpi(4))

    screen.layoutbox = awful.widget.layoutbox {
        screen = screen,
        visible = true,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
        }
    }
    screen.layoutbox = wibox.container.margin(screen.layoutbox, dpi(7), dpi(7), dpi(7), dpi(7))

    screen.taglist = require("ui.bar.taglist")(screen)

    screen.tasklist = awful.widget.tasklist {
        screen = screen,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(1) end),
        },
        style = {
            border_width = 1,
            border_color = colors.black,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
            end,
            bg_minimize = colors.black,
            bg_normal = colors.brightblack,
            bg_focus = colors.brightblack,
        },
        layout = {
            spacing = 6,
            spacing_widget = {
                {
                    forced_width = 0,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            nil,
            {
                awful.widget.clienticon,
                margins = 5,
                widget  = wibox.container.margin
            },
            {
                wibox.widget.base.make_widget(),
                forced_height = 5,
                id            = "background_role",
                widget        = wibox.container.background,
            },
            layout = wibox.layout.align.vertical,
        },
    }

    screen.systray = wibox.widget {
        visible = false,
        base_size = dpi(24),
        horizontal = true,
        screen = 'primary',
        widget = wibox.widget.systray
    }
    screen.tray_toggler = require('widget.tray-toggle')

    screen.wibar = awful.wibar({
        position = "top",
        type = "dock",
        ontop = false,
        stretch = false,
        visible = true,
        height = dpi(35),
        width = screen.geometry.width - dpi(20),
        screen = screen,
        bg = colors.transparent,
    })

    awful.placement.top(screen.wibar, { margins = beautiful.useless_gap * 2 })
    screen.wibar:struts({
        top = dpi(50),
    })

    require("ui.powermenu")(screen)
    screen.wibar:setup({
        {
            {
                layout = wibox.layout.align.horizontal,
                expand = "none",
                {
                    launcher,
                    screen.taglist,
                    screen.tasklist,
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    barcontainer(clock_widget),
                    layout = wibox.layout.align.horizontal,
                },
                {
                    barcontainer(updates_widget),
                    barcontainer(temprature_widget),
                    barcontainer(cpu_widget),
                    barcontainer(mem_widget),
                    barcontainer(fs_widget),
                    -- barcontainer(keyboardlayout_widget),
                    {
                        screen.systray,
                        margins = dpi(4),
                        widget = wibox.container.margin,
                    },
                    screen.tray_toggler,
                    screen.layoutbox,
                    {
                        powerbutton,
                        margins = dpi(4),
                        widget = wibox.container.margin,
                    },

                    layout = wibox.layout.fixed.horizontal,
                },
            },
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin,
        },
        bg = colors.black,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius) end,
        widget = wibox.container.background,
    })

    -- local widebox_timed = rubato.timed {
    --     intro = 0.1,
    --     duration = 0.3,
    --     easing = rubato.bouncy,
    --     subscribed = function(pos)
    --         screen.wibar.x = pos - dpi(95)
    --     end
    -- }

    -- mem_widget:connect_signal("button::press", function()
    --     widebox_timed.target = dpi(125)
    --     screen.wibar.x = dpi(30)
    -- end)
end)

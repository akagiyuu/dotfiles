local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local rubato = require('modules.rubato')
local color = require('modules.color')

local normal = color.color({ hex = beautiful.border_normal })
local focus = color.color({ hex = beautiful.border_focus} )
local transition = color.transition(normal, focus, 0)

return function(screen)
    return awful.widget.tasklist {
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
            -- shape = function(cr, w, h)
            --     gears.shape.rounded_rect(cr, w, h, beautiful.corner_radius)
            -- end,
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
                bottom  = 3,
                top     = 5,
                left    = 5,
                right   = 3,
                opacity = 1,
                id      = 'clienticon',
                widget  = wibox.container.margin
            },
            {
                forced_height = 4,
                bg            = beautiful.border_normal,
                shape         = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 2)
                end,
                id            = "background",
                widget        = wibox.container.background,
            },
            create_callback = function(self)
                self.icon_animation = rubato.timed {
                    pos = 1,
                    intro = 0.1,
                    duration = 0.5,
                    subscribed = function(pos)
                        self:get_children_by_id("clienticon")[1].opacity = pos
                    end
                }
                self.indicator_animation = rubato.timed {
                    intro = 0.1,
                    duration = 0.5,
                    subscribed = function(pos)
                        self:get_children_by_id("background")[1].bg = transition(pos).hex
                    end
                }
            end,
            update_callback = function(self, c, _, _)
                if c.active then
                    self.icon_animation.target = 1
                    self.indicator_animation.target = 1
                elseif c.minimized then
                    self:get_children_by_id("background")[1].bg = colors.transparent
                else
                    self.icon_animation.target = 0.7
                    self.indicator_animation.target = 0
                end
            end,
            layout = wibox.layout.align.vertical,
        },
    }
end
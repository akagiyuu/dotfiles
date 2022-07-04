local awful = require("awful")
local color = require("themes.colorschemes.extent")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local hover_signal = require("util.signal").hover_signal
local button = require("widget.button")

local icondir = Paths.icon .. "powermenu/"

local update_user_name = function(profile)
    awful.spawn.easy_async_with_shell(
        "./.config/awesome/scripts/uname.sh " .. "full",
        function(stdout)
            profile.picture:set_image(awful.util.getdir("config") .. "assets/avatars/" .. "rickastley.jpg")
            profile.name:set_text(stdout)
        end
    )
end

local profile = {
    picture = wibox.widget {
        -- image = icondir .. "defaultpfp.svg",
        resize = true,
        forced_height = dpi(200),
        clip_shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 30)
        end,
        widget = wibox.widget.imagebox
    },
    name = wibox.widget {
        align = 'center',
        valign = 'center',
        text = " ",
        font = "Cascadia Code Italic 30",
        widget = wibox.widget.textbox
    }
}

local suspend_command = function()
    awful.spawn("systemctl suspend")
    awesome.emit_signal("module::powermenu:hide")
end

local logout_command = function()
    awesome.quit()
end

local lock_command = function()
    awful.spawn(Paths.home .."/Scripts/lock")
    awesome.emit_signal("module::powermenu:hide")
end

local shutdown_command = function()
    awful.spawn("shutdown")
    awesome.emit_signal("module::powermenu:hide")
end

local reboot_command = function()
    awful.spawn("reboot")
    awesome.emit_signal("module::powermenu:hide")
end


local shutdown_button = button("Shutdown", icondir .. "shutdown.svg", color["Blue200"], shutdown_command)
local reboot_button = button("Reboot", icondir .. "reboot.svg", color["Red200"], reboot_command)
local suspend_button = button("Suspend", icondir .. "suspend.svg", color["Yellow200"], suspend_command)
local logout_button = button("Logout", icondir .. "logout.svg", color["Green200"], logout_command)
local lock_button = button("Lock", icondir .. "lock.svg", color["Orange200"], lock_command)

hover_signal(shutdown_button.background, color["Blue200"], color["Grey900"])
hover_signal(reboot_button.background, color["Red200"], color["Grey900"])
hover_signal(suspend_button.background, color["Yellow200"], color["Grey900"])
hover_signal(logout_button.background, color["Green200"], color["Grey900"])
hover_signal(lock_button.background, color["Orange200"], color["Grey900"])

local create_powermenu_screen = function(screen)
    update_user_name(profile)

    local powermenu = wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = "none",
        nil,
        {
            {
                nil,
                {
                    {
                        nil,
                        {
                            nil,
                            {
                                profile.picture,
                                margins = dpi(0),
                                widget = wibox.container.margin
                            },
                            nil,
                            expand = "none",
                            layout = wibox.layout.align.horizontal
                        },
                        nil,
                        layout = wibox.layout.align.vertical,
                        expand = "none"
                    },
                    spacing = dpi(50),
                    {
                        profile.name,
                        margins = dpi(0),
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.vertical
                },
                nil,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            {
                nil,
                {
                    {
                        shutdown_button,
                        reboot_button,
                        logout_button,
                        lock_button,
                        suspend_button,
                        spacing = dpi(30),
                        layout = wibox.layout.fixed.horizontal
                    },
                    margins = dpi(0),
                    widget = wibox.container.margin
                },
                nil,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.align.vertical
        },
        nil
    }
    -- Covers the entire screen
    local powermenu_container = wibox {
        widget = powermenu,
        screen = screen,
        type = "splash",
        visible = false,
        ontop = true,
        bg = "#21212188",
        height = screen.geometry.height,
        width = screen.geometry.width,
        x = screen.geometry.x,
        y = screen.geometry.y
    }


    -- Close on Escape
    local powermenu_keygrabber = awful.keygrabber {
        autostart = false,
        stop_event = 'release',
        keypressed_callback = function(self, mod, key, command)
            if key == 'Escape' then
                awesome.emit_signal("module::powermenu:hide")
            end
        end
    }


    -- Close on rightclick
    powermenu_container:buttons(gears.table.join(
        awful.button(
            {}, 3,
            function() awesome.emit_signal("module::powermenu:hide") end
        )
    ))

    awesome.connect_signal(
        "module::powermenu:show",
        function()
            if screen == mouse.screen then
                powermenu_container.visible = true
                powermenu_keygrabber:start()
            end
        end
    )

    awesome.connect_signal(
        "module::powermenu:hide",
        function()
            powermenu_keygrabber:stop()
            powermenu_container.visible = false
        end
    )
end

return create_powermenu_screen
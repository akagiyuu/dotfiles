local awful         = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local rubato        = require("modules.rubato")


awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.mod }, "s",
        hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }
    ),

    awful.key(
        { Keys.mod }, "w",
        function() awful.spawn("jgmenu") end,
        { description = "show main menu", group = "awesome" }
    ),
    awful.key(
        { Keys.mod, Keys.ctrl }, "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key(
        { Keys.mod, Keys.shift }, "q",
        awesome.quit,
        { description = "quit awesome", group = "awesome" }
    ),
    awful.key(
        { Keys.mod }, "Escape",
        function() awesome.emit_signal("module::powermenu:show") end,
        { description = "show exit menu", group = "awesome" }
    ),

    awful.key(
        { Keys.mod }, "Return",
        function() awful.spawn(Terminal) end,
        { description = "open a terminal", group = "launcher" }
    ),

    awful.key(
        { Keys.ctrl, Keys.shift }, "r",
        function() awful.spawn("xdotool click 3") end,
        { description = "Right click", group = "launcher" }
    ),
    awful.key(
        { Keys.mod }, "Tab",
        function() awesome.emit_signal("bling::window_switcher::turn_on") end,
        { description = "Window Switcher", group = "launcher" }
    ),

    awful.key(
        { Keys.mod }, ".",
        function() awful.spawn("rofimoji") end,
        { description = "Emoji picker", group = "launcher" }
    )
}

awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.mod }, "Left",
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),

    awful.key(
        { Keys.mod }, "Right",
        awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),

    awful.key(
        { Keys.mod }, "Escape",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
}

-- Focus related keybindings
awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.mod, }, "j",
        function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }
    ),

    awful.key(
        { Keys.mod, }, "k",
        function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }
    ),

    awful.key(
        { Keys.mod, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }
    ),

    awful.key(
        { Keys.mod, Keys.ctrl }, "j",
        function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }
    ),

    awful.key(
        { Keys.mod, Keys.ctrl }, "k",
        function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }
    ),

    awful.key(
        { Keys.mod, Keys.ctrl }, "n",
        function()
            local c = awful.client.restore()
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        { description = "restore minimized", group = "client" }
    )
}

awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.mod, Keys.shift }, "j",
        function() awful.client.swap.bydirection("down") end,
        { description = "swap with next client by index", group = "client" }
    ),

    awful.key(
        { Keys.mod, Keys.shift }, "k",
        function() awful.client.swap.bydirection("up") end,
        { description = "swap with previous client by index", group = "client" }
    ),
    awful.key(
        { Keys.mod, Keys.shift }, "h",
        function() awful.client.swap.bydirection("left") end,
        { description = "swap with previous client by index", group = "client" }
    ),
    awful.key(
        { Keys.mod, Keys.shift }, "l",
        function() awful.client.swap.bydirection("right") end,
        { description = "swap with previous client by index", group = "client" }
    ),

    awful.key(
        { Keys.mod, }, "l",
        function()
            -- local widebox_timed = rubato.timed {
            --     intro = 0.1,
            --     rate = 10000,
            --     duration = 0.2,
            --     easing = rubato.bouncy,
            --     subscribed = function(shift)
            --         awful.tag.incmwfact(shift)
            --     end
            -- }
            -- widebox_timed.target = 0.005
            awful.tag.incmwfact(0.05)
        end,
        { description = "increase master width factor", group = "layout" }
    ),

    awful.key(
        { Keys.mod, }, "h",
        function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }
    ),

    awful.key(
        { Keys.mod, Keys.ctrl }, "h",
        function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }
    ),

    awful.key(
        { Keys.mod, Keys.ctrl }, "l",
        function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }
    ),

    awful.key(
        { Keys.mod, }, "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),

    awful.key(
        { Keys.mod, }, "space",
        function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }
    ),

    awful.key(
        { Keys.mod, Keys.shift }, "space",
        function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }
    ),
}

awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers   = { Keys.mod },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { Keys.mod, Keys.ctrl },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers   = { Keys.mod, Keys.shift },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { Keys.mod, Keys.ctrl, Keys.shift },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { Keys.mod },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
}

awful.keyboard.append_global_keybindings {
    awful.key(
        {}, "XF86AudioLowerVolume",
        function() awful.util.spawn("pamixer -d 5", false) end
    ),

    awful.key(
        {}, "XF86AudioRaiseVolume",
        function() awful.util.spawn("pamixer -i 5", false) end
    ),

    awful.key(
        {}, "XF86AudioMute",
        function() awful.util.spawn("pamixer -t", false) end
    ),
}

awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.ctrl, Keys.shift }, "f",
        function() awful.spawn(string.format("pcmanfm")) end,
        { description = "File Manager", group = "launcher" }
    ),

    awful.key(
        { Keys.mod }, "p",
        function() awful.spawn(Paths.home .. "/.config/rofi/bin/launcher_misc") end,
        { description = "Apps", group = "launcher" }
    ),

    awful.key(
        { Keys.mod }, "b",
        function() awful.spawn(string.format("chromium")) end,
        { description = "Browser", group = "launcher" }
    ),

    awful.key({}, "Print",
        function() awful.util.spawn("/home/yuu/Scripts/screenshot") end,
        { description = "Fullscreen", group = "Screenshot" }
    ),
    awful.key({ Keys.mod }, "Print",
        function() awful.util.spawn("/home/yuu/Scripts/screenshot -s") end,
        { description = "Area", group = "Screenshot" }
    ),
    awful.key({ Keys.mod, Keys.ctrl }, "Print",
        function() awful.util.spawn("/home/yuu/Scripts/rofi-screenshot") end,
        { description = "Menu", group = "Screenshot" }
    ),

    awful.key({ Keys.mod }, "y", awful.placement.centered)
}

awful.keyboard.append_global_keybindings {
    awful.key(
        { Keys.mod }, "=",
        function()
            awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end,
        { description = "Toggle systray visibility", group = "custom" }
    )
}

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key(
            { Keys.mod, }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            { description = "toggle fullscreen", group = "client" }
        ),
        awful.key(
            { Keys.mod, "Shift" }, "c",
            function(c) c:kill() end,
            { description = "close", group = "client" }
        ),
        awful.key(
            { Keys.mod, "Control" },
            "space", awful.client.floating.toggle,
            { description = "toggle floating", group = "client" }
        ),
        awful.key(
            { Keys.mod, "Control" }, "Return",
            function(c) c:swap(awful.client.getmaster()) end,
            { description = "move to master", group = "client" }
        ),
        awful.key(
            { Keys.mod }, "o",
            function(c) c:move_to_screen() end,
            { description = "move to screen", group = "client" }
        ),
        awful.key(
            { Keys.mod }, "t",
            function(c) c.ontop = not c.ontop end,
            { description = "toggle keep on top", group = "client" }
        ),
        awful.key(
            { Keys.mod, }, "n",
            function(c) c.minimized = true end,
            { description = "minimize", group = "client" }
        ),
        awful.key({ Keys.mod, }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            { description = "(un)maximize", group = "client" }
        ),
        awful.key(
            { Keys.mod, Keys.ctrl }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            { description = "(un)maximize vertically", group = "client" }
        ),
        awful.key(
            { Keys.mod, Keys.shift }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            { description = "(un)maximize horizontally", group = "client" }
        ),
    }
end)

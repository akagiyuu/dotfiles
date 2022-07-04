local menubar = require("menubar")
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup')
local app_icon = Paths.app_icon


local awesome_menu = {
	{ "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Manual", Terminal .. " -e man awesome" },
	{ "Edit config", EditorCmd .. " " .. awesome.conffile },
	{ "Restart", awesome.restart },
	{ "Quit", function() awesome.quit() end },
}
local tools = {
	{ "Pavucontrol", 'pavucontrol', app_icon .. 'yast-sound.svg' },
	{ "Htop", 'kitty -e htop', app_icon .. 'htop.svg' },
}

local applications = {
	{ "Chromium", 'chromium', app_icon .. 'chromium.svg' },
	{ "File Manager", 'pcmanfm', app_icon .. 'system-file-manager.svg' },
	{ "Code Editor", 'vscodium', app_icon .. 'code.svg' },
}


local powermenu = {
	{ "Lock", function() awful.spawn.with_shell('notify-send "👉 Locking system " && sleep 1 && slock') end, app_icon .. 'system-lock-screen.svg' },
	{ "Logout", function() awful.spawn.with_shell('notify-send "👉 Loging out " && sleep 1 && loginctl terminate-session ${XDG_SESSION_ID-}') end, app_icon .. 'system-log-out.svg' },
	{ "Suspend", function() awful.spawn.with_shell('notify-send "👉 Suspending 鈴" && sleep 1 && systemctl suspend') end, app_icon .. 'system-suspend.svg' },
	{ "Hibernate", function() awful.spawn.with_shell('notify-send "👉 Hibernateing " && sleep 1 && systemctl hibernate') end, app_icon .. 'system-hibernate.svg' },
	{ "Reboot", function() awful.spawn.with_shell('notify-send "👉 Rebooting " && sleep 1 && reboot') end, app_icon .. 'system-reboot.svg' },
	{ "Poweroff", function() awful.spawn.with_shell('notify-send "👉 Powering Off " && sleep 1 && poweroff') end, app_icon .. 'system-shutdown.svg' },
}

_G.menu = awful.menu({
	items = {
		{ "Awesome", awesome_menu, beautiful.awesome_icon },
		{ "Applications", applications, app_icon .. 'apper.svg' },
		{ "Tools", tools, app_icon .. 'tools-wizard.svg' },
		{ "open terminal", Terminal, app_icon .. 'terminal.svg' },
		{ "Power Menu", powermenu, app_icon .. 'preferences-system-power.svg' }
	}
})

menubar.utils.terminal = Terminal

_G.launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = menu
})


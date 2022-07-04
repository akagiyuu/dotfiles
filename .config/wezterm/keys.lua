local map = require('utils').map
local wezterm = require "wezterm"
local action = wezterm.action
-- local act_callback = wezterm.action_callback

local config = {
    map({ "ctrl", "shift" }, "p", "ShowLauncher"),

    map("ctrl", "Tab", action { ActivateTabRelative = 1 }),
    map({ "ctrl", "shift" }, "w", action { CloseCurrentTab = { confirm = false } }),

    map({ "super", "alt" }, "x", action { SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    map({ "super", "alt" }, "v", action { SplitVertical = { domain = "CurrentPaneDomain" } }),
    map({ "super", "alt" }, "c", action { CloseCurrentPane = { confirm = true } }),

    map("ctrl", "Space", action { SendString="\x1B[32;5u" }),
}

return config

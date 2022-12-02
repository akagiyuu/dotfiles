local wezterm = require('wezterm')
local utils = require('utils')
--[]
local config = {
    color_scheme = 'Catppuccin Mocha',
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.9,
    colors = {
        background = 'black',
    },
    font = wezterm.font_with_fallback {
        {
            family = 'Cascadia Code PL',
            harfbuzz_features = { 'ss01', 'ss02', 'ss20' },
        },
        'Symbols Nerd Font',
        'nonicons'
    },
    font_size = 11,
    default_cursor_style = 'BlinkingBar',
    window_close_confirmation = "NeverPrompt",
    enable_scroll_bar = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
}

config.keys = require('keys')
config.mouse_bindings = require('mouse_bindings')

return config

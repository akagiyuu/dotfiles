local wezterm = require('wezterm')
require('ui.tab').normal()

return {
    enable_wayland = true,
    check_for_updates = false,
    front_end = "OpenGL",
    window_background_opacity = 0.9,
    window_close_confirmation = "NeverPrompt",
    term = 'wezterm',

    color_scheme = 'carbonfox',
    colors = { background = 'none' },
    bold_brightens_ansi_colors = true,

    font = wezterm.font_with_fallback {
        {
            family = 'Cascadia Code PL',
            harfbuzz_features = { 'ss01', 'ss02', 'ss20' },
        },
        'Symbols Nerd Font',
        'nonicons'
    },
    font_size = 11,
    line_height = 1.3,
    allow_square_glyphs_to_overflow_width = "Always",
    custom_block_glyphs = true,

    default_cursor_style = 'BlinkingBar',
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",

    enable_scroll_bar = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    hide_tab_bar_if_only_one_tab = true,
    underline_position = "185%",
    detect_password_input = true,
    unicode_version = 14,

    keys = require('keys'),
    mouse_bindings = require('mouse_bindings'),
}

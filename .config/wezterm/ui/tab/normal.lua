local wezterm = require('wezterm')
local colorscheme = require('colorscheme')

local get_process = function(tab)
    local process_icons = {
        ["docker"] = {
            { Foreground = { Color = colorscheme.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["docker-compose"] = {
            { Foreground = { Color = colorscheme.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["nvim"] = {
            { Foreground = { Color = colorscheme.green } },
            { Text = wezterm.nerdfonts.custom_vim },
        },
        ["vim"] = {
            { Foreground = { Color = colorscheme.green } },
            { Text = wezterm.nerdfonts.dev_vim },
        },
        ["node"] = {
            { Foreground = { Color = colorscheme.green } },
            { Text = wezterm.nerdfonts.mdi_hexagon },
        },
        ["zsh"] = {
            { Foreground = { Color = colorscheme.peach } },
            { Text = wezterm.nerdfonts.dev_terminal },
        },
        ["bash"] = {
            { Foreground = { Color = colorscheme.subtext0 } },
            { Text = wezterm.nerdfonts.cod_terminal_bash },
        },
        ["paru"] = {
            { Foreground = { Color = colorscheme.lavender } },
            { Text = wezterm.nerdfonts.linux_archlinux },
        },
        ["htop"] = {
            { Foreground = { Color = colorscheme.yellow } },
            { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
        },
        ["cargo"] = {
            { Foreground = { Color = colorscheme.peach } },
            { Text = wezterm.nerdfonts.dev_rust },
        },
        ["go"] = {
            { Foreground = { Color = colorscheme.sapphire } },
            { Text = wezterm.nerdfonts.mdi_language_go },
        },
        ["lazydocker"] = {
            { Foreground = { Color = colorscheme.blue } },
            { Text = wezterm.nerdfonts.linux_docker },
        },
        ["git"] = {
            { Foreground = { Color = colorscheme.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lazygit"] = {
            { Foreground = { Color = colorscheme.peach } },
            { Text = wezterm.nerdfonts.dev_git },
        },
        ["lua"] = {
            { Foreground = { Color = colorscheme.blue } },
            { Text = wezterm.nerdfonts.seti_lua },
        },
        ["wget"] = {
            { Foreground = { Color = colorscheme.yellow } },
            { Text = wezterm.nerdfonts.mdi_arrow_down_box },
        },
        ["curl"] = {
            { Foreground = { Color = colorscheme.yellow } },
            { Text = wezterm.nerdfonts.mdi_flattr },
        },
        ["gh"] = {
            { Foreground = { Color = colorscheme.mauve } },
            { Text = wezterm.nerdfonts.dev_github_badge },
        },
    }

    local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

    return wezterm.format(
        process_icons[process_name]
        or { { Foreground = { Color = colorscheme.sky } }, { Text = string.format("[%s]", process_name) } }
    )
end

local get_current_working_dir = function(tab)
    local current_dir = tab.active_pane.current_working_dir
    local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

    return current_dir == HOME_DIR and "  ~"
        or string.format("  %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

return function()
    wezterm.on("format-tab-title", function(tab)
        return wezterm.format({
            { Attribute = { Intensity = "Half" } },
            { Text = string.format(" %s  ", tab.tab_index + 1) },
            "ResetAttributes",
            { Text = get_process(tab) },
            { Text = " " },
            { Text = get_current_working_dir(tab) },
            { Foreground = { Color = colorscheme.base } },
            { Text = "  ▕" },
        })
    end)
end

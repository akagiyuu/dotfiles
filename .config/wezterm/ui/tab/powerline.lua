local wezterm = require 'wezterm';

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

return function()
    wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local edge_background = "#333333"
        local background = "#666666"
        local foreground = "#eaeaea"

        if tab.is_active then
            background = "#7aa6da"
            foreground = "#ffffff"
        elseif hover then
            background = "#7aa6da"
            foreground = "#aaaaaa"
        end

        local edge_foreground = background

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        local title = tab.active_pane.title .. ' '
        local hostname = wezterm.hostname()
        -- emit current host
        local has_hostname = title:find(hostname)
        if has_hostname ~= nil then
            x, y = has_hostname
            title = wezterm.truncate_left(title, title:len() - x - hostname:len() - 1)
        end
        if string.len(title) + string.len(tab.tab_index) > max_width then
            title = wezterm.truncate_right(title, max_width - 5) .. "…"
        end

        return {
            { Background = { Color = edge_foreground } },
            { Foreground = { Color = edge_background } },
            { Text = SOLID_RIGHT_ARROW .. (tab.tab_index + 1) },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end)
end

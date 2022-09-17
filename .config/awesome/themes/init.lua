local beautiful   = require("beautiful")
local colorscheme = require("themes.colorschemes")
local titlebar    = require("themes.titlebar")

local M = {}

---Init theme settings.
---@param options table
M.init = function(options)
    options = options or {}

    colorscheme.init(options.accent)

    local theme = require("themes.default")

    colorscheme.set_focus_colors(theme, colors[options.focus_color])
    titlebar.init(theme, options.titlebar_theme)

    for key, value in pairs(options) do
        theme[key] = value
    end

    beautiful.init(theme)
end

return M

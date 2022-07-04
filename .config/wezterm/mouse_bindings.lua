local mouse_binding = require("utils").mouse_binding

local config = {
    mouse_binding("ctrl", "Left", "Up", 1, "OpenLinkAtMouseCursor"),
    mouse_binding("ctrl", "Left", "Down",1, "Nop"),
}

return config
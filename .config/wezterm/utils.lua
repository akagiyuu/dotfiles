local M = {}

local is_table = function(table)
    return type(table) == 'table'
end

M.merge = function(...)
    local result = {}

    for _, table in ipairs({ ... }) do
        for key, value in pairs(table) do
            result[key] = value
        end
    end

    return result
end

M.map = function(mods, key, action)
    if is_table(mods) then
        mods = table.concat(mods, '|')
    end

    mods = string.upper(mods)
    return { mods = mods, key = key, action = action }
end

M.mouse_binding = function(mods, button, event, streak, action)
    mods = string.upper(mods)
    event = {
        [event] = {
            button = button,
            streak = streak,
        }
    }

    return {
        mods = mods,
        event = event,
        action = action,
    }
end

return M

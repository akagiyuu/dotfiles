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

M.add_wsl = function(launch_menu, wsl_list)
    for index, line in ipairs(wsl_list) do
        if index > 1 then
            local distro = line:gsub(" %(Default%)", "")
            table.insert(launch_menu, {
                label = distro,
                args = { "wsl.exe", "--distribution", distro },
            })
        end
    end
end

M.add_vs_shell = function(launch_menu, vs_shell_list)
    for _, vs_version in ipairs(vs_shell_list) do
        local year = vs_version:gsub("Microsoft Visual Studio/", "")
        table.insert(launch_menu, {
            label = "x64 Native Tools VS " .. year,
            args = {
                "cmd.exe",
                "/k",
                "C:\\Program Files\\" .. vs_version .. "\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat"
            },
        })
    end
end

return M

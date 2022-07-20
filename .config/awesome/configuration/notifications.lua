local naughty = require("naughty")
local rnotification = require("ruled.notification")
local wibox = require("wibox")
local beautiful = require("beautiful")

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "An error happened" .. (startup and " during startup!" or "!"),
        message = message
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n,
        cursor = "hand2",
    }
end)

rnotification.connect_signal("request::rules", function()
    rnotification.append_rule {
        rule       = { urgency = "critical" },
        properties = { fg = colors.red }
    }
end)

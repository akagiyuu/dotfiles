pcall(require, "luarocks.loader")
require("awful.autofocus")
require("user_variables")

require("themes").init {
    accent = "cherry_blossom",
    focus_color = "red"
}

require("configuration")
require("ui")
require("modules")

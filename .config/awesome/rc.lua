pcall(require, "luarocks.loader")
require("awful.autofocus")
require("user_variables")

require("themes").init {
    accent = "ayu",
}

require("ui")
require("configuration")
require("modules")

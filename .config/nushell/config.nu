source 'modules/zoxide.nu'
source 'modules/zellij.nu'

source 'config/alias.nu'
source 'config/theme.nu'
source 'config/function.nu'
use 'config/completions.nu' get-completions
use 'config/hooks.nu' get-hooks
use 'config/menus.nu' get-menus
use 'config/keybindings.nu' get-keybindings

$env.config.show_banner = false
$env.config.rm = { always_trash: false }
$env.config.edit_mode = "vi"
$env.config.completions = (get-completions)
$env.config.table = { mode: "rounded" }
$env.config.filesize = { metric: true }
$env.config.hooks = (get-hooks)
$env.config.menus = (get-menus)
$env.config.keybindings = (get-keybindings)

source 'modules/starship.nu'
source 'modules/atuin.nu'

colorscript random

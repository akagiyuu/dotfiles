starship init fish | source
zoxide init fish --cmd cd | source

if status is-interactive
    colorscript random
    atuin init fish | source
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# opam configuration
source /home/yuu/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# argc-completions
set -gx ARGC_COMPLETIONS_ROOT "/home/yuu/.local/bin/argc-completions"
set -gx ARGC_COMPLETIONS_PATH "$ARGC_COMPLETIONS_ROOT/completions"
fish_add_path "$ARGC_COMPLETIONS_ROOT/bin"
# To add a subset of completions only, change next line e.g. set argc_scripts cargo git
set argc_scripts (ls -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p')
argc --argc-completions fish $argc_scripts | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

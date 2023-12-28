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

starship init fish | source
zoxide init fish --cmd cd | source
cod init $fish_pid fish | source

if status is-interactive
    pokeget random
    atuin init fish | source
end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

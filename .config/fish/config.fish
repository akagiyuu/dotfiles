starship init fish | source
zoxide init fish --cmd cd | source

if status is-interactive
    colorscript random
    atuin init fish | source
    pyenv virtualenv-init - | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

pyenv init - | source

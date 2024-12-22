starship init fish | source
zoxide init fish --cmd cd | source

if status is-interactive
    colorscript random
    atuin init fish | source
    source ~/miniconda3/etc/fish/conf.d/conda.fish
    # pyenv virtualenv-init - | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pyenv init - | source

# pnpm
set -gx PNPM_HOME "/home/yuu/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

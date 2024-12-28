if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
    starship init fish | source
    zoxide init fish --cmd cd | source
    colorscript random
    atuin init fish | source
    source ~/miniconda3/etc/fish/conf.d/conda.fish
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/yuu/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

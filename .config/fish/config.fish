starship init fish | source
zoxide init fish --cmd cd | source

if status is-interactive
    colorscript random
end

# Bun
set -Ux BUN_INSTALL "/home/yuu/.bun"
set -px --path PATH "/home/yuu/.bun/bin"


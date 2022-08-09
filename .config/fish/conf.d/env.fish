set fish_greeting

set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
set -x GOPATH "$XDG_DATA_HOME"/go
set -x JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -x RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -x DOT_SAGE "$XDG_CONFIG_HOME"/sage
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set -x NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"
set -Ux BUN_INSTALL ~/.bun
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

fish_add_path -aP ~/.local/bin ~/Applications ~/Scripts
fish_add_path -aP $XDG_DATA_HOME/npm/bin
fish_add_path -aP $CARGO_HOME/bin
fish_add_path -aP ~/Applications/bat-extras/src
fish_add_path -aP ~/Applications/omnisharp
fish_add_path -aP ~/.bun/bin

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x LS_COLORS "$(vivid generate nord)"
set -x EDITOR "nvim"
set -x LC_COLLATE C
set -x NEOVIDE_MULTIGRID 1
set -x BAT_THEME Dracula
set -x DELTA_PAGER "less -+X"
set -x NNN_PLUG 'p:preview-tui;d:diffs;j:autojump'
set -x NNN_FIFO '/tmp/nnn.fifo'
set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_PREVIEW_COMMAND "bat --line-range :500 --color=always {}"
set -x FZF_DEFAULT_OPTS "
--preview-window hidden
--preview '$FZF_PREVIEW_COMMAND'
--bind='ctrl-p:toggle-preview'
--border=sharp
--prompt='➜ '
--pointer='➜'
--cycle
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"

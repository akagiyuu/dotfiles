set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_STATE_HOME $HOME/.local/state
set -x XDG_CACHE_HOME $HOME/.cache

set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
set -x GOPATH "$XDG_DATA_HOME"/go
set -x JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -x RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -x DOT_SAGE "$XDG_CONFIG_HOME"/sage
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history

set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths $HOME/Scripts $XDG_DATA_HOME/npm/bin $CARGO_HOME/bin $HOME/Applications/bat-extras/src $HOME/Applications/omnisharp

set fish_greeting


set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# set -x MANPAGER "nvim -c 'set ft=man' -"

set -x LS_COLORS "$(vivid generate nord)"
set -x EDITOR "nvim"

set -x LC_COLLATE C
set -x BAT_THEME Dracula

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

set -x DOTNET_CLI_TELEMETRY_OPTOUT 1

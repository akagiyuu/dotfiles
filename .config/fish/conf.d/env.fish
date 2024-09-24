set fish_greeting

set -x OPAMROOT "$XDG_DATA_HOME/opam"
set -x SQLITE_HISTORY "$XDG_CACHE_HOME"/sqlite_history
set -x CARGO_HOME "$XDG_DATA_HOME"/cargo
set -x GOPATH "$XDG_DATA_HOME"/go
set -x JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
set -x RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -x DOT_SAGE "$XDG_CONFIG_HOME"/sage
set -x LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set -x NUGET_PACKAGES "$XDG_CACHE_HOME"/NuGetPackages
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"
set -Ux BUN_INSTALL ~/.bun
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
set -x GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -x OMNISHARPHOME "$XDG_CONFIG_HOME"/omnisharp
set -x PARALLEL_HOME "$XDG_CONFIG_HOME"/parallel
set -x NIMBLE_DIR "$XDG_DATA_HOME/nimble"
set -x MANROFFOPT '-c'
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x LS_COLORS "$(vivid generate nord)"
set -x EDITOR nvim
set -x LC_COLLATE C
set -x NEOVIDE_MULTIGRID true
set -x BAT_THEME catppuccin
set -x DELTA_PAGER "less -+X"
set -x NNN_PLUG 'p:preview-tui;d:diffs;j:autojump'
set -x NNN_FIFO '/tmp/nnn.fifo'
set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_PREVIEW_COMMAND "bat --line-range :500 --color=always {}"
set -x FZF_DEFAULT_OPTS "
--preview-window hidden
--preview '$FZF_PREVIEW_COMMAND'
--bind='ctrl-p:toggle-preview,ctrl-t:toggle-all'
--border=sharp
--prompt='➜ '
--pointer='➜'
--cycle
--color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
# set -x DOTNET_JitDisasm Main
set -x GLAMOUR_STYLE "$HOME/.config/glamour/mocha.json"
set -x TERMINFO "$XDG_DATA_HOME"/terminfo
set -x TERMINFO_DIRS "$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=git cargo fetch
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=git cargo upgrade
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export KERAS_HOME="$XDG_STATE_HOME/keras"
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# fish_add_path -aP $XDG_DATA_HOME/bob/nvim-bin

fish_add_path -aP ~/.local/bin ~/Applications ~/Scripts
fish_add_path -aP $XDG_DATA_HOME/npm/bin
fish_add_path -aP $CARGO_HOME/bin
fish_add_path -aP ~/.bun/bin
fish_add_path -aP $XDG_DATA_HOME/nvim/mason/bin
fish_add_path -aP $XDG_DATA_HOME/go/bin
fish_add_path -aP /opt/cuda/bin

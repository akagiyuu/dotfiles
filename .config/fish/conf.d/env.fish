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
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -x OMNISHARPHOME "$XDG_CONFIG_HOME"/omnisharp
set -x PARALLEL_HOME "$XDG_CONFIG_HOME"/parallel
set -x NIMBLE_DIR "$XDG_DATA_HOME/nimble"
set -x BUN_FORCE_HMR 1
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
set -x BORG_REPO "$HOME/Data/Backup"
set -x ANDROID_SDK_ROOT $HOME/Android/Sdk
# set -x ANDROID_HOME "$XDG_DATA_HOME"/android
set -x GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle
# set -x PLATFORMIO_CORE_DIR "$XDG_DATA_HOME"/platformio
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

fish_add_path -aP $ANDROID_SDK_ROOT/emulator
fish_add_path -aP $ANDROID_SDK_ROOT/platform-tools

fish_add_path -aP ~/.local/bin ~/Applications ~/Scripts
fish_add_path -aP $XDG_DATA_HOME/npm/bin
fish_add_path -aP $CARGO_HOME/bin
fish_add_path -aP ~/Applications/bat-extras/src
fish_add_path -aP ~/Applications/omnisharp
fish_add_path -aP ~/.bun/bin
fish_add_path -aP $XDG_DATA_HOME/nvim/mason/bin

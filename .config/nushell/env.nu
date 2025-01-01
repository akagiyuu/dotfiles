let module_dir = $"($nu.default-config-dir)/modules"
mkdir $module_dir
starship init nu | save -f $"($module_dir)/starship.nu"
zoxide init nushell --hook prompt | save -f $"($module_dir)/zoxide.nu"

load-env {
    XDG_CACHE_HOME: $'($env.HOME)/.cache'
    XDG_CONFIG_HOME: $'($env.HOME)/.config'
    XDG_DATA_HOME: $'($env.HOME)/.local/share'
    XDG_STATE_HOME: $'($env.HOME)/.local/state'
    ENV_CONVERSIONS: {
        "PATH": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
    }
    # Directories to search for scripts when calling source or use
    NU_LIB_DIRS: [
        ($nu.config-path | path dirname) # add <nushell-config-dir>/scripts
    ]
    # Directories to search for plugin binaries when calling register
    NU_PLUGIN_DIRS: [
        # ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
    ]
}

load-env {
    #MANPAGER: "sh -c 'col -bx | bat -l man -p'"
    EDITOR: nvim
    PROMPT_INDICATOR_VI_NORMAL: {|| "" }
    PROMPT_INDICATOR_VI_INSERT: {|| "" }
    PROMPT_MULTILINE_INDICATOR: {|| "::: " }
    LS_COLORS: (vivid generate nord | str trim)
    CARGO_HOME: $"($env.XDG_DATA_HOME)/cargo"
    GOPATH: $"($env.XDG_DATA_HOME)/go"
    JUPYTER_CONFIG_DIR: $"($env.XDG_CONFIG_HOME)/jupyter"
    LESSHISTFILE: $"($env.XDG_CACHE_HOME)/less/history"
    RUSTUP_HOME: $"($env.XDG_DATA_HOME)/rustup"
    DOT_SAGE: $"($env.XDG_CONFIG_HOME)/sage"
    NPM_CONFIG_USERCONFIG: $"($env.XDG_CONFIG_HOME)/npm/npmrc"
    NUGET_PACKAGES: $"($env.XDG_CACHE_HOME)/NuGetPackages"
    PYTHONSTARTUP: $"($env.XDG_CONFIG_HOME)/python/pythonrc"
    BUN_INSTALL: $"($env.HOME)/.bun"
    DOTNET_CLI_TELEMETRY_OPTOUT: 1
    GTK2_RC_FILES: $"($env.XDG_CONFIG_HOME)/gtk-2.0/gtkrc"
    NODE_REPL_HISTORY: $"($env.XDG_DATA_HOME)/node_repl_history"
    QT_QPA_PLATFORMTHEME: qt5ct
    GNUPGHOME: $"($env.XDG_DATA_HOME)/gnupg"
    OMNISHARPHOME: $"($env.XDG_CONFIG_HOME)/omnisharp"
    PARALLEL_HOME: $"($env.XDG_CONFIG_HOME)/parallel"
    NIMBLE_DIR: $"($env.XDG_DATA_HOME)/nimble"
    BUN_FORCE_HMR: 1
    LC_COLLATE: C
    NEOVIDE_MULTIGRID: true
    BAT_THEME: catppuccin
    DELTA_PAGER: "less -+X"
    NNN_PLUG: 'p:preview-tui;d:diffs;j:autojump'
    NNN_FIFO: '/tmp/nnn.fifo'
    FZF_DEFAULT_COMMAND: 'fd --type f'
    FZF_PREVIEW_COMMAND: "bat --line-range :500 --color=always {}"
    FZF_DEFAULT_OPTS: "
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
    GRADLE_USER_HOME: $"($env.XDG_DATA_HOME)/gradle"
    GLAMOUR_STYLE: $"($env.HOME)/.config/glamour/mocha.json"
}

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ~/.local/bin
    ~/Applications
    ~/Scripts
    $"($env.XDG_DATA_HOME)/npm/bin"
    $"($env.CARGO_HOME)/bin"
    ~/.bun/bin
    $"($env.XDG_DATA_HOME)/go/bin"
])

if status is-interactive
    starship init fish | source
    zoxide init fish --cmd cd | source
    colorscript random
    atuin init fish | source
    fzf_configure_bindings --directory=\cf
end

starship init fish | source
zoxide init fish --cmd cd | source
cod init %self fish | source
if [ "$TERM_PROGRAM" = vscode ]
    source "/opt/visual-studio-code/resources/app/out/vs/workbench/contrib/terminal/browser/media/shellIntegration.fish"
end

if status is-interactive
    colorscript random
end

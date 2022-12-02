#!/bin/bash
date=$(date +%Y.%m.%d-%H.%M.%S)
backup_dir="$HOME/Data/Backup"

mkdir $backup_dir/$date

rsync -dv --exclude={'.bun','.cache','.local/share/cargo','.local/share/rustup','.local/share/Nuget','.local/share/nvim', 'debug', '.dotnet','electron','.nuget','.*vscode','Data','Downloads','Scripts','VM','Unity', "$HOME/.android/"} $HOME/ "$backup_dir"/"$date"

notify-send -h string:fgcolor:#ff4444 "back up running"

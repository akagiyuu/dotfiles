complete -c et -s d -l disk-usage -d 'Print physical or logical file size' -r -f -a "{logical	How many bytes does a file contain,physical	How much actual space on disk\, taking into account sparse files and compression}"
complete -c et -s g -l glob -d 'Include or exclude files using glob patterns' -r
complete -c et -l iglob -d 'Include or exclude files using glob patterns; case insensitive' -r
complete -c et -s l -l level -d 'Maximum depth to display' -r
complete -c et -s n -l scale -d 'Total number of digits after the decimal to display for disk usage' -r
complete -c et -s p -l prefix -d 'Display disk usage as binary or SI units' -r -f -a "{bin	Displays disk usage using binary prefixes,si	Displays disk usage using SI prefixes}"
complete -c et -s s -l sort -d 'Sort-order to display directory content' -r -f -a "{name	Sort entries by file name,size	Sort entries by size smallest to largest\, top to bottom,size-rev	Sort entries by size largest to smallest\, bottom to top,none	Do not sort entries}"
complete -c et -s t -l threads -d 'Number of threads to use; defaults to number of logical cores available' -r
complete -c et -l completions -d 'Print completions for a given shell to stdout' -r -f -a "{bash	,elvish	,fish	,powershell	,zsh	}"
complete -c et -l glob-case-insensitive -d 'Process all glob patterns case insensitively'
complete -c et -s H -l hidden -d 'Show hidden files; disabled by default'
complete -c et -l ignore-git -d 'Disable traversal of .git directory when traversing hidden files; disabled by default'
complete -c et -s I -l icons -d 'Display file icons; disabled by default'
complete -c et -s i -l ignore-git-ignore -d 'Ignore .gitignore; disabled by default'
complete -c et -s P -l prune -d 'Disable printing of empty branches'
complete -c et -l dirs-first -d 'Always sorts directories above files'
complete -c et -s S -l follow-links -d 'Traverse symlink directories and consider their disk usage; disabled by default'
complete -c et -l suppress-size -d 'Omit disk usage from output; disabled by default'
complete -c et -l size-left -d 'Show the size on the left, decimal aligned'
complete -c et -l no-config -d 'Don\'t read configuration file'
complete -c et -s h -l help -d 'Print help (see more with \'--help\')'
complete -c et -s V -l version -d 'Print version'

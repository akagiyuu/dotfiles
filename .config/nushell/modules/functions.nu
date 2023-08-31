# fzf through files, typing result.
# Requires: `fd`
export def fzf-files [] {
	fd --type f --hidden | fzf
}

# fzf through directories, navigating to result
# Requires: `fd`
export def-env fzf-cd [] {
	cd (fd --type d --hidden | fzf | str trim)
}

# fzf through shell history, typing result.
# Requires: `xdotool`
export def fzf-history [
	--query (-q): string # Optionally start with given query.
] {
	(history | get command | reverse | to text | fzf --query $"($query)")
}
alias icat = wezterm imgcat
alias f = fzf
alias v = nvim
alias y = yazi
alias cd = z
def svn [] { $"svn --config-dir ($env.XDG_CONFIG_HOME)/subversion" }
def wget [] { $"wget --hsts-file=($env.XDG_CONFIG_HOME)/wget-hsts" }
def yarn [] { $"yarn --use-yarnrc ($env.XDG_CONFIG_HOME)/yarn/config" }

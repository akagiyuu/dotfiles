alias lsi = exa --icons -l
alias icat = wezterm imgcat
alias f = fzf
alias v = nvim
alias n = nnn -eH
alias N = sudo -E nnn -deH
alias tree = erdtree
alias rustscan = docker run -it --rm --name rustscan rustscan/rustscan:latest
alias cd = z
def svn [] { $"svn --config-dir ($env.XDG_CONFIG_HOME)/subversion" }

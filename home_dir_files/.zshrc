autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Aliases
alias zathura="zathura --fork"
alias ls="exa --git"
alias p="doas pacman"
alias v="nvim"
alias vim="nvim"
alias nv="fzf | xargs nvim"
alias dmkci="doas make clean install"
alias so="source $HOME/.zshrc"
alias copy='xclip -sel clip'
alias texreload='latexmk -pdf -pvc'

# Ctrl left + Ctrl right movements
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -e

# Exports
export EDITOR=nvim
export BROWSER=firefox
export MOZ_DBUS_REMOTE=1
path+=('/home/joshua/idea-IC-232.9921.47/bin/')
path+=('/home/joshua/.cargo/bin')
export PATH
eval "$(zoxide init zsh)"

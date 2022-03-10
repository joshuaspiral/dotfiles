autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# Nice prompt :)

# Aliases
alias zathura="zathura --fork"
alias ls="exa --git"
alias p="doas pacman"
alias v="nvim"
alias icat="kitty +kitten icat"
alias od="fzf | xargs nvim"

# Ctrl left + Ctrl right movements
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Exports
export EDITOR=nvim
export PATH=/home/joshua/.cargo/bin/:$PATH
theme.sh gruvbox-dark

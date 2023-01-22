autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# Nice prompt :)

# Aliases
alias zathura="zathura --fork"
alias ls="exa --git"
alias p="doas pacman"
alias v="nvim"
alias vim="nvim"
alias nv="fzf | xargs nvim"
alias dmkci="doas make clean install"
alias so="source $HOME/.zshrc"

# Ctrl left + Ctrl right movements
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Exports
export EDITOR=nvim
export PATH=/$HOME/.cargo/bin/:$PATH
export PATH=/$HOME/.emacs.d/bin:$PATH
theme.sh ibm3270

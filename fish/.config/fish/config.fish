if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source
starship init fish | source

fish_add_path -a ~/.local/
fish_add_path -a ~/.emacs.d/bin/

export VISUAL=vim
export EDITOR="$VISUAL"
theme.sh japanesque

if status is-interactive
end

if command -v zoxide &> /dev/null
    zoxide init fish | source
end

if command -v starship &> /dev/null
    starship init fish | source
end

set -gx EDITOR nvim
set -gx BROWSER firefox

calcurse -d 7 --format-apt " - %S -> %E\n\t%m\n\t%N\n" --format-recur-apt " - %S -> %E\n\t%m\n\t%N\n"

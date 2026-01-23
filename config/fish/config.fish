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



# Override greeting message
set fish_greeting
# Wayland Environment Variables
set -gx MOZ_ENABLE_WAYLAND 1
set -gx GTK_CSD 0
set -gx QT_QPA_PLATFORM wayland
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx ELECTRON_OZONE_PLATFORM_HINT auto
set -gx SDL_VIDEODRIVER wayland
set -gx _JAVA_AWT_WM_NONREPARENTING 1

# fcitx5 CJK Input
set -gx GTK_IM_MODULE fcitx
set -gx QT_IM_MODULE fcitx
set -gx XMODIFIERS "@im=fcitx"

# Default Programs
set -gx EDITOR nvim
set -gx BROWSER firefox

if status is-interactive
    if command -v zoxide &> /dev/null
        zoxide init fish | source
    end

    if command -v starship &> /dev/null
        starship init fish | source
    end
end

#!/usr/bin/env bash
choice=$(printf "eng\nfra\njpn\nchi_sim\nchi_tra\neng+jpn\neng+chi_sim" | tofi --prompt-text "OCR Lang: ")
[ -z "$choice" ] && exit 0
grim -g "$(slurp)" - | tesseract -l "$choice" - - | wl-copy && notify-send "OCR" "Text copied ($choice)"

#/bin/sh
vol="$(pamixer --get-volume-human)"
brightness="$(light)"
if [ "$(pamixer --get-mute)" = "true" ]; then
    echo "婢 $vol  $brightness%"
else
    echo "墳 $vol  $brightness%"
fi

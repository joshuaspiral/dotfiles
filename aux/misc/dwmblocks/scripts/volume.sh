#/bin/sh
vol="$(pamixer --get-volume-human)"
brightness="$(light)"
echo "$vol | $brightness%"

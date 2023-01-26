song_info=$(playerctl -p spotifyd,%any metadata --format "{{ title }} - {{ artist }} ({{ album }})")

notify-send "$song_info"

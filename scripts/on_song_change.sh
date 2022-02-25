song_info=$(playerctl -p spotifyd,%any metadata --format "{{ title }} - {{ artist }} ({{ album }})")
echo $song_info

notify-send "$song_info"

#! /bin/sh


#TODO: make the script work even when image path has %20 like escape chars in it instead of spaces 

path2="$(playerctl metadata -f '{{mpris:artUrl}}' | sed 's/file:\/\///')"
path1=$path2

hyprctl hyprpaper unload /tmp/music_wallpaper.png
cp $path1 /tmp/music_album.png
hex="$(magick $path1 -resize 1x1 txt:- | grep '0,0' | awk '{print $3}')"
magick $path1 -background "$hex" -gravity Center -extent 1280x800 /tmp/music_wallpaper.png
#sleep 1
hyprctl hyprpaper preload /tmp/music_wallpaper.png
hyprctl hyprpaper wallpaper "eDP-1, /tmp/music_wallpaper.png"


playerctl -F metadata | while read -r title art; do
  path1="$(playerctl metadata -f '{{mpris:artUrl}}' | sed 's/file:\/\///')"
  title="$(playerctl metadata -f '{{xesam:title}}')"

  if [ "$path1" != "$path2" ] && [ "$title" != "Advertisement" ]; then
    hyprctl hyprpaper unload /tmp/music_wallpaper.png
    cp $path1 /tmp/music_album.png
    hex="$(magick $path1 -resize 1x1 txt:- | grep '0,0' | awk '{print $3}')"
#    echo "$hex"
    magick $path1 -background "$hex" -gravity Center -extent 1280x800 /tmp/music_wallpaper.png
#   sleep 1
    hyprctl hyprpaper preload /tmp/music_wallpaper.png
    hyprctl hyprpaper wallpaper "eDP-1, /tmp/music_wallpaper.png"
    path2=$path1
  fi
done

#! /bin/sh


set_wallpaper () {
  curl --fail --silent --output "/tmp/music_album.png" $path1

  #shrink image to 1x1 pixel to get the average value
  local hex="$(magick $path1 -resize 1x1 txt:- | grep '0,0' | awk '{print $3}')"
 
  #fill the remaining area of the background with the average pixel color
  #WARN: size is hardcoded to get good result for FW16
  magick $path1 -background "$hex" -gravity Center -extent 1280x800 /tmp/music_wallpaper.png

  #WARN: monitor name is hardcoded, only sets on the one monitor
  hyprctl hyprpaper wallpaper "eDP-1, /tmp/music_wallpaper.png" 
}


path2="$(playerctl metadata -f '{{mpris:artUrl}}')"
path1=$path2

set_wallpaper

playerctl metadata -f '{{mpris:artUrl}}' -F | while read -r path1; do
  if [ "$path1" != "$path2" ] && [ "$title" != "Advertisement" ]; then
    set_wallpaper
    path2=$path1
  fi
done





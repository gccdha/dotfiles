#! /usr/bin/env bash

echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print substr($2, 3); }')

#echo

#pw-cli 2>/dev/null| stdbuf -oL awk '/change/ && /node/' | while IFS= read -r line; do
pactl subscribe| grep --line-buffered change | while IFS= read -r line; do
  echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print substr($2, 3); }')
done

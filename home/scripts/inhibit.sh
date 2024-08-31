#!/bin/sh

pipe=/tmp/inhibit

# Make the pipe if it does not already exist
if [[ ! -p $pipe ]]; then
  mkfifo $pipe
fi
scripts=$(pidof hypridle)
if [[ "$scripts" ]]; then
  systemctl --user stop hypridle
  echo "inhibit" >$pipe
  notify-send -e -t 1000 "Inhibiting Started"
else
  systemctl --user start hypridle
  echo "noinhibit" >$pipe
  notify-send -e -t 1000 "Inhibiting Stopped"
fi

## If there are already any instances of this program running, kill all of them and then exit
#scripts=$(pidof -x "$0")
#if [[ "$scripts" != "$$" ]]; then
#  for PID in $scripts; do
#    if [[ "$PID" != "$$" ]]; then
#      kill "$PID"
#    fi
#  done
#else
#  # Inhibit idle
#  notify-send "Inhibiting Started on $0"
#  echo "inhibit" >$pipe
#  systemd-inhibit --what=idle --who=Inhibitor --why="cuz i friggin said so how bout that" sleep infinity
#fi
## Exit program
#echo "noinhibit" >$pipe
#notify-send "Inhibiting Stopped on $0"

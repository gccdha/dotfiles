#! /bin/sh
scripts=$(pidof -x "$0")
if [[ "$scripts" != "$$" ]]; then
  for PID in $scripts; do
    if [[ "$PID" != "$$" ]]; then
      kill "$PID"
    fi
  done
else
  systemd-inhibit --what=idle --who=Inhibitor --why="cuz i friggin said so how bout that" sleep infinity
fi

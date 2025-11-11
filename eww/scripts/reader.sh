#!/bin/sh

pipe=/tmp/inhibit

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi
echo 'noinhibit'


while true
do
  if read line <$pipe; then
    if [[ "$line" == 'inhibit' ]]; then
      echo 'inhibit'
    else
      echo 'noinhibit'
    fi
  fi
done

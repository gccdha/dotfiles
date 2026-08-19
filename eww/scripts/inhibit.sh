#!/bin/sh

status=$(cat /tmp/inhibit_status)

if [ "$status" = "inhibit" ]; then
  echo "noinhibit" > /tmp/inhibit_status
else
  echo "inhibit" > /tmp/inhibit_status
fi

echo -n $(cat /tmp/inhibit_status)

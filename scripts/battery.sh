#! /bin/sh


THRESHOLDS=(20 10 5)
notify_sent=(0 0 0)

while true; do

  bat_level = cat /sys/class/power_supply/BAT1/uevent | grep POWER_SUPPLY_CAPACITY= | awk -F '=' '{print $2}'

  #TODO add function to reset each bool as soon as the battery goes above its respective value.


  for threshold in "${THRESHOLDS[@]}"; do
    if [ "$bat_level" -le "$threshold" ]; then
      if [ "${notify_sent[$threshold]}" -eq 0 ]; then
        notify_sent[$threshold] = 1
        notify-send -u critical "Low Battery" "Battery is at ${bat_level}%"
        break #break here so that only the highest number is sent
      fi
    fi
  done

  sleep 120

done

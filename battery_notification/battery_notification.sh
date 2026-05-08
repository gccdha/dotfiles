#!/bin/sh
thresholds=(10 5) #battery levels to notify at
interval=10 #seconds between checking

#create a 1ms dummy notification to get an id we can use for all of the rest
notification_id=$(notify-send -p "Battery notifications started" --expire-time=1)

pid_flag=0
num_thresholds=2
threshold_flags=(0 0)
bat_cap=$(cat /sys/class/power_supply/BAT1/charge_full) # get max chanrge

while sleep "$interval";
do
  bat_now=$(cat /sys/class/power_supply/BAT1/charge_now) # get current charge
  bat_status=$(cat /sys/class/power_supply/BAT1/status) #"Discharging" or "Charging"
  percent=$(((bat_now*100)/bat_cap))

  #reset threshold_flags if the computer starts charging
  if [[ $bat_status == "Charging" ]]; then
    threshold_flags=(0 0 0)

    # if the last notification is still showing, send a notification to indicate charging 
    kill -0 "$pid" 2>/dev/null
    if [[ ($? == 0) && ($pid_flag == 1) ]]; then
      notify-send -r "$notification_id" -t 2000 -i /home/realram/.dotfiles/battery_notification/charging_low_battery_material_icon.svg "Charging" "Battery is charging"
      pid_flag=0
      kill -9 "$pid"
    fi
  fi

  #check if the notification has been sent yet, send if hasn't and flag as sent
  if [[ $bat_status == "Discharging" ]]; then
    for ((i=0;i<num_thresholds;i++));do 

      threshold=${thresholds[$i]}
      if [[ ( $percent -le ${threshold} ) && ( ${threshold_flags[$i]} == 0 )  ]]; then
        # Send notification and record the PID
        notify-send -r "$notification_id" -u critical -i /home/realram/.dotfiles/battery_notification/low_battery_material_icon.svg "BATTERY LOW" "Battery is at $percent%" -w &
        pid=$!
        pid_flag=1
        threshold_flags[$i]=1
      fi
    done
  fi
done



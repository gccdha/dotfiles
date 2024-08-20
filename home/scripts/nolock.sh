#! /bin/sh

nolockFile="/tmp/nolock.dat" #Stores value for if the screen should be locked (0=lock, 1=nolock)

# Sets the value of the file
set_file () {
  echo "$1" > "$nolockFile"
}
# Echos the value of the file. Creates it if it doesn't exist
get_val () {
  if [[ -f "$nolockFile" ]]; then
    cat "$nolockFile"
  else
    set_file 0
    echo "0"
  fi
}

case $1 in
  "-h")
      echo "nolock.sh"
      echo "-h  show this help"
      echo "-e  enable nolock"
      echo "-d  disable nolock"
      echo "-t  toggle nolocok"
      echo "-v  print the current state (0 for off, 1 for on)"
      ;;
  "-e")
    set_file 1
    ;;
  "-d")
    set_file 0
    ;;
  "-v")
    echo $(get_val)
    ;;
  "-t")
    current_val=$(get_val)
    if [[ "$current_val" -eq 0 ]]; then
      set_file 1
    else
      set_file 0
    fi
    ;;
  *)
    ;;
esac

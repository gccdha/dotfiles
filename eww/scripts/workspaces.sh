#! /usr/bin/env bash

# Adapted from script by adishourya on github

# ==== detect state of workspaces when script is started ==== 
# check open workspaces
for num in $(hyprctl workspaces | grep 'workspace ID' | awk '{print $3}');do # grab the workspaces that are open...
  export o"$num"="$num"                                                      # and create a variable o{n} for each one
done

#check focused workspace
for num in $(hyprctl monitors | grep 'active workspace' | awk '{print $3}');do # grab all focused workspaces...
  export f"$num"="$num"                                                        # and create a variable f{n} for each one
  export fnum=f"$num"                                                          # and keep track of focus to change later
done

# ==== Workspace Function (gets called whenever the socket outputs something) ====
workspaces() {
  print=true

  #set the focused workspace
  if [[ ${1:0:11} == "workspace>>" ]]; then
    unset -v "$fnum"
    num=${1:11}
    export f"$num"="$num"
    export fnum=f"$num"

  #add occupied workspace (workspaces cannot exist empty)
  elif [[ ${1:0:17} == "createworkspace>>" ]]; then
    num=${1:17}
    export o"$num"="$num"

  #remove occupied workspace
  elif [[ ${1:0:18} == "destroyworkspace>>" ]]; then
    num=${1:18}
    unset -v o"$num" f"$num"
  elif [[ $# -eq 0 ]]; then : ; else
    print=false
  fi


  #eww widget
  if $print; then
    echo "(box :class \"workspaces\"    :orientation \"h\"    :space-evenly \"true\"    :halign \"start\"    :spacing 10\
   	    (button :onclick \"hyprctl dispatch workspace 1\" :class \"_0$o1$f1\" \"1\") \
	    (button :onclick \"hyprctl dispatch workspace 2\" :class \"_0$o2$f2\" \"2\") \
	    (button :onclick \"hyprctl dispatch workspace 3\" :class \"_0$o3$f3\" \"3\") \
	    (button :onclick \"hyprctl dispatch workspace 4\" :class \"_0$o4$f4\" \"4\") \
	    (button :onclick \"hyprctl dispatch workspace 5\" :class \"_0$o5$f5\" \"5\") \
	    (button :onclick \"hyprctl dispatch workspace 6\" :class \"_0$o6$f6\" \"6\") \
	    (button :onclick \"hyprctl dispatch workspace 7\" :class \"_0$o7$f7\" \"7\") \
	    (button :onclick \"hyprctl dispatch workspace 8\" :class \"_0$o8$f8\" \"8\") \
	    (button :onclick \"hyprctl dispatch workspace 9\" :class \"_0$o9$f9\" \"9\") \
	    (button :onclick \"hyprctl dispatch workspace 10\" :class \"_0$o10$f10\" \"10\") \
	  )"
  fi
}

workspaces

socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r event; do 
  workspaces "$event"
done

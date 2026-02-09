#!/bin/sh

# Fixes a problem with celeste where it tries to change binds based on the assumption that the 
# binds were set in qwerty to match the current keyboard layout, even if they were already changed.

# to use, change launch options to be a path to this script followed by %command%

hyprctl switchxkblayout framework-laptop-16-keyboard-module---ansi-keyboard 1 # switch to qwerty
"$@" # run app
hyprctl switchxkblayout framework-laptop-16-keyboard-module---ansi-keyboard 0 # switch to dvorak when done

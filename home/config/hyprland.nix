{ ... }: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    wallpaper = [
    {
      monitor = "eDP-1";
      path = "/home/realram/Pictures/Wallpaper/white_flowers1.jpg";
      fit_mode = "cover";
    }
    {
      monitor = "";
      path = "/home/realram/Pictures/Wallpaper/willow_sunset.jpg";
    }
    ];
  };
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
      # ==========GENERAL=TODO================
      # set up display power management system (DPMS) (eeping)
      # set bind for pinning a window (for PiP mostly)
      # set binds for moving/swaping windows
      # set binds for resizing windows
      # set bind for "focusurgentorlast"
      # set binds for groups
      # set up multiple special workspaces for common apps (spotify, discord, etc)
      # set up some window/workspace rules and then set another todo to do more advanced ones once you get further in the ricing process
      # add animations here and fine tune them

    exec=[
      #"swaynm"
      "eww open bar"
      ", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%" #may be wrong...
      "systemctl --user start hypridle.service"
      "swaync"
      ];
      
    monitor = [
      "eDP-1,2560x1600@165,0x0,1"       #name, resolution, position, scale
      ",preferred,auto,1"#,mirror,eDP-1 #extra display: uncomment for mirror
    ];

    #VARS
    "$terminal" = "alacritty";
    "$fileManager" = "thunar";
    "$menu"="wofi --show drun -a -I";
    env = [
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,sweet-cursors"
      "XCURSOR_SIZE,24"
      "XCURSOR_THEME,xsweet-cursors"
      "QT_QPA_PLATFORMTHEME,qt6ct"
    ];

    #INPUT RULES
    input = {
      kb_layout = "us,us";
      kb_variant = "dvorak,";
      kb_model = "pc104";
      kb_options = "";
      kb_rules = "";
      
      follow_mouse = "1"; #Cursor always changes focus
      sensitivity = "0.0";
      touchpad = {
        disable_while_typing = "false";
        natural_scroll = "true";
        scroll_factor = "0.75";
        clickfinger_behavior = "true"; #2/3 finger right/middle click
         tap-to-click = "false";
      };
    };
    
    #APPEARANCE RULES
    general = {
      border_size = "3";
      gaps_in = "5";
      gaps_out = "20";
      "col.active_border" = "rgba(33ccffee) rgba(9999ffee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
    };
    decoration = {
      rounding = "10";
      active_opacity = "1.0";
      inactive_opacity = "1.0";
      fullscreen_opacity = "1.0";
      # drop_shadow = "true";
      # shadow_range = "4";
      # shadow_render_power = "3";
      # "col.shadow" = "rgba(1a1a1aee)";
      dim_inactive = "true";
      dim_strength = "0.2";
      blur = {
        enabled = "true";
        size = "3";
        passes = "1";
      };
    };

    #===========KEYBINDS=AND=INPUT============
    #flags:
    #  l: works on lockscreen
    #  r: triggers on release of key
    #  e: will repeat when held
    #  n: key event will be passed to active window as well
    #  m: mouse rely on mouse movement
    #  t: transparent (can't be shadowed by other binds)
    #  i: ignore mods (ignores mods (wow))

    "$mod" = "SUPER";
    bind = [
      "$mod, return, exec, $terminal"
      "$mod SHIFT, apostrophe, killactive,"
      "$mod SHIFT, H, exec, eww kill"
      "$mod SHIFT, period, exit,"
      #add keybind for thunar ($fileManager)
      #add keybinds for sleep/lock (fn+f9) (maybe use l flag)
      #add keybind rule for the lid switch
      "$mod SHIFT, space, togglefloating,active"
      "$mod, E, exec, $menu"
      "$mod, U, fullscreen, 0"

      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"
 
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d" 

      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      
 
      "$mod SHIFT, 1, movetoworkspacesilent, 1"
      "$mod SHIFT, 2, movetoworkspacesilent, 2"
      "$mod SHIFT, 3, movetoworkspacesilent, 3"
      "$mod SHIFT, 4, movetoworkspacesilent, 4"
      "$mod SHIFT, 5, movetoworkspacesilent, 5"
      "$mod SHIFT, 6, movetoworkspacesilent, 6"
      "$mod SHIFT, 7, movetoworkspacesilent, 7"
      "$mod SHIFT, 8, movetoworkspacesilent, 8"
      "$mod SHIFT, 9, movetoworkspacesilent, 9"
      "$mod SHIFT, 0, movetoworkspacesilent, 10"
    ];
    bindl = [
      # Media Keys
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", switch:on:Lid Switch, exec, systemctl suspend"
    ];
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+" #increase volume 5% limited to 150%
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"        #decrease volume 5%
      ", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"                 #mute (set volume to 0)
      "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"         #mute (TOGGLE VERSION)
      ", XF86MonBrightnessUp, exec, brightnessctl set +5% -q -e 3"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%- -q -e 3"
    ];
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    binds = {
      workspace_back_and_forth = "true";
    };
    gesture = [
      "4, horizontal, workspace"
      "4, pinch, fullscreen"
      #"5, pinchin,  dispatcher, fullscreenstate 0 0"
    ];


    misc = {
      disable_splash_rendering = "true";
      force_default_wallpaper = "0";
      animate_manual_resizes = "false";
      animate_mouse_windowdragging = "false";
      disable_autoreload = "true";
      enable_anr_dialog = "false";
    };

    cursor = {
      no_warps = "true";
    };
  };

  # Hypridle config
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          #timeout = 20;
          #on-timeout = "brightnessctl -s set 1";
          #on-resume  = "brightnessctl -r";
        }
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl hibernate";
        }
      ];
    };
  };

}

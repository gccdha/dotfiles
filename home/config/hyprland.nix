{ lib, ... }: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    wallpaper = [
    {
      monitor = "eDP-1";
      # path = "/home/realram/Pictures/Wallpaper/white_flowers1.jpg";
        path = "/home/realram/Pictures/Wallpaper/artemis_moon_earth_and_reflection.JPG";
      fit_mode = "cover";
    }
    {
      monitor = "";
      path = "/home/realram/Pictures/Wallpaper/willow_sunset.jpg";
    }
    ];
  };
  services.gammastep = {
    enable = true;
    latitude = 40.0;
    longitude = -105.0;
    temperature = {
      night = 4000;
      day = 6500;
    };
  };
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.configType = "lua";
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

    on._args = [
      "hyprland.start"
      (lib.generators.mkLuaInline ''
      function()
        hl.exec_cmd("eww open bar")
        hl.exec_cmd(", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%")
        hl.exec_cmd("systemctl --user start hypridle.service")
        hl.exec_cmd("swaync")
        hl.exec_cmd("alacritty -e zsh -c 'bat /home/realram/todo.txt; exec zsh' & disown")
        hl.exec_cmd("zsh /home/realram/.dotfiles/battery_notification/battery_notification.sh")
        hl.exec_cmd("hyprctl output create headless")
      end
      '')
      ];

      
    monitor = [
      {
        output = "eDP-1";
        mode = "2560x1600@165";
        position = "0x0";
        scale = "1";
      } 
      {
        output = "HEADLESS-2";
        disabled = true;
      }
      {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "1"; 
        #mirror = "eDP-1";  #extra display: uncomment for mirror
      }
    ];

    #VARS
    terminal._var = "alacritty";
    fileManager._var = "thunar";
    menu._var ="wofi --show drun -a -I";

    env = [
      {_args = ["HYPRCURSOR_SIZE" "24"];}
      {_args = ["HYPRCURSOR_THEME" "sweet-cursors"];}
      {_args = ["XCURSOR_SIZE" "24"];}
      {_args = ["XCURSOR_THEME" "xsweet-cursors"];}
      {_args = ["QT_QPA_PLATFORMTHEME" "qt6ct"];}
      {_args = ["WLR_NO_HARDWARE_CURSORS" "1"];}
    ];


    config = {
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

      # BIND RULES
      binds = {
        workspace_back_and_forth = true;
      };
    
      # MISC
      misc = {
        disable_splash_rendering = "true";
        force_default_wallpaper = "0";
        animate_manual_resizes = "false";
        animate_mouse_windowdragging = "false";
        disable_autoreload = "true";
        enable_anr_dialog = "false";
      };

      # CURSOR
      cursor = {
        no_warps = "true";
      };
    };
    

    #===========KEYBINDS=AND=INPUT============
    #flags:
    #  lockscreen: works on lockscreen
    #  repeat: will repeat when held
    #  mouse: rely on mouse movement

    mod._var = "SUPER";
    bind = [
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ return\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ SHIFT + apostrophe\"")
        (lib.generators.mkLuaInline "hl.dsp.close()")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ SHIFT + H\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"eww kill\")")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ SHIFT + period\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshutdown\")")
      ];}
      #add keybind for thunar ($fileManager)
      #add keybinds for sleep/lock (fn+f9) (maybe use l flag)
      #add keybind rule for the lid switch
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ SHIFT + space\"")
        (lib.generators.mkLuaInline "hl.dsp.float()")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ E\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu)")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ U\"")
        (lib.generators.mkLuaInline "hl.dsp.fullscreen()") 
      ];}

      # WINDOW NAVIGATION

      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ H\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"l\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ L\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"r\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ K\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"u\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ J\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"d\"})")
      ];}
 
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ left\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"l\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ right\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"r\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ up\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"u\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ down\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({direction = \"d\"})" )
      ];}


      # WORKSPACE NAVIGATION

      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 1\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"1\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 2\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"2\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 3\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"3\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 4\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"4\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 5\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"5\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 6\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"6\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 7\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"7\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 8\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"8\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 9\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"9\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod ..\"+ 0\"")
        (lib.generators.mkLuaInline "hl.dsp.focus({workspace = \"10\"})")
      ];}
     
      # INTER WORKSPACE WINDOW MOVEMENT
 
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 1\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"1\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 2\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"2\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 3\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"3\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 4\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"4\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 5\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"5\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 6\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"6\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 7\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"7\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 8\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"8\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 9\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"9\"})")
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod SHIFT ..\"+ 0\"")
        (lib.generators.mkLuaInline "hl.dsp.move({workspace = \"10\"})")
      ];}

      # SCREENSHOTS

      { _args = [
          (lib.generators.mkLuaInline "\"Print\"")
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m output -m eDP-1 -o /home/realram/Pictures/Screenshots\")")
      ];}
      { _args = [
          (lib.generators.mkLuaInline "\"SHIFT + Print\"")
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m region -o /home/realram/Pictures/Screenshots\")")
      ];}

      # MEDIA KEYS
      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioPlay\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl play-pause\")")
        { locked = true; }
      ];}
      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioNext\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl next\")")
        { locked = true; }
      ];}
      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioPrev\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl previous\")")
        { locked = true; }
      ];}

      # LID SWITCH BINDS

      { _args = [
        (lib.generators.mkLuaInline "\"switch:on:Lid Switch\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"systemctl suspend\")")
        { locked = true; }
      ];}

      # VOLUME AND BRIGHTNESS

      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioRaiseVolume\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+\")")
        { locked = true; repeating = true; }
      ];}#increase volume 5% limited to 150%

      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioLowerVolume\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
        { locked = true; repeating = true; }
      ];}#decrease volume 5%

      { _args = [
        (lib.generators.mkLuaInline "\"XF86AudioMute\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%\")")
        { locked = true; repeating = true; }
      ];}#mute (set volume to 0)

      { _args = [
        (lib.generators.mkLuaInline "\"SHIFT + XF86AudioMute\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
        { locked = true; repeating = true; }
      ];}#mute (TOGGLE VERSION)

      { _args = [
        (lib.generators.mkLuaInline "\"XF86MonBrightnessUp\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl set +5% -q -e 3\")")
        { locked = true; repeating = true; }
      ];}

      { _args = [
        (lib.generators.mkLuaInline "\"XF86MonBrightnessDown\"")
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl set 5%- -q -e 3\")")
        { locked = true; repeating = true; }
      ];}
      
      # MOUSE

      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ mouse:272\"")
        (lib.generators.mkLuaInline "hl.dsp.window.drag()")
        { mouse = true; }
      ];}
      { _args = [
        (lib.generators.mkLuaInline "mod .. \"+ mouse:273\"")
        (lib.generators.mkLuaInline "hl.dsp.window.resize()")
        { mouse = true; }
      ];}
    ];

    # GESTURES
    gesture = [
      { fingers = 4; direction = "horizontal"; action = "workspace"; }
      { fingers = 4; direction = "vertical"; action = "fullscreen"; }
    ];

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

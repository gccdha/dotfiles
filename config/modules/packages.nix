{inputs, lib, pkgs, system, ...}:{

  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "obsidian"
      "spotify"
      "steam"
      "discord"
      
    ];
  environment.systemPackages = [
    pkgs.git # install first for flakes

    #NOTE: LOC means that the package might do better in another module
    #NOTE: HOM means that the package might do better in home manager (TODO)

    #-----Applications-----
    pkgs.firefox                #web browser
    pkgs.spotify                #music
    pkgs.alacritty              #terminal
    pkgs.kitty                  #terminal
    pkgs.xfce.thunar            #GUI file explorer
    pkgs.steam                  #game launcher
    pkgs.vscodium               #GUI IDE
    pkgs.vlc                    #Audio/Video player
    pkgs.obsidian               #Markdown notetaking
    pkgs.discord                #Message client
    #                           #Neovim (nixvim flake)
    inputs.nixvim-flake.packages.${system}.default
    pkgs.lutris                 #game compat (for trackmania)
    pkgs.prismlauncher          #minecraft launcher
    pkgs.zathura                #pdf viewer
    pkgs.lumafly                #hollow knight mod launcher
    pkgs.tor-browser            #TOR browser
    pkgs.taskwarrior3           #cli task manager
    pkgs.timewarrior            #cli time trackr
    # pkgs.sage                   #cli math engine


    # pkgs.postman                #API tester
    # pkgs.digikam                #image library manager
    # #                           #plover stenography 
    # (inputs.plover-flake.packages.${system}.plover.with-plugins (
    #   ps: with ps; [
    #     plover-lapwing-aio
    #     plover-output-dotool
    #   ]
    # ))



    #-----Desktop environment-----
    pkgs.hyprland               #wm
    pkgs.wofi                   #wayland app launcher
    pkgs.swaynotificationcenter #swaync notifications
      pkgs.libnotify
    pkgs.brightnessctl          #backlight manager
    pkgs.eww                    #bar and widget maker
    pkgs.hyprpaper              #wallpapers
    pkgs.fastfetch              #neofetch
    pkgs.plymouth               #Bootloader splashscreen
    #                           #sddm and theme
    inputs.sddm-chili.packages.${system}.sddm-chili

    # pkgs.greetd.tuigreet        #tui sddm alternative
    # pkgs.mpvpaper               #video wallpapers

    #-----Media-----
    pkgs.wireplumber            #pipewire helper
    pkgs.cava                   #cli audio visualizer
    pkgs.playerctl              #controls for media
    pkgs.imagemagick            #image manipulation tool
    pkgs.pulseaudio             #enables access to pulse audio commands for pipewire

    #-----Utilities---
    pkgs.bluez                  #bluetooth
    pkgs.wget                   #cli downloads
    pkgs.zsh                    #shell
    pkgs.powertop               #power usage information
    pkgs.socat                  #UNIX socket utility
    pkgs.gcc                    #c/c++ compiler
    pkgs.fprintd                #fingerprint reader auth
    pkgs.btop                   #more interactive / prettier top
    pkgs.fzf                    #fuzzy searching util
    pkgs.bat                    #better cat
    pkgs.eza                    #better ls
    pkgs.zellij                 #simple "multiplexer"
    pkgs.ncdu                   #tui disk information

  
    # pkgs.atuin                  #shell history search
    # pkgs.wireguard-tools        #wireguard cli tools
    # pkgs.wgcf                   #wireguard cloudflare warp client
    
    #-----Misc-----
    pkgs.qmk                    #keyboard control
      pkgs.qmk-udev-rules       #needed for qmk to work LOC
    pkgs.maple-mono-NF          #maple mono nerdfont LOC
    pkgs.uwsm                   #universal wayland session manager
    

  ];
}

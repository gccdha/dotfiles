{inputs, lib, pkgs, system, ...}:{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "obsidian"
      "steam"
      "steam-unwrapped"
      "copilot.vim"
      "spotify"
      "discord"
    ];
  
  programs.steam.enable = true;
  programs.thunar.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; #tell electron apps that its wayland

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    nerd-fonts.monaspace
    font-awesome
    maple-mono.NF
  ];

  environment.systemPackages = [
    pkgs.git # install first for flakes
    #-----Applications-----
    pkgs.firefox                #web browser
    pkgs.alacritty              #terminal
    pkgs.kitty                  #terminal
    pkgs.thunar                 #GUI file explorer
    pkgs.steam                  #game launcher
    pkgs.vscodium               #GUI IDE
    pkgs.vlc                    #Audio/Video player
    pkgs.obsidian               #Markdown notetaking
    pkgs.discord
    #                           #Neovim (nixvim flake)
    inputs.nixvim-flake.packages.${system}.default
    pkgs.prismlauncher          #minecraft launcher
    pkgs.zathura                #pdf viewer
    pkgs.lumafly                #hollow knight mod launcher
    pkgs.tor-browser            #TOR browser
    pkgs.taskwarrior3           #cli task manager
    pkgs.timewarrior            #cli time trackr
    pkgs.olympus                #celeste mod manager
    (pkgs.olympus.override {celesteWrapper = "steam-run"; })
    pkgs.proton-vpn             #proton vpn
    pkgs.godot                  #godot game engine
    # pkgs.sage                   #cli math engine
    pkgs.spotify                #music
    # pkgs.postman                #API tester
    pkgs.plover_5                 #plover stenography 
    #-----Desktop environment-----
    pkgs.hyprland               #wm
    pkgs.wofi                   #wayland app launcher
    pkgs.swaynotificationcenter #swaync notifications
      pkgs.libnotify
    pkgs.brightnessctl          #backlight manager
    pkgs.eww                    #bar and widget maker
    pkgs.quickshell             #widget maker
    pkgs.hyprpaper              #wallpapers
    pkgs.fastfetch              #neofetch
    #                           #sddm and theme
    inputs.sddm-astro.packages.${system}.sddm-astro
    pkgs.hyprshot               # screenshot
    pkgs.gammastep              # for blue light filtering (REPLACE WITH HYPRSUNSET)
    pkgs.hyprshutdown           # for shutting down the system gracefully
    # pkgs.greetd.tuigreet        #tui sddm alternative
    # pkgs.mpvpaper               #video wallpapers
    #-----Media-----
    pkgs.wireplumber            #pipewire helper
    pkgs.cava                   #cli audio visualizer
    pkgs.playerctl              #controls for media
    pkgs.imagemagick            #image manipulation tool
    pkgs.pulseaudio             #enables access to pulse audio commands for pipewire
    pkgs.feh                    #simple image viewer
    pkgs.digikam                #photo organization and basic editing
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
    pkgs.unzip                  #open zip files
    pkgs.jq                     #command line json manipulator
    pkgs.framework-tool         #allows low level control and analysis of system info (fan speed for example)
    pkgs.units                  #gnu units for unit based calculations
    pkgs.uiua                   #stack based programming language
    # pkgs.atuin                  #shell history search
    # pkgs.wgcf                   #wireguard cloudflare warp client
    #-----Misc-----
    pkgs.maple-mono.NF          #maple mono nerdfont TODO: Why is this here? is it ok to just install it above?
    # pkgs.itd                    # infinitime daemon (removed because it contains an error in the latest release. check back to see if updated)
    # pkgs.watchmate              #infinitime management app
    # pkgs.ckb-next               #manages rgb on corsair mouse
  ];
}

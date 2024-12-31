# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{config, pkgs, inputs, system, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #<home-manager/nixos>
      ./secrets.nix #Time Zone, wg-key
      ./import
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  


  #boot.initrd.luks.devices."luks-66f1cdfb-d50f-4982-abfb-8ffe49797927".device = "/dev/disk/by-uuid/66f1cdfb-d50f-4982-abfb-8ffe49797927";
  networking.hostName = "FW16"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    type = "ibus";
    enable = true;
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.realram = {
    isNormalUser = true;
    description = "realram";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "docker" ];
    packages = [];
  };

  #home-manager.users.realram = import /home/realram/.config/home-manager/home.nix;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-wrapped-7.0.20"
    "dotnet-runtime-7.0.20"
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = [
    pkgs.git                #installed first bc flakes needs it
   # home-manager       #declaratively configure dotfiles
    pkgs.awesome            #x11 WM
    pkgs.hyprland           #wayland WM
      pkgs.wofi               #launcher
      pkgs.swaynotificationcenter#notifications
      	pkgs.libnotify
      pkgs.wireplumber        #policy manager for pipewire
      pkgs.brightnessctl      #backlight manager
      pkgs.mpvpaper           #video wallpapers
      pkgs.eww                #bar
      pkgs.cava               #audio visualizer
      pkgs.hyprpaper          #wallpaper setter
    pkgs.bluez              #bluetooth

    pkgs.fastfetch          #neofetch in c
    #vim
    #pkgs.neovim
    pkgs.wget               #get webpage content and download stuff etc
    pkgs.firefox
    pkgs.spotify
      pkgs.spotifyd           #spotify
    #python3
      #python311Packages.pyserial
    pkgs.qmk                #keyboard rgb stuff
    pkgs.qmk-udev-rules   #needed for flashing to work w/out sudo
    pkgs.zsh                #z shell
    pkgs.alacritty          #terminal
    pkgs.xfce.thunar        #gui file manager
      #gvfs               #extends thunar functionality
      #xfce.xfconf        #makes gvfs work
    #xorg.xbacklight    #backlight adjustment  
    #pkgs.tlp                #battery management
    pkgs.powertop
    pkgs.maple-mono-NF      #Font for stuff
    pkgs.steam              #gmaes
    pkgs.vscodium           #IDE
    pkgs.vlc                #video player
    pkgs.socat              #socket stuff
    pkgs.playerctl          #for media key and metadata stuff
    pkgs.gcc                #gcc compiler
    pkgs.cjson            #json parsing library
    pkgs.obsidian           #MD editor
    pkgs.fprintd            #fingerprint stuff
    pkgs.imagemagick
    pkgs.discord
    inputs.nixvim-flake.packages.${system}.default
    (inputs.plover-flake.packages.${system}.plover.with-plugins (
      ps: with ps; [
        plover-lapwing-aio
        plover-output-dotool
      ]
    )) 
    pkgs.wireguard-tools
    pkgs.pulseaudio      #allows access to pulse audio commands for pipewire
    pkgs.plymouth        #Bootloader splash and LUKS password customization
    inputs.sddm-chili.packages.${system}.sddm-chili
    pkgs.lutris
    pkgs.prismlauncher
    pkgs.wgcf
    pkgs.zathura
    pkgs.digikam
    pkgs.kitty
    pkgs.postman

    pkgs.btop
    pkgs.atuin
    pkgs.fzf
    pkgs.bat
    pkgs.eza
    pkgs.ncdu
    pkgs.zellij
    #pkgs.sage    # problems with test cases entering infinite loop
    pkgs.lumafly
    pkgs.tor-browser
    pkgs.protonvpn-gui
];

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    nerd-fonts.monaspace
  ];

	

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  services.xserver = {
    xkb.layout = "us,us";
    xkb.variant = "dvorak,";                           #set dvorak as keyboard layout
    xkb.options = "grp:win_space_toggle";
    enable = true;                                     #enable X11
  };
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "chili";
    };

    #windowManager.awesome.enable = true;              #enable awesomewm
    #displayManager.defaultSession = "none+awesome";   #set default session to no wm or awesome (TODO) is this required?

  programs.thunar.enable = true; 
  services.udev = {
    packages = [ pkgs.qmk-udev-rules ];
    extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
    ''; #for plover and preventing keyboard waking in backpack respectively
  };
  #programs.neovim = { 
  #  enable        = true;
  #  defaultEditor = true;
  #  vimAlias      = true;
  #  viAlias       = true;
  #};
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; #tell electron apps its wayland
  #home-manager = {
  #  useUserPackages = true;
  #  useGlobalPkgs = true;
  #};

  services.power-profiles-daemon.enable = true;

  #services.tlp = {
  #  enable = true;
  #  settings = {
  #    RADEON_DPM_STATE_ON_AC="performance";
  #    RADEON_DPM_STATE_ON_BAT="battery";
  #    NMI_WATCHDOG=0;                      #could cause problems with debugging kernel stuff and watchdog daemon
  #    PLATFORM_PROFILE_ON_AC="performance";
  #    PLATFORM_PROFILE_ON_BAT="low-power";
  #    MEM_SLEEP_ON_AC="s2idle";
  #    MEM_SLEEP_ON_BAT="deep";
  #    CPU_SCALING_GOVERNOR_ON_AC="performance";
  #    CPU_SCALING_GOVERNOR_ON_BAT="powersave";
  #    CPU_ENERGY_PERF_POLICY_ON_BAT="power";
  #  };
  #};

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  programs.steam = {
    enable = true;
  };

#  networking.wireguard.interfaces = {
#    wg0 = {
#      ips = [ "10.8.0.2/24" ];
#      listenPort = 51820;
#      peers = [
#        {
#          publicKey = "/zscnXzow2ayWgGRXUPOlrlxOEk1udk9tNjB1mnmjgA=";
#          allowedIPs = [ "0.0.0.0/0" ];
#            endpoint = "realram.duckdns.org:51820";
#            persistentKeepalive = 25;
#        }
#      ];
#    };
#  };

#  systemd.network.wait-online.enable = false;
#  boot.initrd.systemd.network.wait-online.enable = false;

  services.fprintd = {
    enable = true;
  #  tod.enable = true;
  #  tod.driver = pkgs.libfprint-2-tod1-goodix;
  };
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = {
    fprintAuth = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [];

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
    daemon.settings = {
      userland-proxy = false;
      experimental = true;
    };
  };


  programs.zsh.enable = true;



  #programs.nixvim.enable = true;
  #programs.neovim.enable = true;
  services.gvfs.enable = true;
  #programs.xfconf.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ 51820 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
 
  #services.xserver.enable = true;
  #services.xserver.displayManager.awesome.enable = true; 


  #-------------------NOTES------------------------
  # 1. python script in home directory
  # 2. added qmk repo in ~/
  # 3. can't figure out why thunar won't detect gvfs
}

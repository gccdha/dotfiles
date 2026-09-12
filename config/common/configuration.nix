{pkgs, inputs, system, ... }:{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

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


  # Keyboard settings
  i18n.inputMethod = {
    type = "ibus";
    enable = true;
  };

  console.keyMap = "dvorak";

  services.xserver = { # required for greeter i think
    xkb.layout = "us,us";
    xkb.variant = "dvorak,";                           #set dvorak as keyboard layout
    xkb.options = "grp:win_space_toggle";
    enable = true;                                     #enable X11
  };

  #User config 
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  #Services

  #firmware update service
  #services.fwupd.enable = true;

  #Daemon for information on battery and power
  services.upower.enable = true;

  #Desktop mirroring
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  #printing and drivers
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  #gnome virtual file system. used for thunar, trash, some other stuff
  services.gvfs.enable = true;

  #audio services
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  #bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };
  


}

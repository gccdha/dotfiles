{pkgs, ... }:{
  networking.hostName = "FW16";

  users.users.realram = {
    isNormalUser = true;
    description = "realram";
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "docker" ];
  };

  #TODO: remove this hopefully
  services.udev = {
    packages = [ pkgs.qmk-udev-rules ];
    extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
      ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
    ''; #for plover and preventing keyboard waking in backpack respectively
  };
  


  #services

  #Sunshine: desktop mirroring app
  services.sunshine.applications = { #see global config for more
    env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };

      apps = [
        {
          name = "Auto Desktop";
          prep-cmd = [
            {
              do = "sh -c 'hyprctl keyword monitor HEADLESS-1,\${SUNSHINE_CLIENT_WIDTH}x\${SUNSHINE_CLIENT_HEIGHT}@\${SUNSHINE_CLIENT_FPS},auto,1'";
              undo = "hyprctl keyword monitor HEADLESS-1,disable";
            }
          ];
        }
      ];
  };

  #Tuned: power saving daemon
  services.tuned = {
    enable = true;
    profiles = 
      {balanced-no-vid = {                    # encountered problems with video power saving options
        modules.cpufreq_conservative = "+r";
        cpu = {
          priority = "10";
          governor = "schedutil|ondemand|powersave";
          energy_perf_bias="normal";
          energy_performance_preference="balance_performance";
          boost="1";
        };
        acpi.platform_profile="balanced";
        audio.timeout = "10";
        scsi_host.alpm="med_power_with_dipm";
      };};
    settings = {
      dynamic_tuning = true;
    };
  };


  environment.systemPackages = [
    pkgs.plymouth              # bootloader splashscreen
    pkgs.qmk                   # keyboard controll
    pkgs.qmk-udev-rules        # needed for qmk to work
    

  ];

  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

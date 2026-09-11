{pkgs, ... }:{
  networking.hostName = "FW13";

  users.users.rr = {
    isNormalUser = true;
    description = "rr";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  #graphics driver config 
  #TODO: is this required?
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;




  #programs
  environment.systemPackages = with pkgs; [
    moonlight-qt
    waybar
  ];

  #server config
  # services.openssh = {
  #   enable = true;
  #   ports = [ 22 ];
  #   settings = {
  #     PasswordAuthentication = false;
  #     AllowUsers = null;
  #     UseDns = true;
  #     X11Forwarding = false;
  #     PermitRootLogin = "no";
  #   };
  # };
  #
  # services.fail2ban = {
  #   enable = true;
  #   maxretry = 5;
  #   bantime = "10m";
  #   bantime-increment.enable = true;
  # };
  # 
  # networking.firewall.allowedTCPPorts = [ 22 ];




  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

{config, pkgs, ...}:{

  # Open ports
  networking.firewall.allowedTCPPorts = [7000 7001 7100];
  networking.firewall.allowedUDPPorts = [5353 6000 6001 7011];

  # enable discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true; #printing
    openFirewall = true; #make sure they are open
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
      domain = true;
    };
  };

  environment.systemPackages = with pkgs; [uxplay];
}

{ config, pkgs, inputs, system, ... }: {
  imports = [
    ./config
  ];
  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = with pkgs; [ gnupg ];
    stateVersion = "23.11"; #no touchy touchy
  };

  programs.gpg = { enable = true; };
  services.gpg-agent = { enable = true; };
}

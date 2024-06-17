{ config, pkgs, inputs, system, ... }: {
  imports = [
    ./config
  ];
  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = with pkgs; [ ];
    stateVersion = "23.11"; #no touchy touchy
  };
}

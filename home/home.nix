{ config, pkgs, inputs, system, ... }: {
  imports = [
    ./config
    ./scripts
  ];
  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [ ];
    stateVersion = "23.11"; #no touchy touchy
  };
}

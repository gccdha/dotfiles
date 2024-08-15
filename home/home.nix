{ config, pkgs, inputs, system, ... }: {
  imports = [
    ./config
  ];
  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [ pkgs.plover.dev ];
    stateVersion = "23.11"; #no touchy touchy
    settings.plover.enable = true;
  };
}

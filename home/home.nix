{ config, pkgs, inputs, system, nix-colors, ...}: {
  imports = [
    ./config
    ./scripts
    nix-colors.homeManagerModule
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [];
    stateVersion = "23.11"; #no touchy touchy
  };
}

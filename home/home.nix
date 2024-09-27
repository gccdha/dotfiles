{ config, pkgs, inputs, system, ... }: {
  imports = [
    ./config
    ./scripts
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [ ];
    stateVersion = "23.11"; #no touchy touchy
  };
}

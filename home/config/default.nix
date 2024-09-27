{ pkgs, config, ... }:{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./xdg_config.nix
    ./colors
  ];
}

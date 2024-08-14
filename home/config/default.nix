{ pkgs, config, ... }:{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./plover.nix
  ];
}

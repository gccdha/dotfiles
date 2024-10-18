{ pkgs, config, ... }:{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./xdg_config.nix
    ./zsh.nix
    ./colors.nix
    ./colorconfig.nix
    #./colors
  ];
}

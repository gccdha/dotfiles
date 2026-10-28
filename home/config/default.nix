{ pkgs, config, ... }:{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./xdg_config.nix
    ./zsh.nix
    ./taskwarrior.nix
    ./kitty.nix
    ./zellij.nix
    #./timewarrior.nix
    #./colors.nix
    #./colorconfig.nix
    #./colors
  ];
}

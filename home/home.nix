{ config, pkgs, inputs, system, plover-flake, ... }: {
  imports = [
    ./config
  ];
  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [ 
      (plover-flake.packages.${system}.plover.with-plugins (ps: with ps; [
        plover-dict-commands
        plover-console-ui
      ]))
    ];
    stateVersion = "23.11"; #no touchy touchy
  };
}

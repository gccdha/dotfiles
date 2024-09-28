{ config, pkgs, inputs, system, nix-colors, ... }: 

let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
  in {
  wallpaper = nix-colors-lib.nixWallpaperFromScheme {
    scheme = config.colorScheme;
    width = 2560;
    height = 1600;
    logoScale = 1.0;
  };

  imports = [
    ./config
    ./scripts
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
    
  

  home = {
    username = "realram";
    homeDirectory = "/home/realram";
    packages = [ ];
    stateVersion = "23.11"; #no touchy touchy
  };
}

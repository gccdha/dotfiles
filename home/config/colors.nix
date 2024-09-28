{ pkgs, config, nix-colors, ... }:

let
  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
in {
  colorScheme = nix-colors-lib.nixWallpaperFromScheme {
      scheme = config.colorScheme;
      width = 2560;
      height = 1080;
      logoScale = 5.0;
  };
}

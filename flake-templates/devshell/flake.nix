{
  description = "A basic flake providing a devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          # replace by the packages you need
          hello
        ];
        
        #uncomment this and fill with your shell hook
        # shellHook = ''
        #   exec zsh
        # '';
      };
    }) nixpkgs.legacyPackages;
  };
}

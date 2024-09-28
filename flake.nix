{
  description = "NixOS Configuration";
  #I plan on changing the GRUB menu so lines concerning that are marked with "GRUB"

  # The nixos-unstable branch of the NixOS/nixpkgs repository on GitHub.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nix based neovim
    nixvim-flake.url = "github:gccdha/nixvim";
    nixvim-flake.inputs.nixpkgs.follows = "nixpkgs";
    grub2-themes.url = "github:vinceliuice/grub2-themes"; #GRUB
    grub2-themes.inputs.nixpkgs.follows = "nixpkgs";
    plover-flake.url = "github:gccdha/plover-flake";        #Plover Plugins (HTF I get work :cry:)
    plover-flake.inputs.nixpkgs.follows = "nixpkgs";
    sddm-chili.url = "github:gccdha/sddm-chili";
    sddm-chili.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:Misterio77/nix-colors";
    nix-colors.inputs.nixpkgs.follows = "nixpkgs";
    #plover-flake.url = "github:gccdha/plover-wayland-nix"; 
    #plover-flake.inputs.nixpkgs.follows = "nixpkgs"; 
  };

  outputs = inputs@{ self, nixpkgs, home-manager, grub2-themes, nix-colors, ... }: #GRUB
  let
    system = "x86_64-linux";
  in {
    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation
    nixosConfigurations = {
      FW16 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system nix-colors; };
        modules = [
            ./config/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.realram = import ./home/home.nix;
              home-manager.extraSpecialArgs = { inherit nix-colors; };
            }
            grub2-themes.nixosModules.default
        ];
      };
    };
  };
}

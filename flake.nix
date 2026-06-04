{
  description = "NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    inputs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};

          home-manager.users.nix = {
            imports = [
              nix-flatpak.homeManagerModules.nix-flatpak
              ./flatpak.nix
            ];
          };
        }
      ];
    };
  };
}

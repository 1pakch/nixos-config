{
  description = "ilya's nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/bcd464ccd2a1";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
    }:
    {

      nixosConfigurations.tat = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.ilya = ./home.nix;
          }
        ];
      };

    };
}

{
  description = "ilya's nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/bcd464ccd2a1";
  };

  outputs =
    { self, nixpkgs }:
    {

      nixosConfigurations.tat = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };

    };
}

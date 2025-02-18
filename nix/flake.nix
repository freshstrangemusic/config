{
  description = "system configuration flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/nixos-wsl?ref=main";
  };

  outputs =
    {
      nix-darwin,
      nixos-wsl,
      nixpkgs,
      ...
    }:
    {
      darwinConfigurations."vixen" = nix-darwin.lib.darwinSystem {
        modules = [ ./hosts/vixen/configuration.nix ];
      };

      nixosConfigurations."tanuki" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tanuki/configuration.nix ];
      };

      nixosConfigurations."lovelace" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/lovelace/configuration.nix
        ];
      };
    };
}

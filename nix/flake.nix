{
  description = "system configuration flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/nixos-wsl?ref=main";

    patisserie = {
      url = "github:freshstrangemusic/patisserie";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nix-darwin,
      nixos-wsl,
      nixpkgs,
      ...
    }:
    {
      darwinConfigurations."vixen" = nix-darwin.lib.darwinSystem {
        modules = [ ./hosts/vixen/configuration.nix ];
        specialArgs = { inherit inputs; };
      };

      darwinConfigurations."kitsune" = nix-darwin.lib.darwinSystem {
        modules = [ ./hosts/kitsune/configuration.nix ];
        specialArgs = { inherit inputs; };
      };

      nixosConfigurations."tanuki" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tanuki/configuration.nix ];
        specialArgs = { inherit inputs; };
      };

      nixosConfigurations."lovelace" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/lovelace/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
}

{
  description = "system configuration flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      darwinConfigurations."vixen" =
        let
          system = "aarch64-darwin";
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./modules/common.nix
            ./modules/macOS.nix
            ./hosts/vixen/configuration.nix
          ];
        };

      darwinConfigurations."kitsune" =
        let
          system = "aarch64-darwin";
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./modules/common.nix
            ./modules/macOS.nix
            ./hosts/kitsune/configuration.nix
          ];
        };

      nixosConfigurations."tanuki" =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            ./modules/common.nix
            ./hosts/tanuki/configuration.nix
          ];
        };

      nixosConfigurations."lovelace" =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            nixos-wsl.nixosModules.default
            ./modules/common.nix
            ./hosts/lovelace/configuration.nix
          ];
        };
    };
}

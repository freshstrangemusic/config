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
    let
      common =
        system:
        import ./common.nix {
          inherit inputs system;
        };
    in
    {
      darwinConfigurations."vixen" =
        let
          system = "aarch64-darwin";
        in
        nix-darwin.lib.darwinSystem {
          modules = [
            ./hosts/vixen/configuration.nix
            (common system)
          ];
        };

      darwinConfigurations."kitsune" =
        let
          system = "aarch64-darwin";
        in
        nix-darwin.lib.darwinSystem {
          modules = [
            ./hosts/kitsune/configuration.nix
            (common system)
          ];
        };

      nixosConfigurations."tanuki" =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/tanuki/configuration.nix
            (common system)
          ];
        };

      nixosConfigurations."lovelace" =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/lovelace/configuration.nix
            (common system)
          ];
        };
    };
}

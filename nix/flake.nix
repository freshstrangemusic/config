{
  description = "system configuration flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      nixpkgs,
    }:
    {
      darwinConfigurations."vixen" = nix-darwin.lib.darwinSystem {
        modules = [ ./hosts/vixen/configuration.nix ];
      };

      nixosConfigurations."tanuki" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tanuki/configuration.nix ];
      };
    };
}

{
  description = "tanuki home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      configuration =
        {
          pkgs,
          config,
          lib,
          ...
        }:
        {
          home.username = "beth";
          home.homeDirectory = "/home/beth";

          home.stateVersion = "24.05";
          home.packages = with pkgs; [
            any-nix-shell
            eza
            jujutsu
            just
            neovim
            nixfmt-rfc-style
            ripgrep
            vim
          ];

          programs.home-manager.enable = true;
        };
    in
    {
      homeConfigurations."tanuki" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ configuration ];
      };
    };
}

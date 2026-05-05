# Common configuration between all nix hosts.

{
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "1password-cli"
  ];

  nixpkgs.overlays = [
    inputs.patisserie.overlays.${system}.default
    (final: prev: {
      flake-updated = pkgs.callPackage ../packages/flake-updated { };
    })
  ];

  environment.systemPackages = with pkgs; [
    any-nix-shell
    delta
    eza
    fish
    flake-updated
    git
    gnumake
    jujutsu
    just
    nixfmt
    nodejs_24
    patisserie
    pipx
    poetry
    python313
    ripgrep
    stow
    uv
    vim
    wget
    zellij
  ];

  # Require a git (or colocated jujutsu) checkout. If there is no git repository
  # present, these attributes will not exist and the rebuild will fail.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;
}

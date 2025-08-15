# Common configuration between all nix hosts.

{
  pkgs,
  system,
  inputs,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.overlays = [
    inputs.patisserie.overlays.${system}.default
    (final: prev: {
      flake-updated = pkgs.callPackage ../packages/flake-updated { };
    })
  ];

  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    fish
    delta
    direnv
    flake-updated
    git
    gnumake
    jujutsu
    just
    nixfmt-rfc-style
    patisserie
    ripgrep
    stow
    vim
    wget
  ];

  # Require a git (or colocated jujutsu) checkout. If there is no git repository
  # present, these attributes will not exist and the rebuild will fail.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;
}

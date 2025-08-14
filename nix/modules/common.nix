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
}

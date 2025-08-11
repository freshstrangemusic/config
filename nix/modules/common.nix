# Common configuration between all nix hosts.

{
  pkgs,
  system,
  inputs,
  ...
}:
let
  overlay = final: prev: {
    patisserie = inputs.patisserie.defaultPackage.${system};
  };
in
{
  nixpkgs.overlays = [ overlay ];
  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    fish
    delta
    direnv
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

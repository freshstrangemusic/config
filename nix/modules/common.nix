# Common configuration between all nix hosts.

{
  pkgs,
  system,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [ inputs.patisserie.overlays.${system}.default ];
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

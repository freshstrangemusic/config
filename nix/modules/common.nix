# Common configuration between all nix hosts.

{
  inputs,
  pkgs,
  system,
  ...
}:
{
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
    ripgrep
    stow
    vim
    wget

    inputs.patisserie.defaultPackage.${system}
  ];
}

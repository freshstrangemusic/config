{
  inputs,
  system,
}:
{
  pkgs,
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

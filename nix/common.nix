{
  pkgs,
  ...
}: {
  systemPackages = with pkgs; [
    any-nix-shell
    eza
    fish
    git
    jujutsu
    just
    nixfmt-rfc-style
    ripgrep
    stow
    vim
    wget
  ];
}

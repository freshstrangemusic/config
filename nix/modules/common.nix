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

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];

  nixpkgs.overlays = [
    inputs.patisserie.overlays.${system}.default
    (final: prev: {
      flake-updated = pkgs.callPackage ../packages/flake-updated { };
      rust-analyzer-wrapper = pkgs.callPackage ../packages/rust-analyzer-wrapper { };
    })
  ];

  environment.systemPackages = with pkgs; [
    any-nix-shell
    delta
    direnv
    eza
    fish
    flake-updated
    git
    gnumake
    jujutsu
    just
    just-lsp
    nixd
    nixfmt
    neovim
    nodejs_24
    patisserie
    pipx
    poetry
    python313
    ripgrep
    rust-analyzer-wrapper
    rustup
    stow
    uv
    wget
    zellij
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
  environment.shellAliases = {
    vim = "nvim";
  };

  programs.direnv.enable = true;

  # Require a git (or colocated jujutsu) checkout. If there is no git repository
  # present, these attributes will not exist and the rebuild will fail.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;
}

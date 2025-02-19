{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./wsl.nix ];

  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    fish
    git
    jujutsu
    just
    nixfmt-rfc-style
    nodejs_23
    python313
    ripgrep
    stow
    vim
    wget
  ];

  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  networking.hostName = "lovelace";

  services.envfs.enable = true;

  users.groups.beth = { };
  users.users.beth = {
    isNormalUser = true;
    description = "beth";
    extraGroups = [
      "beth"
      "users"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  system.stateVersion = "24.11";
}

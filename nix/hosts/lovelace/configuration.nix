{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./wsl.nix ];

  environment.systemPackages = with pkgs; [
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
  environment.variables = {
    EDITOR = "vim";
  };

  programs.nix-ld.enable = true;

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
  };

  system.stateVersion = "24.11";
}

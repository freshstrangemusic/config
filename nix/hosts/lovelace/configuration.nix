{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nodejs_24
    python313
  ];

  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  networking.hostName = "lovelace";

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

  wsl = {
    enable = true;
    defaultUser = "beth";
  };

  # nixos-wsl disables this.
  security.sudo.wheelNeedsPassword = true;

  system.stateVersion = "24.11";
}

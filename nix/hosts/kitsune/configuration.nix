self@{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alacritty
    fastmod
    fira-code
    gnused
    poetry
    vlc-bin
  ];

  fonts.packages = with pkgs; [ pkgs.fira-code ];

  networking.computerName = "kitsune";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "beth";
  users.knownUsers = [ "beth" ];
  users.users.beth = {
    uid = 501;
    shell = pkgs.fish;
  };
}

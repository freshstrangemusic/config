self@{
  pkgs,
  config,
  lib,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    _1password-cli
    alacritty
    fastmod
    fira-code
    gnused
    watchman
    vlc-bin
  ];

  fonts.packages = with pkgs; [ pkgs.fira-code ];

  networking.computerName = "vixen";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "beth";
  users.knownUsers = [ "beth" ];
  users.users.beth = {
    uid = 501;
    shell = pkgs.fish;
  };
}

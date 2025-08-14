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
    poetry
    python311Packages.pipx
    watchman
    vlc-bin
  ];

  fonts.packages = with pkgs; [ pkgs.fira-code ];

  networking.computerName = "vixen";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

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

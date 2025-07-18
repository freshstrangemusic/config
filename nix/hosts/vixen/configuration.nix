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

  nix.enable = false;
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Replace the default /Applications/Nix Apps symlink with a directory
  # containing copies of the installed apps.
  #
  # This allows them to show up in Spotlight and Alfred.
  system.activationScripts.applications.text = lib.mkForce (''
    __NIX_APPS_DIR="/Applications/Nix Apps"
    echo "Setting up my $__NIX_APPS_DIR..." >&2

    if [ -L "$__NIX_APPS_DIR" ]; then
      echo "Unlinking $__NIX_APPS_DIR" >&2
      unlink -- "$__NIX_APPS_DIR"
    elif [ -d "$__NIX_APPS_DIR" ]; then
      echo "Removing existing Nix Apps directory" 2>&1
      rm -rf -- "$__NIX_APPS_DIR";
    fi

    mkdir "/Applications/Nix Apps"

    find "${config.system.build.applications}/Applications" -maxdepth 1 -type l -exec cp -Lr {} "/Applications/Nix Apps" \;
  '');

  users.knownUsers = [ "beth" ];
  users.users.beth = {
    uid = 501;
    shell = pkgs.fish;
  };
}

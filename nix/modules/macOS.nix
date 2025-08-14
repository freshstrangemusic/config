# Common configuration between all macOS hosts.

{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      macOSUpdateNotify = pkgs.callPackage ../packages/macOS-update-notify { };
    })
  ];

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  launchd.user.agents.macOSUpdateNotify = {
    command = "${pkgs.macOSUpdateNotify}/bin/macOS-update-notify";
    serviceConfig = {
      RunAtLoad = true;
      StartInterval = 3600;
    };
  };

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
}

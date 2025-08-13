{
  pkgs,
  ...
}:
let
  name = "macOS-update-notify";
  macOSUpdateNotify = pkgs.writeShellApplication {
    inherit name;

    runtimeInputs = with pkgs; [
      coreutils
      terminal-notifier
    ];

    text = builtins.readFile ./macOS-update-notify.sh;
  };
in
{
  environment.systemPackages = [ macOSUpdateNotify ];
  launchd.user.agents.macOSUpdateNotify = {
    command = "${macOSUpdateNotify}/bin/macOS-update-notify";
    serviceConfig = {
      RunAtLoad = true;
      StartInterval = 3600;
    };
  };
}

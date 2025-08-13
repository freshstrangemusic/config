{
  terminal-notifier,
  flake-updated,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "macOS-update-notify";

  runtimeInputs = [
    flake-updated
    terminal-notifier
  ];

  text = builtins.readFile ./macOS-update-notify.sh;
}

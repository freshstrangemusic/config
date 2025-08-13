{
  coreutils,
  jq,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "flake-updated";

  runtimeInputs = [
    coreutils
    jq
  ];

  text = builtins.readFile ./flake-updated.sh;
}

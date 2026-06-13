{
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "rust-analyzer-wrapper";

  text = builtins.readFile ./rust-analyzer-wrapper.sh;
}

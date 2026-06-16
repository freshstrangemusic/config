# `rust-analyzer-wrapper`

A wrapper script to invoke `rust-analyzer` inside a specific nix shell. This is really only useful
if you use VSCode with the Remote-SSH extension, since you cannot start the remote `vscode-server`
inside the Nix shell.

## Usage

### With flake.nix

Configure VSCode to use `rust-analyzer-wrapper` and set the `RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH`
environment variable to directory containing flake.nix, e.g.:

```json
"rust-analyzer.server.path": "rust-analyzer-wrapper",
"rust-analyzer.server.extraEnv": {
    "RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH": "${userHome}/nix-flake", // ~/nix-flake/flake.nix
}
```

### With shell.nix
Configure VSCode to use `rust-analyzer-wrapper` and set the `RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH`
environment variable to the path containing `shell.nix`, e.g.:

```json
"rust-analyzer.server.path": "rust-analyzer-wrapper",
"rust-analyzer.server.extraEnv": {
    "RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH": "${userHome}/nix-shell", // ~/nix-shell/shell.nix
}
```

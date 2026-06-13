# `rust-analyzer-wrapper`

A wrapper script to invoke `rust-analyzer` inside a specific Nix shell. This is
really only useful if you use VSCode with the Remote-SSH extension, since you
cannot start the remote `vscode-server` inside the Nix shell.

## Usage

Configure VSCode to use `rust-analyzer-wrapper` and set the
`RUST_ANALYZER_WRAPPER_NIX_SHELLPATH` to the path containing `shell.nix`, e.g.:

```
"rust-analyzer.server.path": "rust-analyzer-wrapper",
"rust-analyzer.server.extraEnv": {
    "RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH": "${userHome}/Workspace/src/github.com/freshstrangemusic/config/environments/application-services",
}
```

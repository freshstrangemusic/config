# config

This repository contains my system configuration. It makes a lot of assumptions and as such won't
necessarily work in your environment.

It must be checked out at
`$HOME/Workspace/src/github.com/freshstrangemusic/config` because it contains
relative symlinks up into `$HOME` (e.g.,
`dotfiles/layers/macOS/Library/Application Support/pypoetry`).

## Directory structure


### Justfile

This repository uses [just][just] as the task runner. It has the following
tasks:

- **`install-dotfiles`**: install dotfiles with `stow`
- **`uninstall-dotfiles`**: uninstall dotfiles with `stow`
- **`rebuild`**: rebuild the nix environment (with `darwin-rebuild` on macOS and `nixos-rebuild` on
  NixOS); the bookmark for the current host will be moved to the latest non-empty commit
- **`nix-flake-update`**: update the nix flake
- **`edit-host-configuration`**: open the `configuration.nix` for the current host in `$EDITOR`
- **`fmt`**: format all nix files in the tree with `nixfmt`.


### `dotfiles/`

My dotfiles, organized into layers that apply on top of each other:

- **`base`**: the base layer, which is common to all systems;
- **`macOS`**: a layer that contains macOS-specific configuration (and symlinks from macOS-specific
  locations to Linux / XDG Home Specification locations);
- **`windows`**: a layer that contains Windows-specific configuration (this layer is not
  automatically linked); and
- **`wsl`**: a layer that contains WSL-specific configuration.

The dotfiles are managed with [GNU stow][stow].


### `nix/`

My nix configuration:

- **`flake.nix`**: the main flake and entry-point into the configuration;
- **`hosts/`**: per-host configuration;
- **`modules/`**: common configuration refactored out to be re-used across
  multiple hosts;
- **`packages/`**: custom packages:
  - **`flake-updated`**: A tool that checks if the nixpkgs timestamp in your
    flake.lock is recent (< 1 week).
  - **`macOS-update-notify`**: use `terminal-notifier` and `flake-updated` to
    inform you if your flake is up-to-date.
  - **`rust-analyzer-wrapper`**: a wrapper script for launching rust-analyzer
    inside of `nix-shell`.
    [Read more](./nix/packages/rust-analyzer-wrapper/README.md).


### `environments/`

Workspace configuration that cannot be committed to repositories for one reason
or another (e.g., they are a work repository with no Nix buy-in from other
developers). These environments are packaged as combinations of VSCode
Workspaces and nix shells.


### `bin/`

Scripts and utilities that are used from this repository and not installed globally:

- **`bootstrap.sh`**: a script to bootstrap the configuration of a nix environment on a new machine.

  To configure a new machine with the name `HOSTNAME`, run:

  ```sh
  curl --proto '=https' \
       --tlsv1.2 \
       -sSf \
       -L \
       https://raw.githubusercontent.com/freshstrangemusic/config/main/bin/bootstrap.sh | \
    /usr/bin/env bash -- -H HOSTNAME
  ```

[just]: https://github.com/casey/just
[stow]: https://www.gnu.org/software/stow/stow.html

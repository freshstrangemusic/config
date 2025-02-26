# config

This repository contains my system configuration. It makes a lot of assumptions and as such won't
necessarily work in your environment.

It must be checked out at `$HOME/Workspace/src/github.com/brennie/config` because it contains
relative symlinks up into `$HOME` (e.g.,
`dotfiles/layers/macOS/Library/Application Support/pypoetry`).

## Directory structure

### Justfile

This repository uses [just][just] as the task runner. It has the following
tasks:

- **install-dotfiles**: install dotfiles with `stow`
- **uninstall-dotfiles**: uninstall dotfiles with `stow`
- **rebuild**: rebuild the nix environment (with `darwin-rebuild` on macOS and `nixos-rebuild` on
  NixOS); the bookmark for the current host will be moved to the latest non-empty commit
- **nix-flake-update**: update the nix flake
- **edit-host-configuration**: open the `configuration.nix` for the current host in `$EDITOR`

### dotfiles/

My dotfiles, organized into layers that apply on top of each other:

- **base**: the base layer, which is common to all systems;
- **macOS**: a layer that contains macOS-specific configuration (and symlinks from macOS-specific
  locations to Linux / XDG Home Specification locations);
- **windows**: a layer that contains Windows-specific configuration (this layer is not
  automatically linked);
- **wsl**: a layer that contains WSL-specific configuration.

The dotfiles are managed with [GNU stow][stow].

### nix/

My nix configuration.

### bootstrap.sh

A script to bootstrap the configuration of a nix environment on a new machine.  To configure a new
machine with the name `HOSTNAME`, run:

```sh
curl --proto '=https' \
     --tlsv1.2 \
     -sSf \
     -L \
     https://raw.githubusercontent.com/freshstrangemusic/config/main/bootstrap.sh | \
  /bin/bash -- -H HOSTNAME
```

[just]: https://github.com/casey/just
[stow]: https://www.gnu.org/software/stow/stow.html

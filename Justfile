set shell := ["/usr/bin/env", "bash", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-c"]

hostname := `hostname`
rebuild_cmd := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }
op_cmd := if os_family() == "windows" { "op.exe" } else if x'${WSL_DISTRO_NAME:-}' != "" { "op.exe" } else { "op" }

default:
    @just --list

install-dotfiles:
    ./bin/install-dotfiles {{ os() }}

uninstall-dotfiles:
    ./bin/uninstall-dotfiles {{ os() }}

rebuild:
    cd nix && sudo {{ rebuild_cmd }} switch --flake .#{{ hostname }}
    jj bookmark set hosts/{{ hostname }} --to 'latest(::@ & ~empty())' --allow-backwards

edit-host-configuration:
    $EDITOR -- ./nix/hosts/{{ hostname }}/configuration.nix

nix-flake-update:
    cd nix && eval $({{ op_cmd }} signin) && env NIX_CONFIG="access-tokens = github.com=`{{ op_cmd }} item get gh-token-nix --fields password --reveal`" nix flake update

fmt:
    rg --files -g '*.nix' . | xargs nixfmt

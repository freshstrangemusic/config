set shell := ["/bin/bash", "-c"]

hostname := `hostname`
rebuild_cmd := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }

default:
    @just --list

install-dotfiles:
    stow -t ~ -d dotfiles/layers/base .
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS .; fi

uninstall-dotfiles:
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS -D .; fi
    stow -t ~ -d dotfiles/layers/base -D .

nix-rebuild HOST=hostname:
    {{ rebuild_cmd }} switch --flake ./nix#{{HOST}}

nix-flake-update:
    cd nix && env NIX_CONFIG="access-tokens = github.com=`op item get gh-token-nix --fields password --reveal`" nix flake update

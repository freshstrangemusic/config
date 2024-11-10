set shell := ["/bin/bash", "-c"]

hostname := `hostname`

default:
    @just --list

install-dotfiles:
    stow -t ~ -d dotfiles/layers/base .
    [[ "{{ os() }}" = "macos" ]] && stow -t ~ -d dotfiles/layers/macOS . || exit 0

uninstall-dotfiles:
    [[ "{{ os() }}" = "macos" ]] && stow -t ~ -d dotfiles/layers/macOS -D . || exit 0
    stow -t ~ -d dotfiles/layers/base -D .

darwin-rebuild HOST=hostname:
    cd nix/hosts/{{ HOST }} && darwin-rebuild switch --flake .#{{ HOST }}

home-manager-switch HOST=hostname:
    cd nix/hosts/{{ HOST }} && home-manager switch --flake .#{{ HOST }}

nix-flake-update HOST=hostname:
    cd nix/hosts/{{ HOST }} && env NIX_CONFIG="access-tokens = github.com=`op item get gh-token-nix --fields password --reveal`" nix flake update

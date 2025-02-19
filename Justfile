set shell := ["/bin/bash", "-c"]

hostname := `hostname`
rebuild_cmd := if os() == "macos" { "darwin-rebuild" } else { "sudo nixos-rebuild" }
is_wsl := "-n $WSL_DISTRO_NAME"

default:
    @just --list

install-dotfiles:
    stow -t ~ -d dotfiles/layers/base .
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS .; fi
    if [[ {{ is_wsl }} ]]; then stow -t ~ -d dotfiles/layers/wsl .; fi

uninstall-dotfiles:
    if [[ {{ is_wsl }} ]]; then stow -t ~ -d dotfiles/layers/wsl -D .; fi
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS -D .; fi
    stow -t ~ -d dotfiles/layers/base -D .

rebuild:
    {{ rebuild_cmd }} switch --flake ./nix#{{ hostname }}
    jj bookmark m {{ hostname }} --to 'latest(::@ & ~empty())' --allow-backwards

edit-host-configuration:
    $EDITOR -- ./nix/hosts/{{ hostname }}/configuration.nix

nix-flake-update:
    cd nix && env NIX_CONFIG="access-tokens = github.com=`op item get gh-token-nix --fields password --reveal`" nix flake update

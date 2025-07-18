set shell := ["/usr/bin/env", "bash", "-c"]

hostname := `hostname`
rebuild_cmd := if os() == "macos" { "darwin-rebuild" } else { "nixos-rebuild" }
is_wsl := "-n $WSL_DISTRO_NAME"

default:
    @just --list

install-dotfiles:
    if [[ -f ~/.config/fish/config.fish ]]; then rm -rf -- ~/.config/fish; fi
    mkdir -p ~/.ssh/config.d
    mkdir -p ~/.config/fish/functions
    stow -t ~ -d dotfiles/layers/base .
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS .; fi
    if [[ {{ is_wsl }} ]]; then stow -t ~ -d dotfiles/layers/wsl .; fi

uninstall-dotfiles:
    if [[ {{ is_wsl }} ]]; then stow -t ~ -d dotfiles/layers/wsl -D .; fi
    if [[ "{{ os() }}" = "macos" ]]; then stow -t ~ -d dotfiles/layers/macOS -D .; fi
    stow -t ~ -d dotfiles/layers/base -D .

rebuild:
    cd nix && sudo {{ rebuild_cmd }} switch --flake .#{{ hostname }}
    jj bookmark set hosts/{{ hostname }} --to 'latest(::@ & ~empty())' --allow-backwards

edit-host-configuration:
    $EDITOR -- ./nix/hosts/{{ hostname }}/configuration.nix

nix-flake-update:
    cd nix && env NIX_CONFIG="access-tokens = github.com=`op item get gh-token-nix --fields password --reveal`" nix flake update

fmt:
    rg --files -g '*.nix' . | xargs nixfmt

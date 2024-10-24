install-dotfiles:
    stow -t ~ -d dotfiles/layers/base .

uninstall-dotfiles:
    stow -t ~ -d dotfiles/layers/base -D .

darwin-rebuild:
    darwin-rebuild switch --flake ./nixpkgs#vixen

nix-flake-update:
    cd nixpkgs && env NIX_CONFIG="access-tokens = github.com=`op item get gh-token-nix --fields password --reveal`" nix flake update

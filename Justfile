install-dotfiles:
    stow -t ~ -d dotfiles .

darwin-rebuild:
    darwin-rebuild switch --flake ./nixpkgs
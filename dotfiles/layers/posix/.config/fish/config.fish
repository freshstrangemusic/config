set -gx LESS FRX

fish_add_path ~/.local/bin

alias ls eza

any-nix-shell fish --info-right | source
COMPLETE=fish jj | source


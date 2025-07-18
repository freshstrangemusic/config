set -gx EDITOR vim
set -gx LESS FRX

fish_add_path ~/.local/bin

alias ls eza

any-nix-shell fish --info-right | source
jj util completion fish | source

set -gx EDITOR vim
set -gx LESS FRX

alias ls eza

any-nix-shell fish --info-right | source
jj util completion fish | source

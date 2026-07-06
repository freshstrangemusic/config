set -gx LESS FRX
set -gx CARGO_INSTALL_ROOT ~/.local

fish_add_path ~/.local/bin

alias ls eza

any-nix-shell fish --info-right | source
COMPLETE=fish jj | source
proj completions fish | source


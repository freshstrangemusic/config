set -gx EDITOR vim
set -gx LESS FRX
set -gx LOCALE_ARCHIVE /lib/locale/locale-archive

alias ls eza

any-nix-shell fish --info-right | source
jj util completion fish | source


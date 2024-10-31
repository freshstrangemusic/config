set -gx EDITOR vim
set -gx SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

alias ls eza

any-nix-shell fish --info-right | source
jj util completion fish | source

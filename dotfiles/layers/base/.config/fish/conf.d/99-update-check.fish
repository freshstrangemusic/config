# Print a warning if flake.lock has not been updated in over a week.

set _CHECKOUT "$HOME/Workspace/src/github.com/freshstrangemusic/config"

if ! flake-updated "$_CHECKOUT/nix/flake.lock"
    echo "⚠️ Update Required: flake.lock is over one week old️"
end

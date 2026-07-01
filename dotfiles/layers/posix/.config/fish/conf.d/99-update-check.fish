# Print a warning if flake.lock has not been updated in over a week.

if ! flake-updated "$_FSM_CONFIG_CHECKOUT/nix/flake.lock"
    echo "⚠️ Update Required: flake.lock is over one week old️"
end

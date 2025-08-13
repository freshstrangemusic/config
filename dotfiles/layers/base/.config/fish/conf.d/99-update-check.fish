# Print a warning if flake.lock has not been updated in over a week.

set _SCRIPT_PATH (realpath ~/.config/fish/conf.d/99-update-check.fish)
set _CONFIG_DIR (realpath (dirname $_SCRIPT_PATH)/../../../../../..)
set _LAST_UPDATE (stat --format=%Y $_CONFIG_DIR/nix/flake.lock)
set _NOW (date +%s)
set _DELTA (math $_NOW - $_LAST_UPDATE)

if [ $_DELTA -gt (math '24 * 60 * 60') ]
    echo "⚠️ Update Required: flake.lock is over one week old️"
end

CHECKOUT="${HOME}/Workspace/src/github.com/freshstrangemusic/config"
LAST_UPDATE=$(stat --format=%Y "${CHECKOUT}/nix/flake.lock")
NOW=$(date +%s)
DELTA=$((NOW - LAST_UPDATE))
ONE_WEEK=$((24 * 60 * 60))

if [[ $DELTA -gt $ONE_WEEK ]]; then
    terminal-notifier \
        -ignoreDnD \
        -title "⚠️ Update Required️" \
        -message "flake.lock is over one week old"
fi

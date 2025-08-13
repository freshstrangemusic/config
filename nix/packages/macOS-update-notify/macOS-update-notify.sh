CHECKOUT="${HOME}/Workspace/src/github.com/freshstrangemusic/config"

if ! flake-updated "${CHECKOUT}/nix/flake.lock"; then
    terminal-notifier \
        -ignoreDnD \
        -title "⚠️ Update Required️" \
        -message "flake.lock is over one week old"
fi

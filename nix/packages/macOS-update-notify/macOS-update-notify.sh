if [[ $# -eq 0 ]] || [[ $# -gt 1 ]]; then
  echo "USAGE: $0 flake.lock" >&2
  exit 2
fi

if ! flake-updated "${1}"; then
  terminal-notifier \
    -ignoreDnD \
    -title "⚠️ Update Required" \
    -message "flake.lock is over one week old"
fi

if [[ $# -eq 0 ]] || [[ $# -gt 1 ]]; then
  echo "USAGE: $0 flake.lock" >&2
  exit 2
fi

LOCK_PATH="$1"
NIXPKGS_LAST_MODIFIED=$(jq < "$LOCK_PATH" .nodes.nixpkgs.locked.lastModified)
NOW=$(date +%s)
DELTA=$((NOW - NIXPKGS_LAST_MODIFIED))

# nixpkgs-weekly is two weeks behind nixpkgs-unstable, so we actually need to
# check if the lastModified is *three* weeks out of date.
ONE_WEEK=$((3 * 7 * 24 * 60 * 60))

exit $((DELTA >= ONE_WEEK))

set -euo pipefail

if [[ -z "${RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH:-}" ]]; then
  PROGRAM=$(basename "${0}")
  echo "${PROGRAM}: no shell.nix found" >&2
  echo "${PROGRAM}: you must set RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH" >&2
  exit 1
fi

exec nix-shell "${RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH}" --command rust-analyzer "$@"

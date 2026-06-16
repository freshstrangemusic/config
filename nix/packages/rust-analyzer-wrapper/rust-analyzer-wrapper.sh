RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH="${RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH:-.}"
RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH="${RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH:-.}"

if [[ -e "${RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH}/flake.nix" ]]; then
  exec nix develop "${RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH}" --command rust-analyzer "$@"
elif [[ -e "${RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH}/shell.nix" ]]; then
  exec nix-shell "${RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH}" --command rust-analyzer "$@"
else
  PROGRAM=$(basename "${0}")
  echo "${PROGRAM}: no flake.nix or shell.nix found" >&2
  echo "${PROGRAM}: you must set RUST_ANALYZER_WRAPPER_NIX_SHELL_PATH or RUST_ANALYZER_WRAPPER_NIX_FLAKE_PATH" >&2
  exit 1
fi

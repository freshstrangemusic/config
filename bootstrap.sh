#!/bin/bash
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

REPOSITORY_URL="https://github.com/freshstrangemusic/config"
CHECKOUT_PATH="${HOME}/Workspace/src/github.com/freshstrangemusic/config"

usage() {
  cat << EOF
bootstrap.sh - bootstrap a new development machine

usage: bootstrap.sh [OPTIONS]

options:
  -h                    Show this help and exit
  -H HOSTNAME           Use as the hostname
  -R REPOSITORY_URL     Use an alternate repository URL
                        [Default: ${REPOSITORY_URL}]
  -C CHECKOUT_PATH      Use an alternate checkout path
                        [Default: ${CHECKOUT_PATH}]
EOF
}

OS=$(uname)

while getopts "hH:C:" ARG; do
  case $ARG in
    H)
      HOSTNAME="${OPTARG}"
      ;;

    R)
      REPOSITORY_URL="${OPTARG}"
      ;;

    C)
      CHECKOUT_PATH="${OPTARG}"
      ;;

    h)
      usage
      exit 0
      ;;

    *)
      usage
      exit 1
      ;;
  esac
done

if [[ "${OS}" == "Darwin" ]] && ! xcode-select -p &>/dev/null; then
  xcode-select --install &>/dev/null
  echo "Installing command line developer tools..."
  until xcode-select --print-path &>/dev/null; do
    sleep 5
  done
fi

if ! which nix &>/dev/null; then
  curl --proto '=https' \
       --tlsv1.2 \
       -sSf \
       -L \
       https://install.determinate.systems/nix | \
    sh -s -- install --determinate

  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [[ ! -d "${CHECKOUT_PATH}/.jj" ]]; then
  mkdir -p $(dirname -- "${CHECKOUT_PATH}")
  nix run "nixpkgs#jujutsu" -- git clone "${REPOSITORY_URL}" "${CHECKOUT_PATH}"
fi

cd -- "${CHECKOUT_PATH}"

if [[ "${OS}" == "Darwin" ]] && [[ "$(hostname)" != "${HOSTNAME}" ]]; then
  echo "Setting hostname to '${HOSTNAME}' (was $(hostname))"
  sudo scutil --set ComputerName "${HOSTNAME}"
  sudo scutil --set LocalHostName "${HOSTNAME}"
  sudo scutil --set HostName "${HOSTNAME}"
fi

until [[ -f "./nix/hosts/${HOSTNAME}/configuration.nix" ]]; do
  echo "Nix configuration does not exist for host ${HOSTNAME}; please create it before continuing"
  read -sr -n 1 -p "Press any key to continue"
  echo
done

export NIX_CONFIG="extra-experimental-features = nix-command flakes"
if [[ "${OS}" == "Darwin" ]] && ! which nix-darwin &>/dev/null; then
  sudo nix run "nix-darwin#darwin-rebuild" -- switch --flake "./nix#${HOSTNAME}"
elif [[ "${OS}" != "Darwin" ]]; then
  sudo nixos-rebuild --switch --flake "./nix#${HOSTNAME}"
fi

just install-dotfiles

echo "Bootstrapping complete! Open a new shell to use your newly configured system."


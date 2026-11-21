#!/usr/bin/env bash
set -xeuo pipefail

if [[ ! -d "${NSS_DIR}" ]]; then
    exit 0
fi

rm -rf -- $NSS_DIR
./libs/verify-desktop-environment.sh

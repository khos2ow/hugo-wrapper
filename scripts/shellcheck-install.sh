#!/usr/bin/env bash

set -o errexit
set -o pipefail

SHELLCHECK_VERSION=v0.7.1

curl -sSLO https://github.com/koalaman/shellcheck/releases/download/"${SHELLCHECK_VERSION}"/shellcheck-"${SHELLCHECK_VERSION}".linux.x86_64.tar.xz
tar xf shellcheck-"${SHELLCHECK_VERSION}".linux.x86_64.tar.xz
sudo mv ./shellcheck-"${SHELLCHECK_VERSION}"/shellcheck /usr/local/bin
shellcheck --version

#!/usr/bin/env bash

set -o errexit
set -o pipefail

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ -z "${CURRENT_BRANCH}" -o "${CURRENT_BRANCH}" != "master" ]; then
    echo "Error: The current branch is '${CURRENT_BRANCH}', switch to 'master' to do the release."
    exit 1
fi

if [ -n "$(git status --short)" ]; then
    echo "Error: There are untracked/modified changes, commit or discard them before the release."
    exit 1
fi

RELEASE_VERSION=$1
PUSH_CHANGES=$2
CURRENT_VERSION=$3
FROM_MAKEFILE=$4

if [ -z "${RELEASE_VERSION}" ]; then
    if [ -z "${FROM_MAKEFILE}" ]; then
        echo "Error: VERSION is missing. e.g. ./release.sh <version>"
    else
        echo "Error: missing value for 'version'. e.g. 'make release VERSION=x.y.z'"
    fi
    exit 1
fi

if [ -z "${CURRENT_VERSION}" ]; then
    CURRENT_VERSION=$(git describe --tags --exact-match 2>/dev/null || git describe --tags 2>/dev/null || echo "v0.0.1-$(COMMIT_HASH)")
fi

if [ "v${RELEASE_VERSION}" = "${CURRENT_VERSION}" ]; then
    echo "Error: provided version (v${RELEASE_VERSION}) already exists."
    exit 1
fi

if [ $(git describe --tags "v${RELEASE_VERSION}" 2>/dev/null) ]; then
    echo "Error: provided version (v${RELEASE_VERSION}) already exists."
    exit 1
fi

PWD=$(cd $(dirname "$0") && pwd -P)

# get closest GA tag, ignore alpha, beta and rc tags
function getClosestVersion() {
    for t in $(git tag --sort=-creatordate); do
        tag="$t"
        if [[ $tag == *"-alpha"* || $tag == *"-beta"* || $tag == *"-rc"* ]]; then
            continue
        fi
        break
    done
    echo "$tag"
}
CLOSEST_VERSION=$(getClosestVersion)

# Bump the released version in README and version.go
sed -i -E 's|'${CLOSEST_VERSION}'|v'${RELEASE_VERSION}'|g' README.md
sed -i -E 's|v'${RELEASE_VERSION}'-alpha|v'${RELEASE_VERSION}'|g' hugow

# Commit changes
printf "\033[36m==> %s\033[0m\n" "Commit changes for release version v${RELEASE_VERSION}"
git add README.md hugow
git commit -m "Release version v${RELEASE_VERSION}"

if [ "${PUSH}" == "true" ]; then
    printf "\033[36m==> %s\033[0m\n" "Push commits for v${RELEASE_VERSION}"
    git push origin master
fi

# Tag the release
printf "\033[36m==> %s\033[0m\n" "Tag release v${RELEASE_VERSION}"
git tag --annotate --message "v${RELEASE_VERSION} Release" "v${RELEASE_VERSION}"

if [ "${PUSH}" == "true" ]; then
    printf "\033[36m==> %s\033[0m\n" "Push tag release v${RELEASE_VERSION}"
    git push origin v${RELEASE_VERSION}
fi

# Bump the next version in version.go
NEXT_VERSION=$(echo "${RELEASE_VERSION}" | sed 's/^v//' | awk -F'[ .]' '{print $1"."$2+1".0"}')
sed -i -E 's|v'${RELEASE_VERSION}'|v'${NEXT_VERSION}'-alpha|g' hugow

# Commit changes
printf "\033[36m==> %s\033[0m\n" "Bump version to v${NEXT_VERSION}-alpha"
git add hugow
git commit -m "Bump version to v${NEXT_VERSION}-alpha"

if [ "${PUSH}" == "true" ]; then
    printf "\033[36m==> %s\033[0m\n" "Push commits for v${NEXT_VERSION}-alpha"
    git push origin master
fi

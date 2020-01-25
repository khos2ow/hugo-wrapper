# Project variables
ORG         := khos2ow
NAME        := hugo-wrapper
DESCRIPTION := hugow is a POSIX-style shell script which acts as a wrapper to download and run Hugo binary.
URL         := https://github.com/khos2ow/hugo-wrapper

# Build variables
COMMIT_HASH ?= $(shell git rev-parse --short HEAD 2>/dev/null)
TAG_VERSION ?= $(shell git describe --tags --exact-match 2>/dev/null || git describe --tags 2>/dev/null || echo "v0.0.1-$(COMMIT_HASH)")

.PHONY: all
all: check

#########################
## Development targets ##
#########################
.PHONY: check
check: ## Run ShellCheck
	@ $(MAKE) --no-print-directory log-$@
	shellcheck hugow

#####################
## Release targets ##
#####################
.PHONY: release patch minor major
PATTERN =

release: VERSION ?= $(shell echo $(TAG_VERSION) | sed 's/^v//' | awk -F'[ .]' '{print $(PATTERN)}')
release: PUSH    := false
release: ## Prepare release
	@ $(MAKE) --no-print-directory log-$@
	@ ./scripts/release.sh "$(VERSION)" "$(PUSH)" "$(TAG_VERSION)" "1"

patch: PATTERN = '\$$1\".\"\$$2\".\"\$$3+1'
patch: release ## Prepare Patch release

minor: PATTERN = '\$$1\".\"\$$2+1\".0\"'
minor: release ## Prepare Minor release

major: PATTERN = '\$$1+1\".0.0\"'
major: release ## Prepare Major release

####################################
## Self-Documenting Makefile Help ##
####################################
.PHONY: help
help:
	@ grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

log-%:
	@ grep -h -E '^$*:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m==> %s\033[0m\n", $$2}'

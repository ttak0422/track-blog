TRACK_SRC ?= .track-engine
SITE_OUT ?= deploy
SITE_CACHE ?= .site-cache
SITE_BASE ?= /
SITE_ORIGIN ?= https://blog.taktak.dev
SITE_SHARE ?= true

SITE_OUT_PATH := $(abspath $(SITE_OUT))
SITE_CACHE_PATH := $(abspath $(SITE_CACHE))

.PHONY: site

site:
	@test -f "$(TRACK_SRC)/flake.nix" || (echo "$(TRACK_SRC) must contain a checkout of ttak0422/track" >&2; exit 1)
	nix develop "$(TRACK_SRC)" --command bash -euo pipefail -c 'make -C "$(TRACK_SRC)" site SITE_VAULT="$(CURDIR)" SITE_OUT="$(SITE_OUT_PATH)" SITE_CACHE="$(SITE_CACHE_PATH)" SITE_BASE="$(SITE_BASE)" SITE_ORIGIN="$(SITE_ORIGIN)" SITE_SHARE="$(SITE_SHARE)"'

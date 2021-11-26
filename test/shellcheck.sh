#!/bin/sh
set -eu
git -C /srv/deploy/Buildpack ls-files | grep -F '.sh' | sort | xargs \
	shellcheck --check-sourced --color=auto --norc --shell=sh --severity=warning
exit 0

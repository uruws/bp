#!/bin/sh
set -eu

upgrd="${UWSREPO}/docker/upgrades.py"

if ! test -x "${upgrd}"; then
	echo "${upgrd}: file not found" >&2
	exit 1
fi

# uws/buildpack:base
${upgrd} -t uws/buildpack:base

# uws/buildpack:devel
${upgrd} -t uws/buildpack:devel -U docker/devel -s uws/python
${upgrd} -t uws/buildpack:devel

exit 0

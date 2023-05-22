#!/bin/sh
set -eu

echo "uws: ${UWSREPO}"
upgrd="${UWSREPO}/docker/upgrades.py"

if ! test -x "${upgrd}"; then
	echo "${upgrd}: file not found" >&2
	exit 1
fi

# uws/buildpack:base
${upgrd} -t uws/buildpack:base

exit 0

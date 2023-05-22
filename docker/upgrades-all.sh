#!/bin/sh
set -eu

upgrd="${UWSREPO}/docker/upgrades.py"

if ! test -x "${upgrd}"; then
	echo "${upgrd}: file not found" >&2
	exit 1
fi

# uws/buildpack:base
${upgrd} -t uws/buildpack:base -U docker/base
${upgrd} -t uws/buildpack:base

# uws/buildpack:devel
${upgrd} -t uws/buildpack:devel -s uws/python -U docker/devel
${upgrd} -t uws/buildpack:devel

# uws/meteor
${upgrd} -t uws/meteor -s uws/buildpack:base -U docker/meteor
${upgrd} -t uws/meteor

# uws/meteor:devel
${upgrd} -t uws/meteor:devel -s uws/meteor -U docker/meteor-devel
${upgrd} -t uws/meteor:devel

exit 0

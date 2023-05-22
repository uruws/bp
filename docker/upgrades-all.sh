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

# uws/meteor
${upgrd} -t uws/meteor -U docker/meteor -s uws/buildpack:base
${upgrd} -t uws/meteor

# uws/meteor:devel
${upgrd} -t uws/meteor:devel -U docker/meteor-devel -s uws/meteor
${upgrd} -t uws/meteor:devel

exit 0

#!/bin/sh
set -eu
if test 'X0' = "X$(id -u)"; then
	echo "do not run as root!" >&2
	exit 1
fi
# base
docker build "$@" --rm -t uws/buildpack:base ./docker/base
# base-2109
docker build "$@" --rm -t uws/buildpack:base-2109 \
	-f docker/base/Dockerfile.2109 \
	./docker/base
exit 0

#!/bin/sh
set -eu
if test 'X0' = "X$(id -u)"; then
	echo "do not run as root!" >&2
	exit 1
fi
# base-2203
docker build "$@" --rm -t uws/buildpack:base-2203 \
	-f docker/base/Dockerfile.2203 \
	./docker/base
exit 0

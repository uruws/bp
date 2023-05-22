#!/bin/sh
set -eu
if test 'X0' = "X$(id -u)"; then
	echo "do not run as root!" >&2
	exit 1
fi
# base-2203
docker rmi uws/buildpack:base-2203
# base-2211
docker build "$@" --rm -t uws/buildpack:base-2211 \
	-f docker/base/Dockerfile.2211 \
	./docker/base
# base-2305
docker build "$@" --rm -t uws/buildpack:base-2305 \
	-f docker/base/Dockerfile.2305 \
	./docker/base
exit 0

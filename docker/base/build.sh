#!/bin/sh
set -eu
if test 'X0' = "X$(id -u)"; then
	echo "do not run as root!" >&2
	exit 1
fi
# remove old
docker rmi uws/buildpack:base-2211 || true
# base-2305
docker build --rm -t uws/buildpack:base-2305 \
	-f docker/base/Dockerfile.2305 \
	./docker/base
# base-2309
docker build --rm -t uws/buildpack:base-2309 \
	-f docker/base/Dockerfile.2309 \
	./docker/base
exit 0

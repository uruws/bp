#!/bin/sh
set -eu
# remove old versions
docker rmi uws/buildpack:devel-2211 || true
# uws/buildpack:devel-2305
docker build --platform=linux/amd64 --rm -t uws/buildpack:devel-2305 \
	-f docker/devel/Dockerfile.2305 \
	./docker/devel
exit 0

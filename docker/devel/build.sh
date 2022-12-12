#!/bin/sh
set -eu
# remove old versions
docker rmi uws/buildpack:devel-2109 || true
# uws/buildpack:devel-2203
docker build --rm -t uws/buildpack:devel-2203 \
	-f docker/devel/Dockerfile.2203 \
	./docker/devel
# uws/buildpack:devel-2211
docker build --rm -t uws/buildpack:devel-2211 \
	-f docker/devel/Dockerfile.2211 \
	./docker/devel
exit 0

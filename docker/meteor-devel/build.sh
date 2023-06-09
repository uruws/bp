#!/bin/sh
set -eu
# remove old versions
docker rmi uws/meteor:devel-2211 || true
docker rmi uws/meteor:devel-2305 || true
# uws/meteor:devel
docker build --rm -t uws/meteor:devel \
	-f docker/meteor-devel/Dockerfile \
	./docker/meteor-devel
exit 0

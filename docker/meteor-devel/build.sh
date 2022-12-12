#!/bin/sh
set -eu
# remove old versions
docker rmi uws/meteor:devel-2109 || true
# uws/meteor:devel-2203
docker build --rm -t uws/meteor:devel-2203 \
	-f docker/meteor-devel/Dockerfile.2203 \
	./docker/meteor-devel
# uws/meteor:devel-2211
docker build --rm -t uws/meteor:devel-2211 \
	-f docker/meteor-devel/Dockerfile.2211 \
	./docker/meteor-devel
exit 0

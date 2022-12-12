#!/bin/sh
set -eu
# remove old versions
docker rmi uws/meteor-2109 || true
# uws/meteor-2203
docker build --rm -t uws/meteor-2203 \
	-f docker/meteor/Dockerfile.2203 \
	./docker/meteor
# uws/meteor-2211
docker build --rm -t uws/meteor-2211 \
	-f docker/meteor/Dockerfile.2211 \
	./docker/meteor
exit 0

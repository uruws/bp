#!/bin/sh
set -eu
# remove old versions
docker rmi uws/meteor-2211 || true
# uws/meteor-2305
docker build --platform=linux/amd64 --rm -t uws/meteor-2305 \
	-f docker/meteor/Dockerfile.2305 \
	./docker/meteor
exit 0

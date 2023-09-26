#!/bin/sh
set -eu
# remove old versions
docker rmi uws/meteor-2211 || true
# uws/meteor-2305
docker build --rm -t uws/meteor-2305 \
	-f docker/meteor/Dockerfile.2305 \
	./docker/meteor
# uws/meteor-2309
docker build --rm -t uws/meteor-2309 \
	-f docker/meteor/Dockerfile.2309 \
	./docker/meteor
exit 0

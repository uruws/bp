#!/bin/sh
set -eu
# 2.6-2203
docker build "$@" --rm -t uws/meteor:2.6-2203 \
	-f docker/meteor-2.6/Dockerfile.2203 \
	./docker/meteor-2.6
exit 0

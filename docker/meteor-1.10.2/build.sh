#!/bin/sh
set -eu
# 1.10.2-2203
docker build "$@" --rm -t uws/meteor:1.10.2-2203 \
	-f ./docker/meteor-1.10.2/Dockerfile.2203 \
	./docker/meteor-1.10.2
exit 0

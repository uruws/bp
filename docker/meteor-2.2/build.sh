#!/bin/sh
set -eu
# 2.2
#docker build "$@" --rm -t uws/meteor:2.2 \
#	-f docker/meteor-2.2/Dockerfile \
#	./docker/meteor-2.2
docker rmi uws/meteor:2.2 || true
# 2.2-2203
docker build "$@" --rm -t uws/meteor:2.2-2203 \
	-f docker/meteor-2.2/Dockerfile.2203 \
	./docker/meteor-2.2
exit 0

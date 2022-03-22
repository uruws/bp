#!/bin/sh
set -eu
exec docker build "$@" --rm -t uws/meteor:devel \
	-f docker/meteor-devel/Dockerfile.2203 \
	./docker/meteor-devel

#!/bin/sh
set -eu
exec docker build "$@" --rm -t uws/meteor-2203 \
	-f docker/meteor/Dockerfile.2203 \
	./docker/meteor

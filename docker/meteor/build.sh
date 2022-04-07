#!/bin/sh
set -eu
exec docker build "$@" --rm -t uws/meteor \
	-f docker/meteor/Dockerfile.2203 \
	./docker/meteor

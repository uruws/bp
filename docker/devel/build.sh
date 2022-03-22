#!/bin/sh
set -eu
exec docker build "$@" --rm -t uws/buildpack:devel \
	-f docker/devel/Dockerfile.2203 \
	./docker/devel

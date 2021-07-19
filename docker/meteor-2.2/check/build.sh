#!/bin/sh
set -eu
exec docker build --rm -t uws/meteor-check:2.2 \
	--build-arg APP=star \
	-f ./docker/meteor-2.2/check/Dockerfile \
	./docker/meteor-2.2

#!/bin/sh
set -eu
exec docker build --rm -t uws/meteor-check:1.10.2 \
	--build-arg APP=star \
	-f ./docker/meteor-1.10.2/check/Dockerfile \
	./docker/meteor-1.10.2

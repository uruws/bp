#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/meteor-check:${app_tag} \
	--build-arg APP=meteor-check \
	-f ./docker/meteor-2.2/check/Dockerfile \
	./docker/meteor-2.2

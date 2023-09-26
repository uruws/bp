#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/meteor-check:${app_tag} \
	--build-arg APP=meteor-check \
	-f ./docker/meteor-devel/check/Dockerfile \
	./docker/meteor-devel

#!/bin/sh
set -eu
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
exec docker build --rm -t uws/${app}:${app_tag} \
	--build-arg APP=${app} \
	-f ./docker/meteor-1.10.2/check/Dockerfile ./docker/meteor-1.10.2

#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build $@ --rm -t uws/app:deploy-${app_tag} \
	--build-arg APP_TAG=${app_tag} \
	./deploy

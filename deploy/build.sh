#!/bin/sh
set -eu
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
exec docker build --rm -t uws/${app}:deploy-${app_tag} \
	--build-arg APP=${app} \
	--build-arg APP_NAME=${app} \
	--build-arg APP_NAME2=${app} \
	--build-arg APP_TAG=${app_tag} \
	./deploy

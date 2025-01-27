#!/bin/sh
set -eu
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
exec docker build --rm -t uws/${app}:install-${app_tag} \
	--build-arg APP=${app} \
	--build-arg APP_TAG=${app_tag} \
	./install

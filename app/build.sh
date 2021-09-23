#!/bin/sh
set -eu
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
if ! test -d ./${app}; then
	echo "${app}: invalid app name" >&2
	exit 9
fi
exec docker build --rm -t uws/${app}:${app_tag} \
	--build-arg APP=${app} ./${app}

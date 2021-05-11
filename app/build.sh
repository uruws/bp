#!/bin/sh
set -eu
app_src=${APP_SRC:-'src'}
app_tag=$(git -C app/${app_src} describe --tags | cut -d/ -f2)
exec docker build $@ --rm -t uws/app:${app_tag} \
	--build-arg APP_SRC=${app_src} \
	./app

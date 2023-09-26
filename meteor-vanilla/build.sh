#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/meteor-vanilla:${app_tag} \
	-f meteor-vanilla/Dockerfile \
	./meteor-vanilla

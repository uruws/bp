#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --rm -t uws/infra-ui:${app_tag} \
	-f infra-ui/Dockerfile.2203 \
	./infra-ui

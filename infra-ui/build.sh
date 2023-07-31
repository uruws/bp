#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
exec docker build --platform=linux/amd64 --rm -t uws/infra-ui:${app_tag} \
	-f infra-ui/Dockerfile \
	./infra-ui

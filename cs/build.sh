#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
# crowdsourcing
docker build --platform=linux/amd64 --rm -t uws/crowdsourcing:${app_tag} \
	-f cs/Dockerfile \
	./cs
exit 0

#!/bin/sh
set -eu
app_tag=${1:?'build tag?'}
# crowdsourcing
docker build --rm -t uws/crowdsourcing:${app_tag}
	-f cs/Dockerfile.2203 \
	./cs
exit 0

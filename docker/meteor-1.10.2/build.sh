#!/bin/sh
set -eu
# meteor-1.10.2
docker build "$@" --rm -t uws/meteor:1.10.2 ./docker/meteor-1.10.2
# meteor-1.10.2-2109
docker build "$@" --rm -t uws/meteor:1.10.2-2109 \
	-f ./docker/meteor-1.10.2/Dockerfile.2109 \
	./docker/meteor-1.10.2
exit 0

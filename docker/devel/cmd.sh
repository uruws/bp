#!/bin/sh
set -eu
CMD_ARGS=${CMD_ARGS:-""}
exec docker run "${CMD_ARGS}" --rm --name buildpack-devel \
	--hostname bpdev.uws.local \
	-v ${PWD}:/srv/deploy/Buildpack:ro \
	uws/buildpack:devel $@

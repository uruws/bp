#!/bin/sh
set -eu
CMD_ARGS=${CMD_ARGS:-""}
install -v -d -m 0750 ${PWD}/tmp
exec docker run ${CMD_ARGS} --rm --name buildpack-devel \
	--hostname bpdev.uws.local \
	--read-only \
	-v ${PWD}:/srv/deploy/Buildpack:ro \
	-v ${PWD}/tmp:/home/uws/tmp \
	uws/buildpack:devel $@

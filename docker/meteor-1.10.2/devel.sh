#!/bin/sh
exec docker run -it --rm --name uws-meteor-1102 \
	--hostname meteor-1102.uws.local -u uws \
	-v ${PWD}/docker/meteor-1.10.2/check:/home/uws/check \
	uws/meteor:1.10.2-2203 "$@"

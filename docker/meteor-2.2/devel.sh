#!/bin/sh
exec docker run -it --rm --name uws-meteor-22 \
	--hostname meteor-22.uws.local -u uws \
	-v ${PWD}/docker/meteor-2.2/check:/home/uws/check \
	uws/meteor:2.2-2203 "$@"

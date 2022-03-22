#!/bin/sh
exec docker run -it --rm --name uws-meteor-26 \
	--hostname meteor-26.uws.local -u uws \
	-v ${PWD}/docker/meteor-2.6/check:/home/uws/check \
	uws/meteor:2.6-2203 "$@"

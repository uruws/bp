#!/bin/sh
exec docker run -it --rm --name uws-meteor-devel \
	--hostname meteor-devel.uws.local -u uws \
	-v ${PWD}/docker/meteor-devel/check:/home/uws/check \
	uws/meteor:devel-2211 "$@"

#!/bin/sh
exec docker run -it --rm --name uws-meteor \
	--hostname meteor.uws.local -u uws \
	-v ${PWD}/docker/meteor/check:/home/uws/check \
	uws/meteor-2211 "$@"

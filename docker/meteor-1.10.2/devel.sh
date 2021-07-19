#!/bin/sh
exec docker run -it --rm --name uws-app-meteor \
	--hostname app-meteor.uws.local -u uws \
	-v ${PWD}/docker/meteor-1.10.2/check:/home/uws/check \
	uws/meteor:1.10.2 $@

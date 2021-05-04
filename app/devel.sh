#!/bin/sh
exec docker run -it --rm --name uws-app-devel \
	--hostname app-devel.uws.local -u uws \
	uws/app:source-meteor-1.10.2 $@

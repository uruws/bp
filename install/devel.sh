#!/bin/sh
exec docker run -it --rm --name uws-app-devel \
	--hostname app-devel.uws.local -u uws \
	uws/app:install-meteor-1.10.2 $@

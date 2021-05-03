#!/bin/sh
exec docker run -it --rm --network none --name uws-app-devel \
	--hostname app-devel.uws.local -u uws uws/app:meteor-install-1.10.2 $@

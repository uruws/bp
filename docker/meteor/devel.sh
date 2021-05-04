#!/bin/sh
exec docker run -it --rm --network none --name uws-app-meteor \
	--hostname app-meteor.uws.local -u uws uws/app:meteor-1.10.2 $@

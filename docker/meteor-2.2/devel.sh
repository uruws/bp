#!/bin/sh
exec docker run -it --rm --network none --name uws-meteor22 \
	--hostname meteor22.uws.local -u uws uws/app:meteor-2.2 $@

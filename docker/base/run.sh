#!/bin/sh
exec docker run -it --rm --network none --name uws-app-base \
	--hostname app-base.uws.local -u uws uws/buildpack:base-2305 "$@"

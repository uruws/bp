#!/bin/sh
app_tag=${1:?'build tag?'}
exec docker run -it --rm --name uws-meteor-vanilla-devel \
	--hostname meteor-vanilla-devel.uws.local -u uws \
	uws/meteor-vanilla:${app_tag} /bin/bash -l

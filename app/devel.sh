#!/bin/sh
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
exec docker run -it --rm --name uws-${app}-devel \
	--hostname ${app}-devel.uws.local -u uws \
	uws/${app}:${app_tag} $@

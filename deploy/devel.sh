#!/bin/sh
app_tag=$(git -C app/src describe --tags)
exec docker run -it --rm --name uws-app-devel \
	--hostname app-devel.uws.local -u uws \
	uws/app:deploy-${app_tag} $@

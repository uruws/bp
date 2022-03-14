#!/bin/sh
app_tag=${1:?'build tag?'}
exec docker run -it --rm --name uws-infra-ui-devel \
	--hostname infra-ui-devel.uws.local -u uws \
	uws/infra-ui:${app_tag} /bin/bash -l

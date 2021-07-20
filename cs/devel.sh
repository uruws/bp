#!/bin/sh
app_tag=${1:?'build tag?'}
exec docker run -it --rm --name uws-crowdsourcing-devel \
	--hostname crowdsourcing-devel.uws.local -u uws \
	uws/crowdsourcing:${app_tag} /bin/bash -l

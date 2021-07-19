#!/bin/sh
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
mkdir -vp ${PWD}/build/${app}/npm ${PWD}/build/${app}/tmp ${PWD}/build/${app}/local
chmod -v 1777 ${PWD}/build/${app}/npm ${PWD}/build/${app}/tmp ${PWD}/build/${app}/local
exec docker run -it --rm --name uws-${app}-devel \
	--hostname ${app}-devel.uws.local -u uws \
	-v ${PWD}/build/${app}/npm:/home/uws/.npm \
	-v ${PWD}/build/${app}/local:/home/uws/${app}/.meteor/local \
	-v ${PWD}/build/${app}/tmp:/tmp \
	-v ${PWD}/${app}/vendor/node_modules:/home/uws/${app}/node_modules \
	uws/${app}:bundle-${app_tag} $@

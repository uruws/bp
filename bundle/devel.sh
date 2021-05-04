#!/bin/sh
mkdir -vp ${PWD}/build/npm ${PWD}/build/tmp ${PWD}/build/local
chmod -v 1777 ${PWD}/build/npm ${PWD}/build/tmp ${PWD}/build/local
app_tag=$(git -C app/src describe --tags)
exec docker run -it --rm --name uws-app-devel \
	--hostname app-devel.uws.local -u uws \
	-v ${PWD}/build/npm:/home/uws/.npm \
	-v ${PWD}/build/local:/home/uws/app/.meteor/local \
	-v ${PWD}/build/tmp:/tmp \
	-v ${PWD}/app/vendor/node_modules:/home/uws/app/node_modules \
	uws/app:bundle-${app_tag} $@
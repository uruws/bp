#!/bin/sh
set -eux
app=${1:?'app name?'}

cd "/home/uws/${app}"

# App file to force re-generating the css at each build
if test -s ./client/build.css; then
	tmpfn=$(mktemp -p /tmp pre-install-client-build-css.XXXXXXXXXX)
	<./client/build.css sed "s/\[replaceThis\]/$(date '+%s')/" >"${tmpfn}"
	rm -f "${tmpfn}"
fi

exit 0

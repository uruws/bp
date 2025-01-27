#!/bin/sh
set -eu
nice ionice make check
if ! git remote | grep -q deploy; then
	git remote add deploy uws@ops.uws.talkingpts.org:/srv/deploy/Buildpack.git
fi
git push
git push --tags
git push deploy
git push --tags deploy
exit 0

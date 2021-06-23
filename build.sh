#!/bin/sh
set -eu
version=${1:?'build version?'}
cd /srv/deploy/Buildpack
git -C app/src pull
git -C app/src checkout ${version}
make app
make publish-app
exit 0

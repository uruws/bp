#!/bin/sh
set -eu
version=${1:?'build version?'}
cd /srv/deploy/Buildpack
git -C app/src fetch --tags --prune --prune-tags
git -C app/src checkout ${version}
make app
make publish-app
exit 0

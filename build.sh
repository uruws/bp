#!/bin/sh
set -eu
version=${1:?'build version?'}
app=${2:-'src'}
t_start=$(date '+%s')
cd /srv/deploy/Buildpack
git -C app/${app} fetch --tags --prune --prune-tags
git -C app/${app} checkout ${version}
target='app'
if test "X${app}" != 'src'; then
	target=${app}
fi
make ${target}
make publish-${target}
t_stop=$(date '+%s')
echo "Build ${target} version ${version}, done in $(expr ${t_stop} - ${t_start})s."
exit 0

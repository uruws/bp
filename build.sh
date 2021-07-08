#!/bin/sh
set -eu

version=${1:?'build version?'}
app=${2:-'NOSET'}

if test "X${app}" = 'XNOSET'; then
	app='src'
else
	shift
fi

export TEST_FLAGS="$@"

case ${app} in
	--*)
		app='src'
	;;
esac

target='app'
if test "X${app}" != 'Xsrc'; then
	target=${app}
fi

cd /srv/deploy/Buildpack

t_start=$(date '+%s')

git -C app/src fetch --tags --prune --prune-tags
git -C app/src checkout ${version}

make ${target}
make publish-${target}

t_stop=$(date '+%s')
echo "Build ${target} version ${version}, done in $(expr ${t_stop} - ${t_start})s."

exit 0

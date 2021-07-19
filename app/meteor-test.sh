#!/bin/sh
set -eu
cd ${HOME}/${APP}
if test -s ./test.sh; then
	exec /bin/sh -eu ./test.sh
fi
echo "No tests to run!"
exit 0

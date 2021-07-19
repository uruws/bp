#!/bin/sh
set -e
test_flags="${TEST_FLAGS}"
case ${test_flags} in
	--no-test)
		echo "Ignore tests!!"
		exit 0
	;;
esac
set -u
app=${1:?'app name?'}
app_tag=${2:?'build tag?'}
exec docker run -it --rm -u uws uws/${app}:${app_tag} /home/uws/test.sh

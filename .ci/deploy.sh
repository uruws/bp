#!/bin/sh
set -eu

make bootstrap

covd=/srv/www/ssl/htmlcov
if test -d "${covd}"; then
	rm -rf ${covd}/buildpack
	if test -d ./tmp/htmlcov; then
		cp -r ./tmp/htmlcov ${covd}/buildpack
	fi
fi

exit 0

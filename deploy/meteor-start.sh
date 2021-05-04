#!/bin/sh
set -eu

cd /opt/app/bundle

# phantomjs workaround
export OPENSSL_CONF=/tmp/fake-openssl.cnf

echo "--- DEBUG start"

echo "--- user"
id -a

echo "--- env"
env | sort

echo "--- node"
node --version

appenv=/run/meteor/app.env
echo "--- ${appenv}"
if ! test -s ${appenv}; then
	echo "${appenv}: file not found" >&2
	exit 1
fi
ls -lh ${appenv}
tail ${appenv}

echo "--- DEBUG end"

. ${appenv}
exec node main.js

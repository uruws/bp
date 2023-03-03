#!/bin/sh

if test -n "${DISABLE_JOBS}"; then
	export DISABLE_JOBS="${DISABLE_JOBS}"
	echo "DISABLE_JOBS=${DISABLE_JOBS}"
fi

set -eu

#cd /opt/${APP}/bundle

# phantomjs workaround
export OPENSSL_CONF=/var/tmp/fake-openssl.cnf

echo "--- DEBUG start"

echo "--- user"
id -a

echo "--- env"
env

echo "--- node"
node --version

appenv=/run/meteor/app.env
echo "--- ${appenv}"
if ! test -s ${appenv}; then
	echo "${appenv}: file not found" >&2
	exit 1
fi
ls -lhL ${appenv}

echo "--- ${appenv} override"
# stop using sockjs (use websocket instead)
export DISABLE_SOCKJS=1

echo "--- DEBUG end"

# shellcheck disable=SC1090
. ${appenv}

echo "--- INFO start"

echo "ROOT_URL=${ROOT_URL}"
echo "PORT=${PORT}"
echo "DISABLE_SOCKJS=${DISABLE_SOCKJS}"

echo "--- INFO end"

if test -s /run/meteor/app-settings.json; then
	echo "--- METEOR_SETTINGS start"
	METEOR_SETTINGS=$(/usr/local/bin/meteor-settings.sh)
	export METEOR_SETTINGS
	echo "--- METEOR_SETTINGS end"
fi

exec node main.js

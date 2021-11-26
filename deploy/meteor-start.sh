#!/bin/sh

echo "--- DEBUG start"

if test -n "${DISABLE_JOBS}"; then
	export DISABLE_JOBS="${DISABLE_JOBS}"
	echo "DISABLE_JOBS=${DISABLE_JOBS}"
fi

set -eu

#cd /opt/${APP}/bundle

# phantomjs workaround
export OPENSSL_CONF=/var/tmp/fake-openssl.cnf

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
ls -lhL ${appenv}

echo "--- DEBUG end"

# shellcheck disable=SC1090
. ${appenv}

echo "--- INFO start"

echo "ROOT_URL=${ROOT_URL}"
echo "PORT=${PORT}"

echo "--- INFO end"

exec node main.js

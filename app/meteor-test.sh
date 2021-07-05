#!/bin/sh
set -eu
cd ${HOME}/app
exec meteor test --once --driver-package meteortesting:mocha \
	--settings settings.json --port 3017

#!/bin/sh
set -eu
ROOT_URL=${ROOT_URL:-'http://localhost:3000/'}
exec docker build $@ --rm -t uws/app:meteor-install-1.10.2
	--build-arg ROOT_URL=${ROOT_URL}
	./app

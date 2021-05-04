#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/app:install-meteor-1.10.2 ./app

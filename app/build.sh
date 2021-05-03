#!/bin/sh
set -eu
exec docker build $@ --rm -t uws/app:meteor-install-1.10.2 ./app
